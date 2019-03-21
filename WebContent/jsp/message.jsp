<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*"%>
<%@ page import="com.forum.*"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/index.css" />
<link rel="stylesheet" type="text/css" href="css/all.css" />
<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js" type="text/javascript"></script>
        
<title>我的信箱</title>
<style>
body {
	background:
		url(//s2.hdslb.com/bfs/static/blive/blfe-message-web/static/img/infocenterbg.a1a0d15.jpg)
		top/cover no-repeat fixed;
	font-size: 12px;
	line-height: 12px;
	color: #666;
	padding: 0;
	margin: 0;
}

.system-item[d6] {
	line-height: 24px;
	position: relative;
}

.card[d7], .is-ie .card[d7] {
	box-shadow: 0 2px 4px 0 rgba(121, 146, 185, .54);
}

.card[d7] {
	padding: 24px 16px;
	background-color: #fff;
	margin-bottom: 10px;
	border-radius: 4px;
}

#link-message {
	width: 50%;
	padding-left: 25%;
}
</style >

<script type="text/javascript">
		$(function(){ 
			$(".readAll").click(function(){
				$.ajax({
					type:"get",
					async:true,
					url:"${pageContext.request.contextPath}/checkAll.message",
					success: function(data){
						window.location.reload();
						},
					})
			});
		
		
		});
	
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
    		<div class="user">
    			<c:if test="${empty user}">
					<span><a href="${pageContext.request.contextPath }/jsp/login.jsp">登录</a></span>
					<span><a href="${pageContext.request.contextPath }/jsp/zhuce.jsp">注册</a></span>
				</c:if>
				<c:if test="${!empty user}">
					<span id="redpoint" style="display: none;"><a style="color:red;font-size:15px;" href="${pageContext.request.contextPath }/show.message" target="_blank"><span class="fa fa-envelope" style="margin-right:5px;"></span>新回复!</a></span>				
					<span><a href="${pageContext.request.contextPath }/getmytext.personal">Hi!  ${user.nickname }</a></span>
					<span><a href="${pageContext.request.contextPath}/exit.user">注销</a></span>
				</c:if>
    		</div>
    		</div>
    	</div>
	
		<br><br><br><br><br><br>
		<div id="link-message">
			<div id="link-message-container" class="">
				<div class="container">
					<div class="space-right">
						<div class="space-right-top">
							<div class="title">
								<div>系统通知<button class="readAll" style="margin-left:80%">全部已读</button></div>
							</div>
						</div>
						<div class="space-right-bottom ps ps--theme_default">
							<div class="router-view" style="">
								<!---->
								<div class="system">
									<div>
										<div>
											<c:forEach items="${list }" var="message">
												<div d7="" d6="" class="card system-item">
													<div d6="" d7="" class="top">
														<span d6="" d7="" class="title">来自${message[0].senderid }</span><span
															d6="" class="time" d7="" style="padding-left: 70%;">${message[0].date }</span>
													</div>
													<div d6="" d7="" class="bottom">
														<span d6="" class="text" d7=""> <!----> <span>您的帖子<a
																href="${pageContext.request.contextPath }/read.message?tid=${message[1].tId }&mid=${message[0].mid }">${message[1].tname }</a>收到了新的回复
														
													</div>
												</div>
											</c:forEach>

										</div>
									</div>
								</div>
							</div>
							<div class="ps__scrollbar-x-rail" style="left: 0px; bottom: 0px;">
								<div class="ps__scrollbar-x" tabindex="0"
									style="left: 0px; width: 0px;"></div>
							</div>
							<div class="ps__scrollbar-y-rail"
								style="top: 0px; right: 0px; height: 679px;">
								<div class="ps__scrollbar-y" tabindex="0"
									style="top: 0px; height: 0px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
</body>
</html>