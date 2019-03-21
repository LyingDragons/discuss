<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/all.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/modify.css" />
		<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js" type="text/javascript"></script>
		<title>编辑个人资料</title>
		 <script type="text/javascript">
		 
		 $(function(){
			 $("#word").keyup(function(){
 				$.ajax({
 					type:"get",
 					async:true,
 					url:"${pageContext.request.contextPath}/SearchWord",
 					data:{"word":$("#word").val()},
 					dataType:"json",
 					success: function(data){
 						$("#search").html("<div class=\"search-div-title\">搜索结果</div>");
							for (var i = 0;i < data.length;i++) {
								if (i == 4){
									break;
								}
								var div = "<div class=\"search-div-block\"  onmouseover='over(this)' onmouseout='out(this)' onclick='click1(this)'>" + data[i].tname+"</div>";
								$("#search").html($("#search").html()+div);
							}
							$("#search").css("display","block");
 						}
 					
 				})
 			})
		
			 $("#text").click(function() {
				 
					
							$("#mypinglun").css("display","none");
							$("#mycol").css("display","none");
							$("#mytext").css("display","block");
					
					});
			 
			 
			 $("#pinglun").click(function() {
				 
							$("#mypinglun").css("display","block");
							$("#mycol").css("display","none");
							$("#mytext").css("display","none");  
				
					});
			 
			 
			 
			 $("#col").click(function() {
				
					
							$("#mypinglun").css("display","none");
							$("#mycol").css("display","block");
							$("#mytext").css("display","none");
					
					});
			 
		 })
		 function over(obj) {
				$(obj).css("background-color","#ccc");
								}
			function out(obj) {
				$(obj).css("background-color","white");
								}
			function click1(obj) {
				$("#word").val($(obj).text());
				}
    		
    		function outSearch(obj){
    			$("#search").css("display","none")
    		}
		 
		 </script>
	</head>
	<body>
		<div class="header">
    	<div class="header-div">
    		<div class="logo">
	    		<span style="color: green;">绿</span>帽论坛   		
    		</div>
    		<div class="list">
	    		<ul>
	    			<li><a href="${pageContext.request.contextPath }/TextServlet">首页</a></li>
	    		</ul>
    		</div>

    		<form id="searchByWord" action="${pageContext.request.contextPath }/TextServlet" style="width:200px;display:inline-block;margin-right:200px;">
    		  <div class="search">
    			<input type="text" placeholder="输入搜索内容" name="word" id="word"/>
    			<div class="search-div" id="search" onmouseleave='outSearch(this)'></div>
    			<button class=" fa fa-search" style='cursor:pointer;' onclick="searchByWord()"></button>
    		</div>
    		</form>
    		<div class="user">
					   			
    			<c:if test="${empty user}">
					<span><a href="${pageContext.request.contextPath }/jsp/login.jsp">登录</a></span>
					<span><a href="${pageContext.request.contextPath }/jsp/zhuce.jsp">注册</a></span>
				</c:if>
				<c:if test="${!empty user}">
					<span id="redpoint" style="display: none;"><a style="color:red;font-size:15px;" href="#"><span class="fa fa-envelope" style="margin-right:5px;"></span>新回复!</a></span>				
					<span><a href="${pageContext.request.contextPath }/getmytext.personal">Hi!  ${user.nickname }</a></span>
					<span><a href="${pageContext.request.contextPath}/exit.user">注销</a></span>
				</c:if>
    		</div>
    		</div>
    	</div>
    		
    		<div class="whole">
    			<div class="img">
    			 <img src="${pageContext.request.contextPath }/${xiangduiimg}"/>
    			
    			</div>
    			 
    			<div class="top"></div>
    			<div class="context">
    				<div class="user-context">
    					<div class="goback"><font>编辑个人信息</font><a href="${pageContext.request.contextPath }/getmytext.personal">返回我的主页 > </a></div>
    					
    					<%-- 提交头像表单 --%>
	    			
	    				<form  action="${pageContext.request.contextPath }/FileUpload" method="post" enctype="multipart/form-data"
    					style="position: absolute;margin-left: -135px;margin-top:60px; " >
						<a class="file"><input type="file" name="filename" >更换头像</a>
						<br>
						<br>
						<input type="submit" >
						</form>
					
						<form action="${pageContext.request.contextPath }/modify.personal" method="post">
    					<div class="modify">
    						<h3>昵称</h3>
    						<input  type="text" value="${user.nickname }" class="input" name="nickname" placeholder="请填写昵称"/>
    					</div>
    					<div class="modify">
    						<h3>密码</h3>
    						<a href="${pageContext.request.contextPath }/jsp/changepsw.jsp">点击修改密码</a>
    					</div>
    					<div class="modify">
    						<h3>手机</h3>
    						<input  type="text" placeholder="请完善手机号" class="input" name="phone" value="${user.phone }"/>
    					</div>
    					<div class="modify">
    						<h3>年龄</h3>
    						<input  type="text" value="${user.age }" class="input" name="age" placeholder="请填写年龄"/>
    					</div>
    					<div class="modify">
    						<h3>性别</h3>
    						<input name="sex" value="m" type="radio" style="margin-left: 150px;" checked>男
    						<input name="sex" style="margin-left: 30px;" value="f" type="radio">女
    					</div>
    					<input  type="text" name="xiangduiimg" value="${xiangduiimg}" placeholder="图片地址" style="display: none;"/>

    					<div class="submit">
    						<button type="submit">提交</button>
    					</div>
    					</form>
    				</div>
    			</div>
    		</div>
	</body>
</html>
