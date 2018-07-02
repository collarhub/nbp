<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>SIMSNS 친구 목록</title>
	<!-- Bootstrap core CSS-->
	<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom fonts for this template-->
	<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<!-- Page level plugin CSS-->
	<link href="resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
	<!-- Custom styles for this template-->
	<link href="resources/css/sb-admin.min.css" rel="stylesheet">
	<link href="resources/simsns/css/simsns.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$.ajax({
				cache : false,
		        type : "GET",
		        url : "getFriend",
		        dataType : "json",
		        contentType: "application/json",
		        error : function(jqXHR,request, error) {
		            alert('통신실패!!');
		            console.log(jqXHR);
					console.log(request);
					console.log(JSON.stringify(error));
		        },
		        success : function(data) {
		        	alert(df);
		        }
		    });
		});
	</script>
</head>
<body class="fixed-nav sticky-footer bg-gray" id="page-top">
	<nav class="navbar navbar-expand-lg navbar-dark bg-simsns fixed-top out" id="mainNav">
		<a class="navbar-brand" href="/simsns/">SIMSNS</a>
		<div class="board-title-text">${sessionScope.hostName} 의 친구 목록</div>
		<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav navbar-sidenav side-navbar" id="exampleAccordion">
				<li class="nav-item nav-item-simsns" data-toggle="tooltip" data-placement="right" title="mainBoard">
					<a class="nav-link" href="board">
						<i class="fa fa-fw fa-newspaper-o"></i>
						<span class="nav-link-text">게시판</span>
					</a>
				</li>
				<li class="nav-item nav-item-simsns" data-toggle="tooltip" data-placement="right" title="picture">
					<a class="nav-link" href="picture">
						<i class="fa fa-fw fa-picture-o"></i>
						<span class="nav-link-text">사진</span>
					</a>
				</li>
			</ul>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item">
					<div class="vertical-container">
						<form action="boardMove" method="post" name=myBoardFrom>
							<input type="hidden" value="${sessionScope.userID}" name="userEmail">
							<input type="hidden" value="${sessionScope.userName}" name="userName">
						</form>
						<a class="nav-link small-text vertical-content" href="javascript:;" onclick="javascript:document.myBoardFrom.submit();">
							${sessionScope.userName}님
						</a>
						<span class="small-text vertical-content">
							환영합니다
						</span>
					</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="modal" data-target="#logoutModal">
						<i class="fa fa-fw fa-sign-out"></i>로그아웃</a>
				</li>
			</ul>
		</div>
	</nav>
	<div class="content-wrapper content-wrapper-simsns">
		<div class="post-wrapper-simsns">
			<div class="mb-0 mt-4">
				<i class="fa fa-fw fa-user"></i> 친구 목록
			</div>
			<hr class="mt-2">
			<div id="friend">
			</div>
		</div>
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top">
			<i class="fa fa-angle-up"></i>
		</a>
		
		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">x</span>
						</button>
					</div>
					<div class="modal-body">로그아웃 하시겠습니까?</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
						<a class="btn btn-primary bg-simsns" href="logout">로그아웃</a>
					</div>
				</div>
			</div>
		</div>
    
		<!-- Bootstrap core JavaScript-->
		<!-- <script src="resources/vendor/jquery/jquery.min.js"></script> -->
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
		<!-- <script src="resources/js/sb-admin-charts.min.js"></script> -->
	</div>
</body>
</html>