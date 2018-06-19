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
	function updateCancel(formUpdatePicture) {
		formUpdatePicture.action = "picturePicture";
		formUpdatePicture.submit();
	}
	$(document).ready(function() {
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#uploadFile').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$('#fileUpload').change(function(){
			readURL(this);
		});
	});
	function deleteImage() {
		$('#uploadFile').attr('src', '');
		$('#fileUpload').attr('type', '');
		$('#fileUpload').attr('type', 'file');
		$('#deleted').val('true');
	}
</script>
</head>
<body>
<c:if test="${sessionScope.userID == null}">
	<script type="text/javascript">
		alert('로그인 후 이용해주세요.');
		location.href = '/simsns/';
	</script>
</c:if>
<form action="updatePictureCommit" method="post" enctype="multipart/form-data" id="formUpdatePicture">
	<table>
		<tr>
			<th>제목</th>
			<th><input type="text" id="pictureTitle" name="pictureTitle" value="${pictureVO.pictureTitle}"></th>
			<th><form:errors path="pictureVO.pictureTitle"></form:errors></th>
		</tr>
		<tr>
			<th><input type="file" id="fileUpload" name="fileUpload"></th>
			<th style="border:1px solid"><img id="uploadFile" width="80" height="80" src="${picture}"><input type="button" value="삭제" onclick="deleteImage()"></th>
			<th><form:errors path="pictureVO.picturePath"></form:errors>
			<input type="hidden" value="false" name="deleted" id="deleted"></th>
		</tr>
		<tr>
			<th></th>
			<th align="right">
				<input type="button" value="취소" onclick="updateCancel(formUpdatePicture)">
				<input type="submit" value="완료">
			</th>
			<th></th>
		</tr>
	</table>
	<input type="hidden" value="${pictureVO.userEmailHost}" name="userEmailHost" id="userEmailHost">
	<input type="hidden" value="${pictureVO.pictureNo}" name="pictureNo">
	<input type="hidden" value="${pictureVO.pictureTimestamp}" name="pictureTimestamp">
</form>
</body>
</html>