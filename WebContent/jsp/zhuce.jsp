<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="user-scalable=no,width=device-width,initial-scale=1,maximum-scale=1">
	<title>注册</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/login.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/messages_zh.js" ></script>
	<script type="text/javascript">
	$(function(){
		$.validator.addMethod("isExists",function(value,element,params){
			var isPass = false;
			$.ajax({
				url:"${pageContext.request.contextPath}/zhuce.user",
				data:{"username":value},
				success:function(data){
					//data.isExists == true; //用户名存在-不可用-不能通过-校验方法返回false
					isPass = !data.isExists;
				},
				dataType:"json",
				async:false//同步
			});
			// return true 校验通过
			// return false 校验不通过
			return isPass;
		});
		$.validator.addMethod("isExistsEmail",function(value,element,params){
			var isPass = false;
			$.ajax({
				url:"${pageContext.request.contextPath}/zhuceEmail.user",
				data:{"email":value},
				success:function(data){
					isPass = !data.isExistsEmail;
				},
				dataType:"json",
				async:false//同步
			});
			return isPass;
		});
		$("#form").validate({
			rules:{
				username:{
					isExists:true,
					required:true
				},
				email:{
					isExistsEmail:true,
					required:true
				},
				password:{
					required:true
				},
				nickname:{
					required:true
				}
			},
			messages:{
				username:{
					//<div style="font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70"></div>
					isExists:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×用户名已存在</div>",
					required:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×用户名不能为空</div>"
				},
				email:{
					isExistsEmail:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×邮箱已被注册</div>",
					required:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×邮箱不能为空</div>"
				},
				password:{
					required:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×密码不能为空</div>"
				},
				nickname:{
					required:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×昵称不能为空</div>"
				}
			}
		});
	});
	
	</script>
	<style type="text/css">
		#username-error{color: #EA5A70;}
		#email-error{color: #EA5A70;}
		#password-error{color: #EA5A70;}
		#nickname-error{color: #EA5A70;}
	</style>
</head>
<body>
	<div class="login_cont">
		<div class="login_nav">
				<font size="5">会员注册</font>
				
		</div>
		<form action="${pageContext.request.contextPath }/next.user" name="f" method="get" id="form">
				<input class="input" id="username" type="text" aria-label="用户名（包含字母／数字／下划线" placeholder="请输入用户名" name="username">
				<div class="hint">⚠️请输入4-12个字符的用户名</div>
				<input class="input" id="nickname" type="text" aria-label="用户名（包含字母／数字／下划线" placeholder="请输入论坛昵称" name="nickname">
				<div class="hint">⚠️请输入1-12个字符的昵称名</div>
				<input class="input" id="password" type="password" aria-label="密码" placeholder="密码（不少于 6 位）" name="password">
				<div class="hint">⚠️请输入6位以上密码</div>
				<input class="input" id="repassword" type="password" aria-label="密码" placeholder="再次输入密码">
				<div class="hint">⚠️请再次输入密码</div>
				<input class="input" id="email" type="text" aria-label="邮箱" placeholder="邮箱" name="email">
				<div class="hint">⚠️邮箱是您找回密码的唯一凭证，请谨慎填写</div>
				<input  type="radio" name="sex" value="f" style="width: 30px;" id="f" checked/>女
				<input  type="radio" name="sex" value="m" style="width: 30px;" id="m"/>男
				<input type="submit" id="submit" class="button" name="button" value="下一步">
			
		</form>
		
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/form.js"></script> 
</body>
</html>