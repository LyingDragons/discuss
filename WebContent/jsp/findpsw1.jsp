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
		$.validator.addMethod("isExists",function(value,element,params){
			var isPass = false;
			$.ajax({
				url:"${pageContext.request.contextPath}/zhuce.user",
				data:{"username":value},
				success:function(data){
					//data.isExists == true; //用户名存在-不可用-不能通过-校验方法返回false
					isPass = data.isExists;
				},
				dataType:"json",
				async:false//同步
			});
			// return true 校验通过
			// return false 校验不通过
			return isPass;
		});
		$("#form").validate({
			rules:{
				username:{
					isExists:true,
					required:true
				},
			},
			messages:{
				username:{
					//<div style="font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70"></div>
					isExists:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×用户名不存在</div>",
					required:"<div style='font-size: 12px;text-align: right;padding-right: 10px;margin-bottom: 15px;color:EA5A70'>×用户名不能为空</div>"
				},
			}
		});
	});
	
	</script>
	<style type="text/css">
		#username-error{color: #EA5A70;}
	</style>
</head>
<body>
	<div class="login_cont">
		<div class="login_nav">
				<font size="5">找回密码</font>
				
		</div>
		<form action="${pageContext.request.contextPath }/thenemail.user" name="f" method="get" id="form">
				<input class="input" id="username" type="text" aria-label="用户名（包含字母／数字／下划线" placeholder="请输入您要找回密码的用户名" name="username">
				<div class="hint">⚠️请输入4-12个字符的用户名</div>
				<input type="submit" id="submit" class="button" name="button" value="下一步">
			
		</form>
		
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/form.js"></script> 
</body>
</html>