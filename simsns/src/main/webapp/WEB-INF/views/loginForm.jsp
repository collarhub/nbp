<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
	<title>login</title>
	<script type="text/javascript">
		function goSignupForm() {
			location.href="./signup";
		}
	</script>
</head>
<body>
<h1>로그인</h1>
<table>
	<tr>
		<th align="right">아이디</th>
		<th><input type="text"></th>
	</tr>
	<tr>
		<th align="right">비밀번호</th>
		<th><input type="text"></th>
	</tr>
	<tr>
		<th align="left"><input type="button" value="로그인"></th>
		<th align="right"><input type="button" value="회원가입" onclick="goSignupForm()"></th>
	</tr>
</table>
</body>
</html>
