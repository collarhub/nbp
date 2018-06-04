<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
	<title>signup</title>
</head>
<body>
<c:if test="${sessionScope.userID != null }">
	<script type="text/javascript">
		location.href('/simsns/board');
	</script>
</c:if>
<c:if test="${isSignupSuccess == 'false'}">
	<script type="text/javascript">
		alert('정보를 정확하게 입력해주세요.')
	</script>
</c:if>
<h1>회원가입</h1>
<form action="signupValidate" method="post">
	<table>
		<tr>
			<th colspan="3" align="left">이메일</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userEmail" name="userEmail" value="${userVO.userEmail}"></th>
			<th><form:errors path="userVO.userEmail"></form:errors></th>
		</tr>
		<tr>
			<th colspan="3" align="left">비밀번호</th>
		</tr>
		<tr>
			<th colspan="2"><input type="password" id="userPassword" name="userPassword"></th>
			<th><form:errors path="userVO.userPassword"></form:errors></th>
		</tr>
		<tr>
			<th colspan="3" align="left">비밀번호 확인</th>
		</tr>
		<tr>
			<th colspan="2"><input type="password" id="userPasswordConfirm" name="userPasswordConfirm"></th>
			<th><form:errors path="userVO.userPasswordConfirm"></form:errors></th>
		</tr>
		<tr>
			<th colspan="3" align="left">이름</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userName" name="userName" value="${userVO.userName}"></th>
			<th><form:errors path="userVO.userName"></form:errors></th>
		</tr>
		<tr>
			<th colspan="3" align="left">전화번호</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userPhone" name="userPhone" value="${userVO.userPhone}"></th>
			<th><form:errors path="userVO.userPhone"></form:errors></th>
		</tr>
		<tr>
			<th colspan="3" align="left">주소</th>
		</tr>
		<tr>
			<th colspan="2"><input type="text" id="userAddress" name="userAddress" value="${userVO.userAddress}"></th>
			<th><form:errors path="userVO.userAddress"></form:errors></th>
		</tr>
		<tr>
			<th align="left"><input type="button" value="취소" onclick="javascript:location.href='/simsns/'"></th>
			<th align="right"><input type="submit" value="가입하기"></th>
			<th></th>
		</tr>
	</table>
</form>
</body>
</html>
