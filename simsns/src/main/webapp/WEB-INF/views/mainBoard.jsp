<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="com.nbp.simsns.vo.PostVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
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
$(document).ready(function() {
	var index = 0;
	var postList = ${postList};
	postList.some(function(post, i){
		$("#enters").append('<form id="form' + index + '" action="deletePost" method="post">'
							+ new Date(Number(post.postTimestamp)).toString() + '<br>'
							+ '작성자 : ' + post.userEmailGuest
							+ '<h1>제목 : ' + post.postTitle + '</h1><br>'
							+ '내용 : ' + post.postContent + '<br>'
							+ (
									("${sessionScope.userID}" == post.userEmailGuest) ?
										'<input type="button" value="삭제" onclick="deletePost(form' + index + ')">'
										+ '<input type="button" value="수정" onclick="updatePost(form' + index + ')">'
										+ '<input type="hidden" value="' + post.postNo + '" name="postNo" id="postNo">'
										+ '<input type="hidden" value="' + post.postTimestamp + '" name="postTimestamp" id="postTimestamp">'
										+ '<input type="hidden" value="${param.id}" name="userEmailHost" id="userEmailHost">'
										: ''
								)
							+ '</form><br><hr>');
		if($("body").height() > $(window).height())
			return (index == index);
		index++;
	});
	index++;
	$(window).scroll(function() {
		if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			if(index < postList.length) {
				$("#enters").append('<form id="form' + index + '" action="deletePost" method="post">'
					+ new Date(Number(postList[index].postTimestamp)).toString() + '<br>'
					+ '작성자 : ' + postList[index].userEmailGuest
					+ '<h1>제목 : ' + postList[index].postTitle + '</h1><br>'
					+ '내용 : ' + postList[index].postContent + '<br>'
					+ (
							("${sessionScope.userID}" == postList[index].userEmailGuest) ?
								'<input type="button" value="삭제" onclick="deletePost(form' + index + ')">'
								+ '<input type="button" value="수정" onclick="updatePost(form' + index + ')">'
								+ '<input type="hidden" value="' + postList[index].postNo + '" name="postNo" id="postNo">'
								+ '<input type="hidden" value="' + postList[index].postTimestamp + '" name="postTimestamp" id="postTimestamp">'
								+ '<input type="hidden" value="${param.id}" name="userEmailHost" id="userEmailHost">'
								: ''
						)
					+ '</form><br><hr>');
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
<input type="button" value="글쓰기" onclick="javascript:location.href='/simsns/write?id=${param.id}'">
<c:if test="${sessionScope.userID != param.id}">
	<input type="button" value="내 게시판" onclick="javascript:location.href='/simsns/board?id=${sessionScope.userID}'">
</c:if>
<h1>${param.id} 의 게시판입니다.</h1>
<hr>
<div id="enters">
</div>
</body>
</html>