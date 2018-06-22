<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
var postList = ${postList};
$(document).ready(function() {
	postList.forEach(function(post, index) {
		$('#postResult').append('<tr>'
									+ '<th>' + post.postTitle + '</th>'
									+ '<th>' + post.postContent + '</th>'
									+ '<th>' + post.userEmailGuest + '</th>'
									+ '<th>' + new Date(Number(post.postTimestamp)).toString() + '</th>'
								+ '</tr>');
	});
});
</script>
</head>
<body>
게시물 결과
<table id="postResult"></table>
댓글 결과
<table id="commentResult"></table>
</body>
</html>