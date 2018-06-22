<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
        type : "GET",
        url : "getPost",
        dataType : "json",
        contentType: "application/json",
        error : function(){
            alert('통신실패!!');
        },
        success : function(data){
            $("#dataArea").html(JSON.stringify(data));
        }
    });
});
</script>
</head>
<body>
<div id="dataArea"></div>
</body>
</html>