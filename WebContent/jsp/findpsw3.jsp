<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="user-scalable=no,width=device-width,initial-scale=1,maximum-scale=1">
	<title>找回密码</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/login.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/messages_zh.js" ></script>
	<script type="text/javascript">
	$(function(){
		$("#form").validate({
			rules:{
				password:{
					required:true
				},
			},
			messages:{
				password:{
					required:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×密码不能为空</div>"
				},
			}
		});
	});
	
	</script>
	<style type="text/css">
		#password-error{color: #EA5A70;}
	</style>
</head>
<body>
	<div class="login_cont">
		<div class="login_nav">
				<font size="5">重置密码</font>
				
		</div>
		<form action="${pageContext.request.contextPath }/resetpsw.user?username=${username}" name="f" method="get" id="form">
				<input class="input" id="password" type="password" aria-label="密码" placeholder="新密码（不少于 6 位）" name="password">
				<div class="hint">⚠️请输入6位以上密码</div>
				<input class="input" id="repassword" type="password" aria-label="密码" placeholder="再次输入新密码">
				<div class="hint">⚠️请再次输入密码</div>
				<input type="submit" id="submit" class="button" name="button" value="下一步">
		</form>
		
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/form.js"></script> 
</body>
</html>