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
	var postList = ${postList};
	var commentList = ${commentList};
	postList.some(function(post, i){
		$("#enters").append(new Date(Number(post.postTimestamp)).toString() + '<br>'
							+ '<form action="board" method="post">'
							+ '작성자 : <input type="submit" value="' + post.userEmailGuest + '">'
							+ '<input type="hidden" value="' + post.userEmailGuest + '" name="userEmailHost">'
							+ '</form>'
							+ '<form id="form' + index + '" action="deletePost" method="post">'
							+ '<h1>제목 : ' + post.postTitle + '</h1><br>'
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
							+ '</form><br>'
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
							+ '</form><br>'
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
		if($("body").height() > $(window).height()) {
			return (index == index);
		}
		index++;
	});
	index++;
	
	$(window).scroll(function() {
		if ($(window).scrollTop() + 1 >= $(document).height() - $(window).height()) {
			if(index < postList.length) {
				$("#enters").append(new Date(Number(postList[index].postTimestamp)).toString() + '<br>'
									+ '<form action="board" method="post">'
									+ '작성자 : <input type="submit" value="' + postList[index].userEmailGuest + '">'
									+ '<input type="hidden" value="' + postList[index].userEmailGuest + '" name="userEmailHost">'
									+ '</form>'
									+'<form id="form' + index + '" action="deletePost" method="post">'
									+ '<h1>제목 : ' + postList[index].postTitle + '</h1><br>'
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
									+ '</form><br>'
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
								+ '</form><br>'
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
	<input type="button" value="내 게시판" onclick="javascript:location.href='/simsns/board?id=${sessionScope.userID}'">
</c:if>
<%-- <h1>${param.id} 의 게시판입니다.</h1> --%>
<h1>${id} 의 게시판입니다.</h1>
<hr>
<div id="enters">
</div>
</body>
</html>