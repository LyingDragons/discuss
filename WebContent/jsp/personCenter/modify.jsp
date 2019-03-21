<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="user-scalable=no,width=device-width,initial-scale=1,maximum-scale=1">
	<title>信息修改</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/login.css">
	
</head>
<body>
	<div class="login_cont">
		<div class="login_nav">
				<font size="5">信息修改</font>
		</div>
		<form action="${pageContext.request.contextPath }/modify.personal" method="post">
				
				<input class="input" id="nickname" type="text" aria-label="用户名（包含字母／数字／下划线" placeholder="论坛昵称" name="nickname"; >
				<div class="hint">请填写符合格式的昵称</div>
				<input class="input" id="password" type="password" aria-label="密码" placeholder="密码（不少于 6 位）" name="password">
				<div class="hint">请填写符合格式的密码</div>
				<input class="input" id="repassword" type="password" aria-label="密码" placeholder="再次输入密码">
				<div class="hint">请再次输入密码</div>
				<input class="input" id="email" type="text" aria-label="邮箱" placeholder="邮箱" name="email">
				<div class="hint">请填写邮箱</div>
				<input  type="radio" name="sex" value="f" style="width: 30px;" id="f" checked/>女
				<input  type="radio" name="sex" value="m" style="width: 30px;" id="m"/>男
				<input type="submit" id="submit" class="button"  value="修改">
			
		</form>
		
	</div>
	
</body>
</html>