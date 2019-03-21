<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/all.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/personal.css"/>
		<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js" type="text/javascript"></script>
		
		  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		  
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
				searchByWord();
				}
			function searchByWord(){
    			$("#searchByWord").submit();
    		}
    		function outSearch(obj){
    			$("#search").css("display","none")
    		}
		 
		 </script>
		<title>个人中心</title>
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
	    		<div class="top-gray"></div>
	    		<div class="top-white">
	    			<div class="user-img">
							<c:if test="${!empty user.img}">
	    					<img src="${pageContext.request.contextPath }/${user.img}" style="width: 100%; height: 100%;border-radius: 5px;"/>
	    					</c:if>
	    					<c:if test="${empty user.img}">
	    					<img src="${pageContext.request.contextPath}/img/morentouxiang.jpg" style="width: 100%; height: 100%;border-radius: 5px;"/>
	    					</c:if>
	    			</div>
	    			<div class="user-name">
	    				${user.nickname}
	    				<font style="font-size: 15px;margin-left: 50px;font-weight: lighter;color: #77839C;"><span class="fa fa-user-circle"></span>用户权限：
	    				
	    				<c:if test="${user.identity==0}">
	    				普通用户
						</c:if>
						<c:if test="${user.identity==1}">
						<font style="color: #0084ff;; ">
						至尊管理
						</font>					
						</c:if>
						
	    				</font>
	    				<div class="user-bianji"><a href="${pageContext.request.contextPath }/jsp/personCenter/modify1.jsp"><button>编辑个人信息</button></a></div>
	    			</div>
	    		</div>
	    		<div class="mytext">
	    			<ul>
	    				<li><a  id="text">我的帖子</a></li>
	    				<li><a id="pinglun">我的回复</a></li>
	    				<li><a  id="col">我的收藏</a></li>
	    			</ul>
	    		</div>
	    		<!-- 帖子框 -->
	    	<div id="mytext" class="whole-text" style="display: block">
	    		
	    		<c:forEach items="${textlist }" var="text">
	    		<div class="context">
	    		<div class="hua">话题:${ text.bname }</div>
	    		<div class="title"><a href="${pageContext.request.contextPath }/show.text?tid=${text.tId}">${text.tname }</a></div>
	    		<div class="footer">
	    			<div class="pinglun"><a href="${pageContext.request.contextPath }/showEdit.text?tid=${text.tId}" ><span class="fa fa-paper-plane"></span>编辑</a></div>
	    			<div class="pinglun"><span class="fa fa-paper-plane"></span>访问量${text.clicks}</div>
    			</div>
    		</div>
    		</c:forEach>	
	    	</div>
	    
	    	
    		<!-- 评论框 -->
    		<div id="mypinglun" class="whole-text" style="display: none">
    			<c:forEach items="${pinglunlist }" var="common">
		    		<div class="context">
		    		<div class="hua">回复于：${common[0].date }</div>
		    		<div class="hua">主题名：<a href="${pageContext.request.contextPath }/show.text?tid=${common[0].tid}">${common[1] }</a></div>
		    		<div class="title">${ common[0].context }</div>
		    		<div class="footer">
		    			<div class="pinglun"><span class="fa fa-paper-plane"></span>访问量${common[0].floor}</div>
	    			</div>
	    			</div>
    			</c:forEach>	
    		</div>
    		
    		<!-- 我的收藏 -->
    		<div id="mycol" class="whole-text" style="display: none">
    			<c:forEach items="${collectionlist }" var="text1">
	    		<div class="context">
	    		<div class="hua">话题:${ text1.bname }</div>
	    		<div class="title"><a href="${pageContext.request.contextPath }/show.text?tid=${text1.tId}">${text1.tname}</a></div>
	    		<div class="footer">
	    			<div class="pinglun"><span class="fa fa-paper-plane"></span>访问量${text1.clicks}</div>
    			</div>
    		</div>
    		</c:forEach>	
    		</div>
    		</div>
    		
    		
    		
	</body>
</html>
