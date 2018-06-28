<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="com.nbp.simsns.vo.PostVO"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>SIMSNS 게시판</title>
	<!-- Bootstrap core CSS-->
	<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom fonts for this template-->
	<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<!-- Page level plugin CSS-->
	<link href="resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
	<!-- Custom styles for this template-->
	<link href="resources/css/sb-admin.min.css" rel="stylesheet">
	<link href="resources/simsns/css/simsns.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		const COMMENT_ROOT = 0;
		var updatingCommentContainer = null;
		var updatingCommentUpdateContainer = null;
		var showError = true;
		var searchTotal = 0;
		var searchIndex = 0;
		var index = 0;
		var commentIndex = 0;
		var likeIndex = 0;
		var pictureIndex = 0;
		var postList = ${postList};
		var commentList = ${commentList};
		var likeList = ${likeList};
		var pictureList = ${pictureList};
		var goToPostTimestamp = "${goToPostTimestamp}";
		var goToPostNo = "${goToPostNo}";
		var loadedImgNum = 0;
		var openedCommentWriter = null;
		var errorsExist = true;
		window.onload=function() {
			if(goToPostTimestamp != '' && goToPostNo != '') {
				offset = $('#' + goToPostTimestamp + goToPostNo).offset();
				$('body, html').animate({scrollTop : offset.top}, 300);
			} else {
			    setTimeout(function() {
			        scrollTo(0,-1);
			    },0);
			}
		}
		function deletePost(post) {
			if(confirm("정말 삭제하시겠습니까?") == true) {
				post.submit();
			} else {
				return;
			}
		}
		function updatePost(post) {
			post.action = "update";
			post.submit();
		}
		function deleteComment(comment) {
			if(confirm("정말 삭제하시겠습니까?") == true) {
				comment.submit();
			} else {
				return;
			}
		}
		function updateComment(commentContainer, commentUpdateContainer) {
			if(showError == false) {
				[].forEach.call(document.getElementsByClassName('errors'), function (obj, index) {
					obj.style.display = 'none';
				});
			}
			showError = false;
			if(openedCommentWriter != null) {
				openedCommentWriter.css('display', 'none');
				openedCommentWriter.find('textarea').val('');
				openedCommentWriter = null;
			}
			if(updatingCommentContainer != null && updatingCommentUpdateContainer != null) {
				$(updatingCommentUpdateContainer).find('textarea').val(updatingCommentContainer.getElementsByClassName('commentContent')[0].textContent);
				updatingCommentContainer.style.display = 'block';
				updatingCommentUpdateContainer.style.display = 'none';
			}
			updatingCommentContainer = commentContainer;
			updatingCommentUpdateContainer = commentUpdateContainer;
			commentContainer.style.display = 'none';
			commentUpdateContainer.style.display = 'block';
		}
		function updateCommentCancel(commentContainer, commentUpdateContainer, commentIndex) {
			updatingCommentContainer = null;
			updatingCommentUpdateContainer = null;
			commentContainer.style.display = 'block';
			commentUpdateContainer.style.display = 'none';
			$('#coCommentUpdateForm' + commentIndex + ' textarea').val(
					commentContainer.getElementsByClassName('commentContent')[0].textContent);
		}
		function imgOnLoad() {
			loadedImgNum++;
		}
		function imgOnError() {
			loadedImgNum++;
		}
		function addLike(postNo, postTimestamp, commentNo, commentTimestamp, commentDepth) {
			$.ajax({
				cache : false,
		        type : "GET",
		        url : "addLike?postNo=" + postNo + "&postTimestamp=" + postTimestamp
		        		+ "&commentNo=" + commentNo + "&commentTimestamp=" + commentTimestamp +"&commentDepth=" + commentDepth,
		        dataType : "json",
		        contentType: "application/json",
		        error : function(jqXHR,request, error) {
		            alert('통신실패!!');
		            console.log(jqXHR);
					console.log(request);
					console.log(JSON.stringify(error));
		        },
		        success : function(data) {
		        	if(data.response == 'success') {
						$("#like" + postTimestamp + postNo + commentDepth
							+ commentTimestamp + commentNo)
								.append('${sessionScope.userName}<br>');
						$("#likeCount" + postTimestamp + postNo + commentDepth
							+ commentTimestamp + commentNo)
								.html(Number($("#likeCount" + postTimestamp + postNo + commentDepth
									+ commentTimestamp + commentNo).html()) + 1);
		        	} else {
		        		alert('한 번만 가능합니다.');
		        	}
		        }
		    });
		}
		function commentWriterToggle(id) {
			if(errorsExist == false) {
				$('.errors').css('display', 'none');
			}
			errorsExist = false;
			if(updatingCommentContainer != null && updatingCommentUpdateContainer != null) {
				$(updatingCommentContainer).css('display', 'block');
				$(updatingCommentUpdateContainer).css('display', 'none');
				$(updatingCommentUpdateContainer).find('textarea').val(updatingCommentContainer.getElementsByClassName('commentContent')[0].textContent);
				updatingCommentContainer = null;
				updatingCommentUpdateContainer = null;
			}
			if(openedCommentWriter != null) {
				openedCommentWriter.css('display', 'none');
				openedCommentWriter.find('textarea').val('');
				if(openedCommentWriter[0] == $('#' + id)[0]) {
					openedCommentWriter = null;
				} else {
					openedCommentWriter = $('#' + id);
					openedCommentWriter.css('display', 'block');
				}
			} else {
				openedCommentWriter = $('#' + id);
				openedCommentWriter.css('display', 'block');
			}
		}
		function addPost() {
			$("#posts").append('<div id="' + postList[index].postTimestamp + postList[index].postNo + '" class="card mb-3">'
								+ '<div class="card-body">'
								+ (
										("${sessionScope.userID}" == postList[index].userEmailGuest) ?
											'<form id="form' + index + '" action="deletePost" method="post">'
											+ '<button class="close post-close" type="button" onclick="deletePost(form' + index + ')">'
											+ '<i class="fa fa-fw fa-close"></i>'
											+ '</button>'
											+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
											+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
											+ '</form>'
											+ '<a class="mr-2 close post-close" href="update?postTimestamp='
											+ postList[index].postTimestamp + '&postNo=' + postList[index].postNo + '">'
											+ '<i class="fa fa-fw fa-pencil"></i>'
											+ '</a>'
											: ''
								)
								+ '<h6 class="card-title mb-1 post-title-big">' + postList[index].postTitle + '</h6>'
								+ '</div>'
								+ '<hr class="my-0">'
								+ (
										(pictureList[pictureIndex] != undefined
											&& pictureList[pictureIndex].postTimestamp == postList[index].postTimestamp
											&& pictureList[pictureIndex].postNo == postList[index].postNo) ?
												/* '<img class="card-img-top img-fluid w-100" src="resources/picture/' + pictureList[pictureIndex++].picturePath + '"' */
												'<img class="card-img-top img-fluid w-100" src="/home1/irteam/resources/picture/' + pictureList[pictureIndex++].picturePath + '"'
												+ 'onload="imgOnLoad()" onerror="imgOnError()"><br>'
												: ''
								)
								+ '<div class="card-body">'
								+ '<form action="boardMove" method="post" name="friend' + postList[index].postTimestamp + postList[index].postNo + '">'
								+ '<input type="hidden" value="' + postList[index].userEmailGuest + '" name="userEmail">'
								+ '<input type="hidden" value="' + postList[index].userNameGuest + '" name="userName">'
								+ '<input type="hidden" value="' + '">'
								+ '</form>'
								+ '<h6 class="card-title mb-1 small"><a class="font-color-simsns-dark" href="javascript:;" onclick="document.friend' + postList[index].postTimestamp + postList[index].postNo + '.submit()">'
								+ '<i class="fa fa-fw fa-user-circle"></i>' + postList[index].userNameGuest + '</a></h6>'
								+ '<p class="card-text small post-content">' + postList[index].postContent + '</p>'
								+ '</div>'
								+ '<hr class="my-0">'
								+ '<div class="card-body py-2 small">'
								+ '<a class="mr-1 d-inline-block font-color-simsns" href="javascript:;" onclick="addLike('
								+ postList[index].postNo + ', ' + postList[index].postTimestamp + ', '
								+ COMMENT_ROOT + ', ' + COMMENT_ROOT + ', ' + COMMENT_ROOT + ')">'
								+ '<i class="fa fa-fw fa-thumbs-up"></i>Like</a>'
								+ '<a class="font-color-simsns" href="javascript:;">'
								+ '<div class="tooltip-simsns mr-3">'
								+ '<span id="likeCount' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '">0</span>'
								+ '<span class="tooltiptext" id="like' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '"></span></div>'
								+ '</a>'
								+ '<a class="mr-3 d-inline-block font-color-simsns" href="javascript:;" onclick="commentWriterToggle(\'commentWriter' + index + '\')">'
								+ '<i class="fa fa-fw fa-comment"></i>Comment</a>'
								+ '</div>'
								+ '<div class="card-body small bg-faded comment-writer" id="commentWriter' + index + '">'
								+ '<form id="commentForm' + index + '" action="writeComment" method="post">'
								+ '<textarea class="rounded comment-textarea" name="commentContent"></textarea>'
								+ '<button type="submit" class="align-right write-btn"><i class="fa fa-fw fa-pencil"></i></button>'
								+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
								+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
								+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentNoParent" id="commentNoParent">'
								+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentTimestampParent" id="commentTimestampParent">'
								+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentDepth" id="commentDepth">'
								+ (
										("${comment.postNo}" == postList[index].postNo && "${comment.postTimestamp}" == postList[index].postTimestamp
											&& "${comment.commentNoParent}" == COMMENT_ROOT
											&& "${comment.commentTimestampParent}" == COMMENT_ROOT
											&& "${commentUpdateError}" != "true") ?
												'<form:errors path="commentVO.commentContent" class="errors text-danger"></form:errors>'
												: ''
								)
								+ '</form>'
								+ '</div>'
								+ '<hr class="my-0">'
								+ '<div class="card-body" style="margin-left:' + 30 * (1 + COMMENT_ROOT) + 'px" id="comment' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '"></div>'
								+ '<div class="card-footer small text-muted">' + new Date(Number(postList[index].postTimestamp)).toLocaleTimeString("ko-kr", {
									    weekday: "long", year: "numeric", month: "short",
									    day: "numeric", hour: "2-digit", minute: "2-digit"
									}) + ' 작성</div>'
								+ '</div>'
			);
			
			if("${comment.postNo}" == postList[index].postNo && "${comment.postTimestamp}" == postList[index].postTimestamp
					&& "${comment.commentNoParent}" == COMMENT_ROOT
					&& "${comment.commentTimestampParent}" == COMMENT_ROOT
					&& "${commentUpdateError}" != "true") {
				commentWriterToggle('commentWriter' + index);
			}
			
			for(; (commentList[commentIndex] != undefined && commentList[commentIndex].postTimestamp == postList[index].postTimestamp &&
					commentList[commentIndex].postNo == postList[index].postNo); commentIndex++) {
				comment = commentList[commentIndex];
				$("#comment" + postList[index].postTimestamp + postList[index].postNo + comment.commentDepth
					+ comment.commentTimestampParent + comment.commentNoParent)
					.append('<div id="' + comment.postTimestamp + comment.postNo + comment.commentTimestamp + comment.commentNo + '">'
							+ '<div id="commentContainer' + commentIndex + '">'
							+ '<span class="mr-4 comment-subtree small">└</span><span class="small">' + new Date(Number(comment.commentTimestamp)).toLocaleTimeString("ko-kr", {
								    weekday: "long", year: "numeric", month: "short",
								    day: "numeric", hour: "2-digit", minute: "2-digit"
								}) + '</span>'
							+ (
									("${sessionScope.userID}" == comment.userEmailGuest) ?
										'<button class="mr-2 ml-2 close comment-btn" type="button" onclick="updateComment(commentContainer' + commentIndex + ', commentUpdateContainer' + commentIndex + ')">'
										+ '<i class="fa fa-fw fa-pencil"></i>'
										+ '</button>'
										+ '<button class="close comment-btn" type="button" onclick="deleteComment(comment' + commentIndex + ')">'
										+ '<i class="fa fa-fw fa-close"></i>'
										+ '</button>'
										+ '<form id="comment' + commentIndex + '" action="deleteComment" method="post">'
										+ '<input type="hidden" value="' + comment.postNo + '" name="postNo" id="postNo">'
										+ '<input type="hidden" value="' + comment.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
										+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo" id="commentNo">'
										+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp" id="commentTimestamp">'
										+ '</form>'
										: ''
							)
							+ '<form action="boardMove" method="post" name="friend' + commentIndex + '">'
							+ '<input type="hidden" value="' + comment.userEmailGuest + '" name="userEmail">'
							+ '<input type="hidden" value="' + comment.userNameGuest + '" name="userName">'
							+ '<input type="hidden" value="' + '">'
							+ '</form>'
							+ '<h6 class="card-title mb-1 small"><a class="font-color-simsns-dark" href="javascript:;" onclick="document.friend' + commentIndex + '.submit()">'
							+ '<i class="fa fa-fw fa-user-circle"></i>' + comment.userNameGuest + '</a></h6>'
							+ '<p class="card-text small comment-content commentContent">' + comment.commentContent + '</p>'
							+ '<a class="mr-1 d-inline-block font-color-simsns small" href="javascript:;" onclick="addLike('
							+ comment.postNo + ', ' + comment.postTimestamp + ', '
							+ comment.commentNo + ', ' + comment.commentTimestamp + ', ' + comment.commentDepth + ')">'
							+ '<i class="fa fa-fw fa-thumbs-up"></i>Like</a>'
							+ '<a class="font-color-simsns" href="javascript:;">'
							+ '<div class="tooltip-simsns mr-3">'
							+ '<span id="likeCount' + comment.postTimestamp + comment.postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '">0</span>'
							+ '<span class="tooltiptext" id="like' + comment.postTimestamp + comment.postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '"></span></div>'
							+ '</a>'
							+ '<a class="mr-3 d-inline-block font-color-simsns small" href="javascript:;" onclick="commentWriterToggle(\'coCommentWriter' + commentIndex + '\')">'
							+ '<i class="fa fa-fw fa-comment"></i>Comment</a>'
							+ '</div>'
							+ '<div id="commentUpdateContainer' + commentIndex + '" style="display:none">'
							+ '<form id="coCommentUpdateForm' + commentIndex + '" action="updateComment" method="post">'
							+ '<textarea class="rounded comment-textarea" style="margin-left:' + (-30 * comment.commentDepth) + 'px!important;width:calc(100% + ' + (30 * comment.commentDepth) + 'px)" name="commentContent">' + comment.commentContent + '</textarea>'
							+ (
									("${comment.postNo}" == postList[index].postNo && "${comment.postTimestamp}" == postList[index].postTimestamp
										&& "${comment.commentNo}" == comment.commentNo
										&& "${comment.commentTimestamp}" == comment.commentTimestamp
										&& "${commentUpdateError}" == "true")?
											'<form:errors path="commentVO.commentContent" class="errors text-danger"></form:errors>'
											: ''
							)
							+ '<button type="submit" class="align-right write-btn"><i class="fa fa-fw fa-pencil"></i></button>'
							+ '<button type="button" class="align-right mr-1 write-btn" onclick="updateCommentCancel(commentContainer' + commentIndex + ', commentUpdateContainer' + commentIndex + ', ' + commentIndex + ')">'
							+ '<i class="fa fa-fw fa-close"></i>'
							+ '</button>'
							+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
							+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
							+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo" id="commentNo">'
							+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp" id="commentTimestamp">'
							+ '<input type="hidden" value="' + comment.commentDepth + '" name="commentDepth" id="commentDepth">'
							+ '</form><br>'
							+ '</div>'
							+ '<div class="card-body small bg-faded comment-writer" id="coCommentWriter' + commentIndex + '">'
							+ '<form id="coCommentForm' + commentIndex + '" action="writeComment" method="post">'
							+ '<textarea class="rounded comment-textarea" style="margin-left:' + (-30 * comment.commentDepth) + 'px!important;width:calc(100% + ' + (30 * comment.commentDepth) + 'px)" name="commentContent"></textarea>'
							+ '<button type="submit" class="align-right write-btn"><i class="fa fa-fw fa-pencil"></i></button>'
							+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
							+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
							+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNoParent" id="commentNoParent">'
							+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestampParent" id="commentTimestampParent">'
							+ '<input type="hidden" value="' + (Number(comment.commentDepth) + 1) + '" name="commentDepth" id="commentDepth">'
							+ (
									("${comment.postNo}" == postList[index].postNo && "${comment.postTimestamp}" == postList[index].postTimestamp
										&& "${comment.commentNoParent}" == comment.commentNo
										&& "${comment.commentTimestampParent}" == comment.commentTimestamp
										&& "${commentUpdateError}" != "true") ?
											'<form:errors path="commentVO.commentContent" class="errors text-danger"></form:errors>'
											: ''
							)
							+ '</form></div>'
							+ '<hr class="my-0">'
							+ '<div style="margin-left:' + 30 + 'px" id="comment' + postList[index].postTimestamp + postList[index].postNo + (Number(comment.commentDepth) + 1) + comment.commentTimestamp + comment.commentNo + '"></div>'
							+ '</div>'
				);
				if("${comment.postNo}" == postList[index].postNo && "${comment.postTimestamp}" == postList[index].postTimestamp
						&& "${comment.commentNoParent}" == comment.commentNo
						&& "${comment.commentTimestampParent}" == comment.commentTimestamp
						&& "${commentUpdateError}" != "true") {
					commentWriterToggle('coCommentWriter' + commentIndex);
				}
				if("${comment.postNo}" == postList[index].postNo && "${comment.postTimestamp}" == postList[index].postTimestamp
						&& "${comment.commentNo}" == comment.commentNo
						&& "${comment.commentTimestamp}" == comment.commentTimestamp
						&& "${commentUpdateError}" == "true") {
					updateComment($("#commentContainer" + commentIndex).get(0), $("#commentUpdateContainer" + commentIndex).get(0));
				}
			}
			
			for(; (likeList[likeIndex] != undefined && likeList[likeIndex].postTimestamp == postList[index].postTimestamp &&
					likeList[likeIndex].postNo == postList[index].postNo); likeIndex++) {
				like = likeList[likeIndex];
				$("#like" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
					+ like.commentTimestamp + like.commentNo)
					.append(like.userNameGuest + '<br>');
				$("#likeCount" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
					+ like.commentTimestamp + like.commentNo)
					.html(Number($("#likeCount" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
						+ like.commentTimestamp + like.commentNo).html()) + 1);
			}
		}
		$(document).ready(function() {
			postList.some(function(post, i) {
				addPost();
				if($("body").height() > $(window).height() && goToPostTimestamp == '' && goToPostNo == '') {
					return (index == index);
				} else if(post.postTimestamp == goToPostTimestamp && post.postNo == goToPostNo) {
					return (index == index);
				}
				index++;
			});
			index++;
			
			$(window).resize(function() {
				while($("body").height() <= $(window).height()) {
					if(index < postList.length) {
						addPost();
						index++;
					} else {
						break;
					}
				}
			});
			
			$(window).scroll(function() {
				if ($(window).scrollTop() + 1 >= $(document).height() - $(window).height()) {
					if(index < postList.length) {
						addPost();
						index++;
					}
				}
			});
		});
		function searchEnter(event) {
			if (event.keyCode === 13) {
				event.preventDefault();
				$('#searchButton').click();
			}
		}
		function searchKindChange() {
			selected = $('#searchKind').val();
			if(selected == 'post') {
				$('#searchPostRange').show();
				$('#searchCommentRange').hide();
			} else if(selected == 'comment') {
				$('#searchCommentRange').css('display', 'block');
				$('#searchPostRange').hide();
			}
		}
		function search(order) {
			if(order == 'first') {
				searchTotal = 0;
				searchIndex = 0;
				searchKind = $('#searchKind').val();
				searchKeyword = $('#searchKeyword').val();
				if(searchKeyword == '') {
					alert('검색어를 입력하세요');
					$('#storedSearchKeyword').val('');
	        		$('#searchResult span').html('');
	        		$('#searchResult').css('display', 'none');
					return;
				}
			} else if(order == 'next') {
				if(searchIndex + 1 == searchTotal) {
					alert('마지막입니다.');
					return;
				}
				searchIndex++;
				searchKind = $('#storedSearchKind').val();
				searchKeyword = $('#storedSearchKeyword').val();
			} else if(order == 'previous') {
				if(searchIndex == 0) {
					alert('처음입니다.');
					return;
				}
				searchIndex--;
				searchKind = $('#storedSearchKind').val();
				searchKeyword = $('#storedSearchKeyword').val();
			}
			if(searchKind == 'post') {
				if(order == 'first') {
					searchRange = $('#searchPostRange').val();
				} else {
					searchRange = $('#storedSearchRange').val();
				}
				$.ajax({
					cache : false,
			        type : "GET",
			        url : "searchPost?searchRange=" + searchRange + "&searchKeyword=" + searchKeyword
			        		+ "&searchIndex=" + searchIndex,
			        dataType : "json",
			        contentType: "application/json",
			        error : function() {
			            alert('통신실패!!');
			            $('#searchResult').css('display', 'none');
			        },
			        success : function(data) {
			        	if(data.result == null) {
			        		alert('검색 결과가 없습니다.');
			        		$('#storedSearchKeyword').val('');
			        		$('#searchResult span').html('');
			        		$('#searchResult').css('display', 'none');
			        		return;
			        	}
			        	$('#searchResult span').html((searchIndex + 1) + '/' + data.total);
			        	searchTotal = data.total;
			        	$('#storedSearchKind').val(searchKind);
			        	$('#storedSearchRange').val(searchRange);
			        	$('#storedSearchKeyword').val(searchKeyword);
			        	if(!$('#' + data.result.postTimestamp + data.result.postNo).length) {
				        	while(true) {
				        		if(postList[index] == undefined) {
				        			break;
				        		}
				        		addPost();
				        		if(postList[index].postTimestamp == data.result.postTimestamp && postList[index].postNo == data.result.postNo) {
				        			index++;
				        			break;
				        		}
				        		index++;
				        	}
			        	}
			        	if(loadedImgNum == $('#posts').find('img').length) {
		        			var offset = $('#' + data.result.postTimestamp + data.result.postNo).offset();
		        			$('body, html').animate({scrollTop : offset.top}, 300);
		        		} else {
				        	$('#posts').find('img').load(function() {
				        		if(loadedImgNum == $('#posts').find('img').length) {
				        			var offset = $('#' + data.result.postTimestamp + data.result.postNo).offset();
				        			$('body, html').animate({scrollTop : offset.top}, 300);
				        		}
				        	}).error(function() {
				        		if(loadedImgNum == $('#posts').find('img').length) {
				        			var offset = $('#' + data.result.postTimestamp + data.result.postNo).offset();
				        			$('body, html').animate({scrollTop : offset.top}, 300);
				        		}
				        	});
		        		}
			        	$('#searchResult').css('display', 'block');
			        }
			    });
			} else if(searchKind == 'comment') {
				if(order == 'first') {
					searchRange = $('#searchCommentRange').val();
				} else {
					searchRange = $('#storedSearchRange').val();
				}
				$.ajax({
			        type : "GET",
			        url : "searchComment?searchRange=" + searchRange + "&searchKeyword=" + searchKeyword
			        		+ "&searchIndex=" + searchIndex,
			        dataType : "json",
			        contentType: "application/json",
			        error : function(){
			            alert('통신실패!!');
			            $('#searchResult').css('display', 'none');
			        },
			        success : function(data) {
			        	if(data.result == null) {
			        		alert('검색 결과가 없습니다.');
			        		$('#storedSearchKeyword').val('');
			        		$('#searchResult span').html('');
			        		$('#searchResult').css('display', 'none');
			        		return;
			        	}
			        	$('#searchResult span').html((searchIndex + 1) + '/' + data.total);
			        	searchTotal = data.total;
			        	$('#storedSearchKind').val(searchKind);
			        	$('#storedSearchRange').val(searchRange);
			        	$('#storedSearchKeyword').val(searchKeyword);
			        	if(!$('#' + data.result.postTimestamp + data.result.postNo + data.result.commentTimestamp + data.result.commentNo).length) {
				        	while(true) {
				        		if(postList[index] == undefined) {
				        			break;
				        		}
				        		addPost();
				        		if(postList[index].postTimestamp == data.result.commentTimestampParent
				        				&& postList[index].postNo == data.result.commentNoParent) {
				        			index++;
				        			break;
				        		}
				        		index++;
				        	}
			        	}
			        	if(loadedImgNum == $('#posts').find('img').length) {
			        		var offset = $('#' + data.result.postTimestamp + data.result.postNo + data.result.commentTimestamp + data.result.commentNo).offset();
		        			$('body, html').animate({scrollTop : offset.top}, 300);
		        		} else {
				        	$('#posts').find('img').load(function() {
				        		if(loadedImgNum == $('#posts').find('img').length) {
				        			var offset = $('#' + data.result.postTimestamp + data.result.postNo + data.result.commentTimestamp + data.result.commentNo).offset();
				        			$('body, html').animate({scrollTop : offset.top}, 300);
				        		}
				        	}).error(function() {
				        		if(loadedImgNum == $('#posts').find('img').length) {
				        			var offset = $('#' + data.result.postTimestamp + data.result.postNo + data.result.commentTimestamp + data.result.commentNo).offset();
				        			$('body, html').animate({scrollTop : offset.top}, 300);
				        		}
				        	});
		        		}
			        	$('#searchResult').css('display', 'block');
			        }
			    });
			}
		}
	</script>
