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
$(document).ready(function() {
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
	
	postList.some(function(post, i){
		$("#enters").append('<div id="' + post.postTimestamp + post.postNo + '"></div>'
							+ new Date(Number(post.postTimestamp)).toString() + '<br>'
							+ '<form action="board" method="post">'
							+ '작성자 : <input type="submit" value="' + post.userEmailGuest + '">'
							+ '<input type="hidden" value="' + post.userEmailGuest + '" name="userEmailHost">'
							+ '</form>'
							+ '<form id="form' + index + '" action="deletePost" method="post">'
							+ '<h1>제목 : ' + post.postTitle + '</h1><br>'
							+ (
									(pictureList[pictureIndex] != undefined
										&& pictureList[pictureIndex].postTimestamp == post.postTimestamp
										&&pictureList[pictureIndex].postNo == post.postNo) ?
											'<img src="resources/picture/' + pictureList[pictureIndex++].picturePath + '"><br>'
											: ''
							)
							+ '내용 : ' + post.postContent + '<br>'
							+ (
									("${sessionScope.userID}" == post.userEmailGuest) ?
										'<input type="button" value="삭제" onclick="deletePost(form' + index + ')">'
										+ '<input type="button" value="수정" onclick="updatePost(form' + index + ')">'
										+ '<input type="hidden" value="' + post.postNo + '" name="postNo" id="postNo">'
										+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
										+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
										: ''
							)
							+ '</form>'
							+ '<form action="addLike" method="post" id="likeForm' + post.postTimestamp + post.postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '">'
							+ '<input type="submit" value="좋아요">'
							+ (
									("${likeVO.postNo}" == post.postNo && "${likeVO.postTimestamp}" == post.postTimestamp
										&& "${likeVO.commentNo}" == COMMENT_ROOT
										&& "${likeVO.commentTimestamp}" == COMMENT_ROOT) ?
											'<form:errors path="likeVO.userEmailGuest" class="errors"></form:errors>'
											: ''
							)
							+ '<input type="hidden" value="${id}" name="userEmailHost">'
							+ '<input type="hidden" value="' + post.postNo + '" name="postNo">'
							+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp">'
							+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentNo">'
							+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentTimestamp">'
							+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentDepth">'
							+ '</form>'
							+ '<span id="likeCount' + post.postTimestamp + post.postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '">0</span>'
							+ '<div id="like' + post.postTimestamp + post.postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '"></div>'
							+ '<br>'
							+ '<div style="margin-left:' + 15 * (1 + COMMENT_ROOT) + 'px" id="comment' + post.postTimestamp + post.postNo + COMMENT_ROOT + COMMENT_ROOT + COMMENT_ROOT + '"></div>');

		
		for(; (commentList[commentIndex] != undefined && commentList[commentIndex].postTimestamp == post.postTimestamp &&
				commentList[commentIndex].postNo == post.postNo); commentIndex++) {
			comment = commentList[commentIndex];
			$("#comment" + post.postTimestamp + post.postNo + comment.commentDepth
				+ comment.commentTimestampParent + comment.commentNoParent)
					.append('<div id="commentContainer' + commentIndex + '">'
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
										+ '<input type="hidden" value="' + post.postNo + '" name="postNo" id="postNo">'
										+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
										+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo" id="commentNo">'
										+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp" id="commentTimestamp">'
										: ''
							)
							+ (
									("${commentVO.postNo}" == post.postNo && "${commentVO.postTimestamp}" == post.postTimestamp
										&& "${commentVO.commentNo}" == comment.commentNo
										&& "${commentVO.commentTimestamp}" == comment.commentTimestamp) ?
											'<form:errors path="commentVO.commentContent" class="errors"></form:errors>'
											: ''
							)
							+ '</form>'
							+ '<form action="addLike" method="post" id="likeForm' + post.postTimestamp + post.postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '">'
							+ '<input type="submit" value="좋아요">'
							+ (
									("${likeVO.postNo}" == post.postNo && "${likeVO.postTimestamp}" == post.postTimestamp
										&& "${likeVO.commentNo}" == comment.commentNo
										&& "${likeVO.commentTimestamp}" == comment.commentTimestamp) ?
											'<form:errors path="likeVO.userEmailGuest" class="errors"></form:errors>'
											: ''
							)
							+ '<input type="hidden" value="${id}" name="userEmailHost">'
							+ '<input type="hidden" value="' + post.postNo + '" name="postNo">'
							+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp">'
							+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo">'
							+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp">'
							+ '<input type="hidden" value="' + comment.commentDepth + '" name="commentDepth">'
							+ '</form>'
							+ '<span id="likeCount' + post.postTimestamp + post.postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '">0</span>'
							+ '<div id="like' + post.postTimestamp + post.postNo + comment.commentDepth + comment.commentTimestamp + comment.commentNo + '"></div>'
							+ '<br>'
							+ '</div>'
							+ '<div id="commentUpdateContainer' + commentIndex + '" style="display:none">'
							+ '<form id="coCommentUpdateForm' + commentIndex + '" action="updateComment" method="post">'
							+ '수정 <textarea style="overflow:hidden" name="commentContent">' + comment.commentContent + '</textarea>'
							+ '<input type="button" value="취소" onclick="updateCommentCancel(commentContainer' + commentIndex + ', commentUpdateContainer' + commentIndex + ')">'
							+ '<input type="submit" value="수정">'
							+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
							+ '<input type="hidden" value="' + post.postNo + '" name="postNo" id="postNo">'
							+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
							+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNo" id="commentNo">'
							+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestamp" id="commentTimestamp">'
							+ '<input type="hidden" value="' + comment.commentDepth + '" name="commentDepth" id="commentDepth">'
							+ '</form><br>'
							+ '</div>'
							+ '<div style="margin-left:' + 15 * (2 + Number(comment.commentDepth)) + 'px" id="comment' + post.postTimestamp + post.postNo + (Number(comment.commentDepth) + 1) + comment.commentTimestamp + comment.commentNo + '"></div>'
							+ '<form id="coCommentForm' + commentIndex + '" action="writeComment" method="post">'
							+ '댓글 <textarea style="overflow:hidden" name="commentContent"></textarea>'
							+ '<input type="submit" value="작성">'
							+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
							+ '<input type="hidden" value="' + post.postNo + '" name="postNo" id="postNo">'
							+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
							+ '<input type="hidden" value="' + comment.commentNo + '" name="commentNoParent" id="commentNoParent">'
							+ '<input type="hidden" value="' + comment.commentTimestamp + '" name="commentTimestampParent" id="commentTimestampParent">'
							+ '<input type="hidden" value="' + (Number(comment.commentDepth) + 1) + '" name="commentDepth" id="commentDepth">'
							+ (
									("${commentVO.postNo}" == post.postNo && "${commentVO.postTimestamp}" == post.postTimestamp
										&& "${commentVO.commentNoParent}" == comment.commentNo
										&& "${commentVO.commentTimestampParent}" == comment.commentTimestamp) ?
											'<form:errors path="commentVO.commentContent" class="errors"></form:errors>'
											: ''
							)
							+ '</form><br>');

		}
		
		for(; (likeList[likeIndex] != undefined && likeList[likeIndex].postTimestamp == post.postTimestamp &&
				likeList[likeIndex].postNo == post.postNo); likeIndex++) {
			like = likeList[likeIndex];
			$("#like" + post.postTimestamp + post.postNo + like.commentDepth
					+ like.commentTimestamp + like.commentNo)
					.append(like.userEmailGuest + '<br>');
			$("#likeCount" + post.postTimestamp + post.postNo + like.commentDepth
					+ like.commentTimestamp + like.commentNo)
					.html(Number($("#likeCount" + post.postTimestamp + post.postNo + like.commentDepth
					+ like.commentTimestamp + like.commentNo)
					.html()) + 1);
			if("${sessionScope.userID}" == like.userEmailGuest) {
				$("#likeForm" + post.postTimestamp + post.postNo + like.commentDepth
						+ like.commentTimestamp + like.commentNo).css('display', 'none');
			}
		}
		
		$("#enters").append('<form id="commentForm' + index + '" action="writeComment" method="post">'
							+ '댓글 <textarea style="overflow:hidden" name="commentContent"></textarea>'
							+ '<input type="submit" value="작성">'
							+ '<input type="hidden" value="${id}" name="userEmailHost" id="userEmailHost">'
							+ '<input type="hidden" value="' + post.postNo + '" name="postNo" id="postNo">'
							+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
							+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentNoParent" id="commentNoParent">'
							+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentTimestampParent" id="commentTimestampParent">'
							+ '<input type="hidden" value="' + COMMENT_ROOT + '" name="commentDepth" id="commentDepth">'
							+ (
									("${commentVO.postNo}" == post.postNo && "${commentVO.postTimestamp}" == post.postTimestamp
										&& "${commentVO.commentNoParent}" == COMMENT_ROOT
										&& "${commentVO.commentTimestampParent}" == COMMENT_ROOT) ?
											'<form:errors path="commentVO.commentContent" class="errors"></form:errors>'
											: ''
							)
							+ '</form><br>'
							+ '<hr>');
		if($("body").height() > $(window).height() && goToPostTimestamp == '' && goToPostNo == '') {
			return (index == index);
		} else if(post.postTimestamp == goToPostTimestamp && post.postNo == goToPostNo){
			location.href = '#' + goToPostTimestamp + goToPostNo;
			return (index == index);
		}
		index++;
	});
	index++;
	
	$(window).resize(function(){
		while($("body").height() <= $(window).height()){
			if(index < postList.length) {
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
												&&pictureList[pictureIndex].postTimestamp == postList[index].postTimestamp
												&&pictureList[pictureIndex].postNo == postList[index].postNo) ?
													'<img src="resources/picture/' + pictureList[pictureIndex++].picturePath + '"><br>'
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
							.append('<div id="commentContainer' + commentIndex + '">'
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
				index++;
			} else {
				break;
			}
		}
	});
	
	$(window).scroll(function() {
		if ($(window).scrollTop() + 1 >= $(document).height() - $(window).height()) {
			if(index < postList.length) {
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
												&&pictureList[pictureIndex].postTimestamp == postList[index].postTimestamp
												&&pictureList[pictureIndex].postNo == postList[index].postNo) ?
													'<img src="resources/picture/' + pictureList[pictureIndex++].picturePath + '"><br>'
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
							.append('<div id="commentContainer' + commentIndex + '">'
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
				index++;
			}
		}
	});
});
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
<input type="button" value="로그아웃" onclick="javascript:location.href='/simsns/logout'"><br/>
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
<div id="enters">
</div>
</body>
</html>