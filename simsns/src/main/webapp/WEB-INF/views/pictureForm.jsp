<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
var pictureList = ${pictureList};
function goToPost(form) {
	form.submit();
}
function pictureSubmit(form) {
	form.submit();
}
$(document).ready(function() {
	var picturePictureStart = 0;
	for(i = 0; i < 3; i++) {
		$('#postPictureTable').append('<form action="board" method="post" style="display:inline" id="postPictureForm' + i + '">'
									+ '<img id="postPicture' + i + '" width="150" height="150" src="" style="cursor:pointer"'
									+ 'alt="이미지가 없습니다. 이미지를 등록하세요." class="picture" onclick="">'
									+ '</form>');
		if(pictureList[i] != undefined && pictureList[i].postTimestamp != undefined && pictureList[i].postNo != undefined) {
			$('#postPicture' + i).attr('src', 'resources/picture/' + pictureList[i].picturePath);
			$('#postPictureForm' + i).append('<input type="hidden" value="${id}" name="userEmailHost">'
											+ '<input type="hidden" value="' + pictureList[i].postTimestamp + '" name="postTimestamp">'
											+ '<input type="hidden" value="' + pictureList[i].postNo + '" name="postNo">');
			$('#postPicture' + i).attr('onclick', 'goToPost(postPictureForm' + i + ')');
		}
		if(i % 2 == 1) {
			$('#postPictureTable').append('<br>');
		}
	}
	$('#postPictureTable').append('<form action="postPicture" method="post" style="display:inline" id="postPictureForm3">'
			+ '<img id="postPicture3" width="150" height="150" style="cursor:pointer"'
			+ 'src="resources/img/pictureMore.png" style="opacity:0.4;" class="picture" onclick="">'
			+ '</form>');
	if(pictureList[0] != undefined && pictureList[0].postTimestamp != undefined && pictureList[0].postNo != undefined) {
		$('#postPictureForm3').append('<input type="hidden" value="${id}" name="userEmailHost">');
		$('#postPicture3').attr('onclick', 'goToPost(postPictureForm3)');
	}
	for(i = 0; i < pictureList.length; i++) {
		if(pictureList[i].postTimestamp == undefined && pictureList[i].postNo == undefined) {
			picturePictureStart = i;
			break;
		}
		if(i == pictureList.length - 1) {
			picturePictureStart = pictureList.length;
		}
	}
	for(i = 0; i < 3; i++) {
		$('#picturePictureTable').append('<form action="writePicture" method="post" style="display:inline" id="picturePictureForm' + i + '">'
										+ '<img id="picturePicture' + i + '" width="150" height="150" src="" style="cursor:pointer"'
										+ 'alt="이미지가 없습니다. 이미지를 등록하세요." class="picture" onclick="">'
										+ '</form>');
		if(pictureList[i + picturePictureStart] != undefined) {
			$('#picturePicture' + i).attr('src', 'resources/picture/' + pictureList[i + picturePictureStart].picturePath);
		} else {
			$('#picturePictureForm' + i).append('<input type="hidden" value="${id}" name="userEmailHost">');
			$('#picturePictureForm' + i).append('<input type="hidden" value="picture" name="writePictureCancel">');
			$('#picturePicture' + i).attr('onclick', 'pictureSubmit(picturePictureForm' + i + ')');
		}
		if(i % 2 == 1) {
			$('#picturePictureTable').append('<br>');
		}
	}
	$('#picturePictureTable').append('<form action="picturePicture" method="post" style="display:inline" id="picturePictureForm3">'
			+ '<img id="picturePicture3" width="150" height="150" style="cursor:pointer"'
			+ 'src="resources/img/pictureMore.png" style="opacity:0.4;" class="picture" onclick="">'
			+ '</form>');
	if(pictureList[0 + picturePictureStart] != undefined) {
		$('#picturePictureForm3').append('<input type="hidden" value="${id}" name="userEmailHost">');
		$('#picturePicture3').attr('onclick', 'pictureSubmit(picturePictureForm3)');
	}
	$('.picture').css('opacity', '0.4');
	$('.picture').hover(function(){
		$(this).css('opacity', '1.0');
	},
  	function(){
    	$(this).css('opacity', '0.4');
  	});

});
</script>
</head>
<body>
hello
${sessionScope.userID}
<input type="button" value="로그아웃" onclick="javascript:location.href='/simsns/logout'"><br/>
${id}의 사진 게시판<br>
<form action="board" method="post">
	<input type="submit" value="게시물 게시판">
	<input type="hidden" value="${id}" name="userEmailHost">
</form>
	<table>
		<tr>
			<th id=postPictureTable>
			</th>
			<th style="min-width:100px"></th>
			<th id="picturePictureTable">
			</th>
		</tr>
		<tr>
			<th>게시물 사진</th>
			<th></th>
			<th>사진첩</th>
		</tr>
	</table>
</body>
</html>