<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>SIMSNS 로그인</title>
	<!-- Bootstrap core CSS-->
	<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom fonts for this template-->
	<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<!-- Page level plugin CSS-->
	<link href="resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
	<!-- Custom styles for this template-->
	<link href="resources/css/sb-admin.css" rel="stylesheet">
	<link href="resources/simsns/css/simsns.css" rel="stylesheet">
</head>
<body class="fixed-nav sticky-footer bg-gray" id="page-top">
	<nav class="navbar navbar-expand-lg navbar-dark bg-simsns fixed-top out" id="mainNav">
		<a class="navbar-brand in text-center text-big" href="/simsns/">SIMSNS</a>
	</nav>
	<div class="container">
		<c:if test="${sessionScope.userID != null }">
			<script type="text/javascript">
				location.href = '/simsns/board';
			</script>
		</c:if>
		<c:if test="${isSignupSuccess == 'true'}">
			<script type="text/javascript">
				alert('정상적으로 가입되었습니다. 로그인해주세요.');
			</script>
		</c:if>
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">로그인</div>
			<div class="card-body">
				<form action="loginValidate" method="post">
					<div class="form-group">
						<label for="userEmail">이메일 주소</label>
						<input class="form-control" id="userEmail" name="userEmail" aria-describedby="emailHelp" type="text" placeholder="Enter email"
							value="${userVO.userEmail}">
						<form:errors path="userVO.userEmail" class="text-danger"></form:errors>
					</div>
					<div class="form-group">
						<label for="userPassword">비밀번호</label>
						<input class="form-control" id="userPassword" name="userPassword" type="password" placeholder="Password">
						<form:errors path="userVO.userPassword" class="text-danger"></form:errors>
					</div>
					<input type="submit" class="btn btn-primary btn-block bg-simsns" value="로그인">
				</form>
				<div class="text-center">
					<a class="d-block small mt-3" href="signup">회원 가입</a>
					<form:errors path="userVO.userPasswordConfirm" class="text-danger"></form:errors>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript-->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<!-- Page level plugin JavaScript-->
	<script src="resources/vendor/chart.js/Chart.min.js"></script>
	<script src="resources/vendor/datatables/jquery.dataTables.js"></script>
	<script src="resources/vendor/datatables/dataTables.bootstrap4.js"></script>
	<!-- Custom scripts for all pages-->
	<script src="resources/js/sb-admin.min.js"></script>
	<!-- Custom scripts for this page-->
	<script src="resources/js/sb-admin-datatables.min.js"></script>
	<script src="resources/js/sb-admin-charts.min.js"></script>
</body>
</html>
