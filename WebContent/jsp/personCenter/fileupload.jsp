<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath }/FileUpload" method="post" enctype="multipart/form-data">
		<input type="file" name="filename"><br>
		<input type="text" name="username" ><br>
		<input type="submit" value="文件上传">
		
		
		<img src="...../userImg/9.jpg" />
	</form>
</body>
</html>