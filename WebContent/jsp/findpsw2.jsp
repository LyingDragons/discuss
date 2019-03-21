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
	<link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/gloab.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/index1.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/component.css" />
	<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
	<style type="text/css">
		#beforHint{display: block}
		#afterHint{display: none}
	</style>
</head>

<body >
	<div class="login_cont" style="width: 700px">
		<div class="login_nav"style="width: 700px;">
				<font size="5">找回密码邮箱验证</font>
		</div>
		<div class="alert alert-info" style="width:700px;font-size: 17px" id="beforHint">点击下面按钮发送邮件。</div>  
		<div class="alert alert-info" style="width:700px;font-size: 17px" id="afterHint">一封验证邮件已发送至您的邮箱，请注意查收</div>                  
        <div class="item col-xs-12 f-mb10" style="height:auto">
           <span class="intelligent-label f-fl" style="font-size: 20px">您的验证邮箱：${us.email}</span> 
        </div>

        <form id="form" action="${pageContext.request.contextPath}/thenpsw.user?username=${us.username}" >
        <div class="item col-xs-12" style="margin: 20px;">
           <div class="f-fl item-ifo">
              <span class="intelligent-label f-fl" style="font-size: 22px; margin-right: 20px;">验证码:</span>
              <input type="text" maxlength="6" id="verifyNo" class="txt03 f-r3 f-fl" tabindex="4" style="width:167px"  name="ii"/> 
              <span class="btn btn-gray f-r3 f-ml5 f-size13" id="verifyYz" style="width:97px;">发送验证码</span>
              <span class="ie8 icon-close close hide" style="right:130px"></span>
            </div>
       
        </div>
        <div class="mb2" style="margin-top: 30px" >

			<input type="submit" style="color: #FFFFFF" value="下一步" id="login" class="truesub" />
			<input type="button" style="color: #FFFFFF;display:none;" value="下一步" class="fakesub" />

		</div>
		 </form>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.validate.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/messages_zh.js" ></script>
	
	<script type="text/javascript">
		$(function(){
			$.validator.addMethod("check",function(value,element,params){
				var isPass = false;
				$.ajax({
					url:"${pageContext.request.contextPath}/check.user",
					data:{"ii":value},
					success:function(data){
						isPass = data.ans;
						if(isPass==true){
							$(".truesub").css("display","inline-block");
							$(".fakesub").css("display","none");
						}else{
							$(".fakesub").css("display","inline-block");
							$(".truesub").css("display","none");
						}
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
					ii:{
						check:true,
						required:true
					}
				},
				messages:{
					ii:{
						check:"验证码不正确",
						required:"验证码不能为空"
					}
				}
			});
			var email = getUrlParam("email");
			var username = getUrlParam("username");
			$("#verifyYz").click(function(){
				$("#beforHint").css("display","none");
				$("#afterHint").css("display","block");
				$.ajax({
					url:"${pageContext.request.contextPath}/sendEmailToFind.user",
					data:{"email":email},
					success:function(data){
						
					},
					dataType:"json",
					async:false
				});
			});
			//获取url中的参数
	        function getUrlParam(name) {
	            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	            if (r != null) return unescape(r[2]); return null; //返回参数值
	        }
		});
	</script>

</body>
</html>