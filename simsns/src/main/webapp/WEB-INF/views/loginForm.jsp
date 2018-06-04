<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
	<title>login</title>
</head>
<body>
<c:if test="${sessionScope.userID != null }">
	<script type="text/javascript">
		location.href('/simsns/board');
	</script>
</c:if>
<c:if test="${isSignupSuccess == 'true'}">
	<script type="text/javascript">
		alert('정상적으로 가입되었습니다. 로그인해주세요.')
	</script>
</c:if>
<h1>로그인</h1>
<form action="loginValidate" method="post">
	<table>
		<tr>
			<th align="right">아이디</th>
			<th><input type="text" id="userEmail" name="userEmail"></th>
			<th><form:errors path="userVO.userEmail"></form:errors></th>
		</tr>
		<tr>
			<th align="right">비밀번호</th>
			<th><input type="password" id="userPassword" name="userPassword"></th>
			<th><form:errors path="userVO.userPassword"></form:errors></th>
		</tr>
		<tr>
			<th align="left"><input type="submit" value="로그인"></th>
			<th align="right"><input type="button" value="회원가입" onclick="javascript:location.href='/simsns/signup'"></th>
			<th><form:errors path="userVO.userPasswordConfirm"></form:errors></th>
		</tr>
	</table>
</form>
</body>
</html>
