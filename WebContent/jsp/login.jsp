<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<title>绿帽论坛-绿也是种爱</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/component.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.validate.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/messages_zh.js" ></script>
	<script type="text/javascript">
	$(function() {
		// 校验器
		$("#form").validate({
			rules:{
				username:{
					required:true,
				},
				password:{
					required:true,
				}
			},
			messages:{
				username:{
					required:"<br/>用户名不能为空",
				},
				password:{
					required:"<br/><br/>密码不能为空",
				}
			}
		});
		//用户密码判断
		$("#login").click(function(){
			var usn = $("#username").val();
			var psw = $("#password").val();
			$.ajax({
				url:"${pageContext.request.contextPath}/checkLogin.user?username="+usn+"&password="+psw,
				success:function(data){
					var result = data.user;
					if(!result){
						//$("#error").css("display","block");
						alert("用户名或密码错误");
					}
				},
				dataType:"json",
				async:false
			});
		});
	});
	</script>
</head>
<body>
		<div class="container demo-1">
			<div class="content">
				<div id="large-header" class="large-header">
					<canvas id="demo-canvas"></canvas>
					<div class="logo_box">
						<h3>请登录</h3>
						<div id="error" style="color: white;display: none">用户或密码输入错误</div>
						<form  name="f" method="get" id="form" action="${pageContext.request.contextPath}/login.user ">
							<div class="input_outer" style="margin-bottom:50px">
								<span class="u_user"></span> 
								<input name="username" class="text" style="color: #FFFFFF !important;" type="text" placeholder="请输入用户名" id="username">
							</div>
							<div class="input_outer">
								<span class="us_uer"></span>
								<input name="password" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;"value="" id="password" type="password" placeholder="请输入密码">
							</div>
							<input type="checkbox" value="remember-me" name="autoLogin" id="auto"> 自动登录
							<a href="${pageContext.request.contextPath }/jsp/findpsw1.jsp" style="color:white;margin-left:50%">找回密码</a>
							<div class="mb2">
								<input class="act-but submit" type="submit"  style="color: #FFFFFF;width: 330px;border:none;" value="登录" id="login"/>
								<a class="act-but submit" target="view_window" href="${pageContext.request.contextPath }/html/yindao.jsp" style="color: #FFFFFF">注册</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div><!-- /container -->
	<script src="${pageContext.request.contextPath }/js/TweenLite.min.js"></script>
	<script src="${pageContext.request.contextPath }/js/EasePack.min.js"></script>
	<script src="${pageContext.request.contextPath }/js/rAF.js"></script>
	<script src="${pageContext.request.contextPath }/js/demo-1.js"></script>
	
	</body>
</html>