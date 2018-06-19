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
function deletePicture(picturePictureForm) {
	if(confirm("정말 삭제하시겠습니까?") == true) {
		picturePictureForm.submit();
	} else {
		return;
	}
}
function updatePicture(picturePictureForm) {
	picturePictureForm.action = "updatePicture";
	picturePictureForm.submit();
}
$(document).ready(function() {
	if(pictureList.length == 0) {
		$('#noPicture').submit();
	}
	var pictureIndex = 0;
	pictureList.some(function(picture, i){
		$('#pictureTable').append('<table style="display:inline">'
				+ '<tr>'
				+ '<th>'
				+ '<form action="deletePicture" method="post" style="display:inline" id="picturePictureForm' + pictureIndex + '">'
				+ '<img id="postPicture' + pictureIndex + '" width="150" height="150"'
				+ 'src="resources/picture/' + picture.picturePath + '">'
				+ (
						("${sessionScope.userID}" == picture.userEmailGuest) ?
							'<input type="button" value="삭제" onclick="deletePicture(picturePictureForm' + pictureIndex + ')">'
							+ '<input type="button" value="수정" onclick="updatePicture(picturePictureForm' + pictureIndex + ')">'
							+ '<input type="hidden" value="' + picture.pictureNo + '" name="pictureNo">'
							+ '<input type="hidden" value="' + picture.pictureTimestamp + '" name="pictureTimestamp">'
							+ '<input type="hidden" value="${id}" name="userEmailHost">'
							: ''
				)
				+ '</form>'
				+ '</th>'
				+ '</tr>'
				+ '<tr>'
				+ '<th>'
				+ new Date(Number(picture.pictureTimestamp)).toString() + '<br>'
				+ '작성자 : ' + picture.userEmailGuest + '<br>'
				+ '제목 : ' + picture.pictureTitle
				+ '</th>'
				+ '</tr>'
				+ '</table>');
		if(pictureIndex % 2 == 1) {
			$('#pictureTable').append('<br>');
		}
		if($("body").height() > $(window).height() && (pictureList.length - 1 == pictureIndex || pictureIndex % 2 == 1)) {
			return (pictureIndex == pictureIndex);
		}
		pictureIndex++;
	});
	pictureIndex++;
	
	$(window).resize(function(){
		while($("body").height() <= $(window).height() || (pictureIndex % 2 == 1)){
			if(pictureIndex < pictureList.length) {
				picture = pictureList[pictureIndex];
				$("#pictureTable").append('<table style="display:inline">'
						+ '<tr>'
						+ '<th>'
						+ '<form action="deletePicture" method="post" style="display:inline" id="picturePictureForm' + pictureIndex + '">'
						+ '<img id="postPicture' + pictureIndex + '" width="150" height="150"'
						+ 'src="resources/picture/' + picture.picturePath + '">'
						+ (
								("${sessionScope.userID}" == picture.userEmailGuest) ?
									'<input type="button" value="삭제" onclick="deletePicture(picturePictureForm' + pictureIndex + ')">'
									+ '<input type="button" value="수정" onclick="updatePicture(picturePictureForm' + pictureIndex + ')">'
									+ '<input type="hidden" value="' + picture.pictureNo + '" name="pictureNo">'
									+ '<input type="hidden" value="' + picture.pictureTimestamp + '" name="pictureTimestamp">'
									+ '<input type="hidden" value="${id}" name="userEmailHost">'
									: ''
						)
						+ '</form>'
						+ '</th>'
						+ '</tr>'
						+ '<tr>'
						+ '<th>'
						+ new Date(Number(picture.pictureTimestamp)).toString() + '<br>'
						+ '작성자 : ' + picture.userEmailGuest + '<br>'
						+ '제목 : ' + picture.pictureTitle
						+ '</th>'
						+ '</tr>'
						+ '</table>');
				if(pictureIndex % 2 == 1) {
					$('#pictureTable').append('<br>');
				}
				pictureIndex++;
			} else {
				break;
			}
		}
	});
	
	$(window).scroll(function() {
		if ($(window).scrollTop() + 1 >= $(document).height() - $(window).height() || (pictureIndex % 2 == 1)) {
			if(pictureIndex < pictureList.length) {
				picture = pictureList[pictureIndex];
				$("#pictureTable").append('<table style="display:inline">'
						+ '<tr>'
						+ '<th>'
						+ '<form action="deletePicture" method="post" style="display:inline" id="picturePictureForm' + pictureIndex + '">'
						+ '<img id="postPicture' + pictureIndex + '" width="150" height="150"'
						+ 'src="resources/picture/' + picture.picturePath + '">'
						+ (
								("${sessionScope.userID}" == picture.userEmailGuest) ?
									'<input type="button" value="삭제" onclick="deletePicture(picturePictureForm' + pictureIndex + ')">'
									+ '<input type="button" value="수정" onclick="updatePicture(picturePictureForm' + pictureIndex + ')">'
									+ '<input type="hidden" value="' + picture.pictureNo + '" name="pictureNo">'
									+ '<input type="hidden" value="' + picture.pictureTimestamp + '" name="pictureTimestamp">'
									+ '<input type="hidden" value="${id}" name="userEmailHost">'
									: ''
						)
						+ '</form>'
						+ '</th>'
						+ '</tr>'
						+ '<tr>'
						+ '<th>'
						+ new Date(Number(picture.pictureTimestamp)).toString() + '<br>'
						+ '작성자 : ' + picture.userEmailGuest + '<br>'
						+ '제목 : ' + picture.pictureTitle
						+ '</th>'
						+ '</tr>'
						+ '</table>');
				if(pictureIndex % 2 == 1) {
					$('#pictureTable').append('<br>');
				}
				pictureIndex++;
			}
		}
	});
});
</script>
</head>
<body>
<form action="picture" method="post" id="noPicture">
	<input type="hidden" value="${id}" name="userEmailHost">
</form>
${id}의  사진첩<br>
<div id="pictureTable"></div>
</body>
</html>