</head>
<body class="fixed-nav sticky-footer bg-gray" id="page-top">
	<nav class="navbar navbar-expand-lg navbar-dark bg-simsns fixed-top out" id="mainNav">
		<a class="navbar-brand" href="/simsns/">SIMSNS</a>
		<div class="board-title-text">${sessionScope.hostName} 의 게시판</div>
		<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav navbar-sidenav side-navbar" id="exampleAccordion">
				<li class="nav-item nav-item-simsns" data-toggle="tooltip" data-placement="right" title="mainBoard">
					<a class="nav-link" href="board">
						<i class="fa fa-fw fa-newspaper-o"></i>
						<span class="nav-link-text">게시판</span>
					</a>
				</li>
				<li class="nav-item nav-item-simsns" data-toggle="tooltip" data-placement="right" title="picture">
					<a class="nav-link" href="picture">
						<i class="fa fa-fw fa-picture-o"></i>
						<span class="nav-link-text">사진</span>
					</a>
				</li>
			</ul>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item space-right-2">
					<div id="searchResult" style="display:none;">
						<input class="btn-simsns btn btn-primary" type="button" value="이전" onclick="search('previous')">
						<span class="font-color-simsns-dark"></span>
						<input class="btn-simsns btn btn-primary" type="button" value="다음" onclick="search('next')">
						<input class="" type="hidden" id="storedSearchKind" value="">
						<input class="" type="hidden" id="storedSearchKeyword" value="">
						<input class="" type="hidden" id="storedSearchRange" value="">
					</div>
				</li>
	      		<li class="nav-item space-right-2">
					<select class="form-control form-control-small" id="searchKind" onchange="searchKindChange()">
						<option class="form-control form-control-small" value="post">게시물</option>
						<option class="form-control form-control-small" value="comment">댓글</option>
					</select>
					<select class="form-control form-control-small space-top-2" id="searchPostRange">
						<option class="form-control form-control-small" value="title">제목</option>
						<option class="form-control form-control-small" value="content">내용</option>
						<option class="form-control form-control-small" value="writer">작성자</option>
						<option class="form-control form-control-small" value="titleContent">제목+내용</option>
					</select>
					<select class="form-control form-control-small init-hide space-top-2" id="searchCommentRange">
						<option class="form-control form-control-small" value="content">내용</option>
						<option class="form-control form-control-small" value="writer">작성자</option>
					</select>
	      		</li>
				<li class="nav-item">
					<form class="form-inline my-2 my-lg-0 mr-lg-2">
						<div class="input-group">
							<input id="searchKeyword" class="form-control" type="text" placeholder="검색어를 입력하세요" onkeydown="searchEnter(event)">
							<span class="input-group-append">
								<button id="searchButton" class="btn-simsns btn btn-primary" type="button" onclick="search('first')">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
					</form>
				</li>
				<li class="nav-item">
					<div class="vertical-container">
						<form action="boardMove" method="post" name=myBoardFrom>
							<input type="hidden" value="${sessionScope.userID}" name="userEmail">
							<input type="hidden" value="${sessionScope.userName}" name="userName">
						</form>
						<a class="nav-link small-text vertical-content" href="javascript:;" onclick="javascript:document.myBoardFrom.submit();">
							${sessionScope.userName}님
						</a>
						<span class="small-text vertical-content">
							환영합니다
						</span>
					</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="modal" data-target="#logoutModal">
						<i class="fa fa-fw fa-sign-out"></i>로그아웃</a>
				</li>
			</ul>
		</div>
	</nav>
	<div class="content-wrapper content-wrapper-simsns">
		<c:if test="${sessionScope.userID == null}">
			<script type="text/javascript">
				alert('로그인 후 이용해주세요.');
				location.href = '/simsns/';
			</script>
		</c:if>
		<a class="btn btn-simsns-write" href="write">글쓰기</a>
		<div id="posts" class="post-wrapper-simsns">
			<div class="mb-0 mt-4">
				<i class="fa fa-newspaper-o"></i> 게시판
			</div>
			<hr class="mt-2">
		</div>
		
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top">
			<i class="fa fa-angle-up"></i>
		</a>
		
		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">x</span>
						</button>
					</div>
					<div class="modal-body">로그아웃 하시겠습니까?</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
						<a class="btn btn-primary bg-simsns" href="logout">로그아웃</a>
					</div>
				</div>
			</div>
		</div>
    
		<!-- Bootstrap core JavaScript-->
		<!-- <script src="resources/vendor/jquery/jquery.min.js"></script> -->
		<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
		<!-- Core plugin JavaScript-->
		<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
		<!-- Page level plugin JavaScript-->
		<script src="resources/vendor/chart.js/Chart.min.js"></script>
		<script src="resources/vendor/datatables/jquery.dataTables.js"></script>
		<script src="resources/vendor/datatables/dataTables.bootstrap4.js"></script>
		<!-- Custom scripts for all pages-->
		<script src="resources/js/sb-admin.min.js"></script>
		<!-- Custom scripts for this page-->
		<script src="resources/js/sb-admin-datatables.min.js"></script>
		<!-- <script src="resources/js/sb-admin-charts.min.js"></script> -->
	</div>
</body>
</html>