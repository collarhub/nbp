<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
	<title>signup</title>
</head>
<body>
<h1>회원가입</h1>
<form action="signupValidate" method="post">
	<table>
		<tr>
			<th colspan="2" align="left">이메일</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userEmail" name="userEmail"></th>
		</tr>
		<tr>
			<th colspan="2" align="left">이름</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userName" name="userName"></th>
		</tr>
		<tr>
			<th colspan="2" align="left">전화번호</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userPhone" name="userPhone"></th>
		</tr>
		<tr>
			<th colspan="2" align="left">주소</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userAddress" name="userAddress"></th>
		</tr>
		<tr>
			<th align="left"><input type="button" value="취소"></th>
			<th align="right"><input type="submit" value="가입하기"></th>
		</tr>
	</table>
</form>
</body>
</html>
