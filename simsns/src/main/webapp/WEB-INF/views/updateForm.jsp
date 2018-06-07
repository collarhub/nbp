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
	$(document).ready(function() {
		$('#fileupload').change(function(){
			alert('upload');
			$('#uploadfile').attr('src', $('#fileupload').val());
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
<form action="updateCommit" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<th>제목</th>
			<th><input type="text" id="postTitle" name="postTitle" value="${postVO.postTitle}"></th>
			<th><form:errors path="postVO.postTitle"></form:errors></th>
		</tr>
		<tr>
			<th>내용</th>
			<th><textarea style="overflow:hidden" id="postContent" name="postContent">${postVO.postContent}</textarea></th>
			<th><form:errors path="postVO.postContent"></form:errors></th>
		</tr>
		<tr>
			<th><input type="file" id="fileupload" name="fileupload"></th>
			<th style="border:1px solid"><img id="uploadfile" width="80" height="80" src=""></th>
			<th></th>
		</tr>
		<tr>
			<th></th>
			<th align="right">
				<input type="button" value="취소" onclick="javascript:location.href='/simsns/board?id=${postVO.userEmailHost}'">
				<input type="submit" value="수정">
			</th>
			<th></th>
		</tr>
	</table>
	<input type="hidden" value="${postVO.postNo}" name="postNo">
	<input type="hidden" value="${postVO.postTimestamp}" name="postTimestamp">
	<input type="hidden" value="${postVO.userEmailHost}" name="userEmailHost">
</form>
</body>
</html>