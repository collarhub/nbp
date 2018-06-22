<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="com.nbp.simsns.vo.PostVO"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
var goToPostTimestamp = "${pictureVO.postTimestamp}";
var goToPostNo = "${pictureVO.postNo}";
var loadedImgNum = 0;
window.onload=function(){
	if(goToPostTimestamp != '' && goToPostNo != ''){
		offset = $('#' + goToPostTimestamp + goToPostNo).offset();
		$('body, html').animate({scrollTop : offset.top}, 300);
	}
	else {
	    setTimeout(function(){
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
	if(showError == true) {
		showError = false;
		[].forEach.call(document.getElementsByClassName('errors'), function (obj, index) {
			obj.style.display = 'none';
		});
	}
	if(updatingCommentContainer != null && updatingCommentUpdateContainer != null) {
		updatingCommentUpdateContainer.getElementsByTagName('textarea')[0].textContent
		= updatingCommentContainer.getElementsByClassName('commentContent')[0].textContent;
		updatingCommentContainer.style.display = 'block';
		updatingCommentUpdateContainer.style.display = 'none';
	}
	updatingCommentContainer = commentContainer;
	updatingCommentUpdateContainer = commentUpdateContainer;
	commentContainer.style.display = 'none';
	commentUpdateContainer.style.display = 'block';
}
function updateCommentCancel(commentContainer, commentUpdateContainer) {
	updatingCommentContainer = null;
	updatingCommentUpdateContainer = null;
	commentContainer.style.display = 'block';
	commentUpdateContainer.style.display = 'none';
	commentUpdateContainer.getElementsByTagName('textarea')[0].textContent
	= commentContainer.getElementsByClassName('commentContent')[0].textContent;
}
function imgOnLoad() {
	loadedImgNum++;
}
function imgOnError() {
	loadedImgNum++;
}
function addPost() {
	$("#enters").append('<div id="' + postList[index].postTimestamp + postList[index].postNo + '"></div>'
			+ new Date(Number(postList[index].postTimestamp)).toString() + '<br>'
			+ '<form action="board" method="post">'
			+ '작성자 : <input type="submit" value="' + postList[index].userEmailGuest + '">'
			+ '<input type="hidden" value="' + postList[index].userEmailGuest + '" name="userEmailHost">'
			+ '</form>'
			+'<form id="form' + index + '" action="deletePost" method="post">'
			+ '<h1>제목 : ' + postList[index].postTitle + '</h1><br>'
			+ (
					(pictureList[pictureIndex] != undefined
						&& pictureList[pictureIndex].postTimestamp == postList[index].postTimestamp
						&& pictureList[pictureIndex].postNo == postList[index].postNo) ?
							'<img src="resources/picture/' + pictureList[pictureIndex++].picturePath + '"'
							+ 'onload="imgOnLoad()" onerror="imgOnError()"><br>'
							: ''
			)
			+ '내용 : ' + postList[index].postContent + '<br>'
			+ (
					("${sessionScope.userID}" == postList[index].userEmailGuest) ?
						'<input type="button" value="삭제" onclick="deletePost(form' + index + ')">'
						+ '<input type="button" value="수정" onclick="updatePost(form' + index + ')">'
						+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
						+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
						+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
						: ''
			)
			+ '</form>'
			+ '<form action="addLike" method="post" id="likeForm' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '">'
			+ '<input type="submit" value="좋아요">'
			+ (
					("${likeVO.postNo}" == postList[index].postNo && "${likeVO.postTimestamp}" == postList[index].postTimestamp
						&& "${likeVO.commentNo}" == COMMENT_ROOT
						&& "${likeVO.commentTimestamp}" == COMMENT_ROOT) ?
							'<form:errors path="likeVO.userEmailGuest" class="errors"></form:errors>'
							: ''
			)
			+ '<input type="hidden" value="${id}" name="userEmailHost">'
			+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo">'
			+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp">'
			+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentNo">'
			+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentTimestamp">'
			+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentDepth">'
			+ '</form>'
			+ '<span id="likeCount' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '">0</span>'
			+ '<div id="like' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '"></div>'
			+ '<br>'
			+ '<div style="margin-left:' + 15 * (1 + COMMENT_ROOT) + 'px" id="comment' + postList[index].postTimestamp + postList[index].postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '"></div>');
	
	for(; (commentList[commentIndex] != undefined && commentList[commentIndex].postTimestamp == postList[index].postTimestamp &&
		commentList[commentIndex].postNo == postList[index].postNo); commentIndex++) {
		comment = commentList[commentIndex];
		$("#comment" + postList[index].postTimestamp + postList[index].postNo + comment.commentDepth
		+ comment.commentTimestampParent + comment.commentNoParent)
			.append('<div id="' + comment.postTimestamp + comment.postNo + comment.commentTimestamp + comment.commentNo + '"></div>'
				+ '<div id="commentContainer' + commentIndex + '">'
				+ new Date(Number(comment.commentTimestamp)).toString() + '<br>'
				+ '<form action="board" method="post">'
				+ '작성자 : <input type="submit" value="' + comment.userEmailGuest + '">'
				+ '<input type="hidden" value="' + comment.userEmailGuest + '" name="userEmailHost">'
				+ '</form>'
				+ '<form id="comment' + commentIndex + '" action="deleteComment" method="post">'
				+ '내용 : <span class="commentContent">' + comment.commentContent + '</span>'
				+ (
						("${sessionScope.userID}" == comment.userEmailGuest) ?
							'<input type="button" value="삭제" onclick="deleteComment(comment' + commentIndex + ')">'
							+ '<input type="button" value="수정" onclick="updateComment(commentContainer' + commentIndex + ', commentUpdateContainer' + commentIndex + ')">'
							+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
							+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
							+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
							+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo" id="commentNo">'
							+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp" id="commentTimestamp">'
							: ''
				)
				+ (
						("${commentVO.postNo}" == postList[index].postNo && "${commentVO.postTimestamp}" == postList[index].postTimestamp
							&& "${commentVO.commentNo}" == comment.commentNo
							&& "${commentVO.commentTimestamp}" == comment.commentTimestamp) ?
								'<form:errors path="commentVO.commentContent" class="errors"></form:errors>'
								: ''
				)
				+ '</form>'
				+ '<form action="addLike" method="post" id="likeForm' + postList[index].postTimestamp + postList[index].postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '">'
				+ '<input type="submit" value="좋아요">'
				+ (
						("${likeVO.postNo}" == postList[index].postNo && "${likeVO.postTimestamp}" == postList[index].postTimestamp
							&& "${likeVO.commentNo}" == comment.commentNo
							&& "${likeVO.commentTimestamp}" == comment.commentTimestamp) ?
								'<form:errors path="likeVO.userEmailGuest" class="errors"></form:errors>'
								: ''
				)
				+ '<input type="hidden" value="${id}" name="userEmailHost">'
				+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo">'
				+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp">'
				+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo">'
				+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp">'
				+ '<input type="hidden" value="' + comment.commentDepth + '" name="commentDepth">'
				+ '</form>'
				+ '<span id="likeCount' + postList[index].postTimestamp + postList[index].postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '">0</span>'
				+ '<div id="like' + postList[index].postTimestamp + postList[index].postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '"></div>'
				+ '<br>'
				+ '</div>'
				+ '<div id="commentUpdateContainer' + commentIndex + '" style="display:none">'
				+ '<form id="coCommentUpdateForm' + commentIndex + '" action="updateComment" method="post">'
				+ '수정 <textarea style="overflow:hidden" name="commentContent">' + comment.commentContent + '</textarea>'
				+ '<input type="button" value="취소" onclick="updateCommentCancel(commentContainer' + commentIndex + ', commentUpdateContainer' + commentIndex + ')">'
				+ '<input type="submit" value="수정">'
				+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
				+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
				+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
				+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo" id="commentNo">'
				+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp" id="commentTimestamp">'
				+ '<input type="hidden" value="' + comment.commentDepth + '" name="commentDepth" id="commentDepth">'
				+ '</form><br>'
				+ '</div>'
				+ '<div style="margin-left:' + 15 * (2 + Number(comment.commentDepth)) + 'px" id="comment' + postList[index].postTimestamp + postList[index].postNo + (Number(comment.commentDepth) + 1) + comment.commentTimestamp + comment.commentNo + '"></div>'
				+ '<form id="coCommentForm' + commentIndex + '" action="writeComment" method="post">'
				+ '댓글 <textarea style="overflow:hidden" name="commentContent"></textarea>'
				+ '<input type="submit" value="작성">'
				+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
				+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
				+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
				+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNoParent" id="commentNoParent">'
				+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestampParent" id="commentTimestampParent">'
				+ '<input type="hidden" value="' + (Number(comment.commentDepth) + 1) + '" name="commentDepth" id="commentDepth">'
				+ (
						("${commentVO.postNo}" == postList[index].postNo && "${commentVO.postTimestamp}" == postList[index].postTimestamp
							&& "${commentVO.commentNoParent}" == comment.commentNo
							&& "${commentVO.commentTimestampParent}" == comment.commentTimestamp) ?
								'<form:errors path="commentVO.commentContent" class="errors"></form:errors>'
								: ''
				)
				+ '</form><br>');
	}
	
	for(; (likeList[likeIndex] != undefined && likeList[likeIndex].postTimestamp == postList[index].postTimestamp &&
		likeList[likeIndex].postNo == postList[index].postNo); likeIndex++) {
		like = likeList[likeIndex];
		$("#like" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
			+ like.commentTimestamp + like.commentNo)
			.append(like.userEmailGuest + '<br>');
		$("#likeCount" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
			+ like.commentTimestamp + like.commentNo)
			.html(Number($("#likeCount" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
			+ like.commentTimestamp + like.commentNo)
			.html()) + 1);
		if("${sessionScope.userID}" == like.userEmailGuest) {
			$("#likeForm" + postList[index].postTimestamp + postList[index].postNo + like.commentDepth
					+ like.commentTimestamp + like.commentNo).css('display', 'none');
		}
	}

	$("#enters").append('<form id="commentForm' + index + '" action="writeComment" method="post">'
				+ '댓글 <textarea style="overflow:hidden" name="commentContent"></textarea>'
				+ '<input type="submit" value="작성">'
				+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
				+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
				+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
				+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentNoParent" id="commentNoParent">'
				+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentTimestampParent" id="commentTimestampParent">'
				+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentDepth" id="commentDepth">'
				+ (
						("${commentVO.postNo}" == postList[index].postNo && "${commentVO.postTimestamp}" == postList[index].postTimestamp
							&& "${commentVO.commentNoParent}" == COMMENT_ROOT
							&& "${commentVO.commentTimestampParent}" == COMMENT_ROOT) ?
								'<form:errors path="commentVO.commentContent" class="errors"></form:errors>'
								: ''
				)
				+ '</form><br>'
				+ '<hr>');
}
$(document).ready(function() {
	/* var index = 0;
	var commentIndex = 0;
	var likeIndex = 0;
	var pictureIndex = 0;
	var postList = ${postList};
	var commentList = ${commentList};
	var likeList = ${likeList};
	var pictureList = ${pictureList};
	var goToPostTimestamp = "${pictureVO.postTimestamp}";
	var goToPostNo = "${pictureVO.postNo}"; */
	
	postList.some(function(post, i){
		addPost();
		if($("body").height() > $(window).height() && goToPostTimestamp == '' && goToPostNo == '') {
			return (index == index);
		} else if(post.postTimestamp == goToPostTimestamp && post.postNo == goToPostNo){
			/* location.href = '#' + goToPostTimestamp + goToPostNo; */
			return (index == index);
		}
		index++;
	});
	index++;
	
	$(window).resize(function(){
		while($("body").height() <= $(window).height()){
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
	$('#searchCommentRange').hide();
});
function searchKindChange() {
	selected = $('#searchKind').val();
	if(selected == 'post') {
		$('#searchPostRange').show();
		$('#searchCommentRange').hide();
	} else if(selected == 'comment') {
		$('#searchCommentRange').show();
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
	        		+ "&searchIndex=" + searchIndex + "&userEmailHost=${id}",
	        dataType : "json",
	        contentType: "application/json",
	        error : function(){
	            alert('통신실패!!');
	            $('#searchResult').css('display', 'none');
	        },
	        success : function(data){
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
	        	if(loadedImgNum == $('#enters').find('img').length) {
        			var offset = $('#' + data.result.postTimestamp + data.result.postNo).offset();
        			$('body, html').animate({scrollTop : offset.top}, 300);
        		} else {
		        	$('#enters').find('img').load(function() {
		        		//loadedImgNum++;
		        		if(loadedImgNum == $('#enters').find('img').length) {
		        			var offset = $('#' + data.result.postTimestamp + data.result.postNo).offset();
		        			$('body, html').animate({scrollTop : offset.top}, 300);
		        		}
		        	}).error(function() {
		        		//loadedImgNum++;
		        		if(loadedImgNum == $('#enters').find('img').length) {
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
	        		+ "&searchIndex=" + searchIndex + "&userEmailHost=${id}",
	        dataType : "json",
	        contentType: "application/json",
	        error : function(){
	            alert('통신실패!!');
	            $('#searchResult').css('display', 'none');
	        },
	        success : function(data){
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
	        	if(loadedImgNum == $('#enters').find('img').length) {
	        		var offset = $('#' + data.result.postTimestamp + data.result.postNo + data.result.commentTimestamp + data.result.commentNo).offset();
        			$('body, html').animate({scrollTop : offset.top}, 300);
        		} else {
		        	$('#enters').find('img').load(function() {
		        		//loadedImgNum++;
		        		if(loadedImgNum == $('#enters').find('img').length) {
		        			var offset = $('#' + data.result.postTimestamp + data.result.postNo + data.result.commentTimestamp + data.result.commentNo).offset();
		        			$('body, html').animate({scrollTop : offset.top}, 300);
		        		}
		        	}).error(function() {
		        		//loadedImgNum++;
		        		if(loadedImgNum == $('#enters').find('img').length) {
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
<body>
<c:if test="${sessionScope.userID == null}">
	<script type="text/javascript">
		alert('로그인 후 이용해주세요.');
		location.href = '/simsns/';
	</script>
</c:if>
hello
${sessionScope.userID}
<input type="button" value="로그아웃" onclick="javascript:location.href='/simsns/logout'">
<%-- <form action="searchBoard" method="post">
	<select name="searchRange">
	    <option value="title">제목</option>
	    <option value="content">내용</option>
	    <option value="writer">작성자</option>
	    <option value="titleContent">제목+내용</option>
	</select>
	<input type="text" name="searchKeyword"><input type="submit" value="검색">
	<input type="hidden" value="${id}" name="userEmailHost">
	<form:errors path="searchVO.searchKeyword" class="errors"></form:errors>
</form> --%>
<select id="searchKind" onchange="searchKindChange()">
	<option value="post">게시물</option>
	<option value="comment">댓글</option>
</select>
<select id="searchPostRange">
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
	<option value="titleContent">제목+내용</option>
</select>
<select id="searchCommentRange">
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>
<input type="text" id="searchKeyword"><input type="button" value="검색" onclick="search('first')">
<div id="searchResult" style="display:none;">
	<input type="button" value="이전" onclick="search('previous')">
	<span></span>
	<input type="button" value="다음" onclick="search('next')">
	<input type="hidden" id="storedSearchKind" value="">
	<input type="hidden" id="storedSearchKeyword" value="">
	<input type="hidden" id="storedSearchRange" value="">
</div>
<br/>
<form action="write" method="post">
<input type="submit" value="글쓰기">
<input type="hidden" value="${id}" name="userEmailHost">
</form>
<c:if test="${sessionScope.userID != id}">
	<form action="board" method="post">
		<input type="submit" value="내 게시판">
		<input type="hidden" value="${id}" name="userEmailHost">
	</form>
</c:if>
<form action="picture" method="post">
	<input type="submit" value="사진 게시판">
	<input type="hidden" value="${id}" name="userEmailHost">
</form>
<h1>${id} 의 게시판입니다.</h1>
<hr>
<div id="search"></div>
<div id="enters">
</div>
</body>
</html>