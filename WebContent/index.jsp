<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.*" %>
<%@ page import="com.forum.*" %> 


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lanrenzhijia1.css ">
        <link rel="stylesheet" type="text/css" href="css/index.css"/>
        <link rel="stylesheet" type="text/css" href="css/all.css"/>
        <link rel="stylesheet" href="" type="text/css" id="myCss">
       
        <script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js" type="text/javascript"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.validate.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/messages_zh.js" ></script>
	
        <title>首页-论坛</title>
        <style>
	 .fixednav {
	    position: fixed;
	    top: 0px;
	    left: 0px;
	    width: 100%;
	    z-index: 1;
		}
	.fixed {
	    position: fixed;
	    top: 70px;
	    width:297px;
	    margin-left:18px;
	    z-index: 1;
	    float:right;
		}
		
		
        </style>
         <script type="text/javascript">
    		$(function(){
    			var nav=$(".header"); //得到导航对象
    			var win=$(window); //得到窗口对象
    			var sc=$(document);//得到document文档对象。
    			win.scroll(function(){
    			  if(sc.scrollTop()>=100){
    			    nav.addClass("fixednav"); 
    			   $(".header").fadeIn(); 
    			  }else{
    			   nav.removeClass("fixednav");
    			  }
    			}) 
    			var nav1=$(".right"); //得到导航对象
    			var win1=$(window); //得到窗口对象
    			var sc1=$(document);//得到document文档对象。
    			win1.scroll(function(){
    			  if(sc1.scrollTop()>=100){
    			    nav1.addClass("fixed"); 
    			    $(".right").fadeIn(); 
    			  }else{
    			   nav1.removeClass("fixed");
    			  }
    			}) 

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
    			
    				setInterval("test()",1000);
					test=function(){
					    $.ajax({
					        type: "get",
					        url: "${pageContext.request.contextPath}/recive.message",
					        async: true,
					        dataType:"json",
					        success: function(data, textStatus) { 
					        	if(data.isNew==false){
					        	$("#redpoint").css("display","none");	
					        	}else{
					            $("#redpoint").css("display","inline-block");					        		
					        	}
					        }
					    });
					} 
					
					
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
					//发帖判断用户是否登录
					$("#new").click(function(){
						if(${ empty user}){
							$('.theme-popover-mask').fadeIn(100);
							$('.theme-popover').slideDown(200);
						}else{
							window.location.href = "${pageContext.request.contextPath }/NewText.jsp";
						}
						
					});
					$('.theme-poptit .close').click(function(){
						$('.theme-popover-mask').fadeOut(100);
						$('.theme-popover').slideUp(200);
					})
					//用户密码判断
					$("#login-click").click(function(){
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
    		
    		//收藏判断用户是否登录
    		function checkCollection(t){
				if(${ empty user}){
					$('.theme-popover-mask').fadeIn(100);
					$('.theme-popover').slideDown(200);
				}else{
					window.location.href = "${pageContext.request.contextPath }/collection.personal?tid="+t;
				}
    		}
    		
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
    		function showdiv(i) {
    			$("#hideAll"+i).css("display","block");
    			$("#showAll"+i).css("display","none");
    			$("#ftext"+i).css("display","none")
    			$("#stext"+i).css("display","block")
    			}
    		function showdiv_img(i) {
    			$("#hideAll"+i).css("display","block");
    			$("#showAll"+i).css("display","none");
    			$("#ftext"+i).css("display","none")
    			$("#stext"+i).css("display","block")
    			}
    		function hidediv(i) {
    			$("#hideAll"+i).css("display","none");
    			$("#showAll"+i).css("display","block");
    			$("#ftext"+i).css("display","display")
    			$("#stext"+i).css("display","none")
    			}
    		function hidediv_img(i) {
    			$("#hideAll"+i).css("display","none");
    			$("#showAll"+i).css("display","block");
    			$("#ftext"+i).css("display","block")
    			$("#stext"+i).css("display","none")
    			}
    		function changePage(currentPage) {
    			if(currentPage > $("#totalPage").html()){
    				return ;
    			}
    			if (currentPage <= 0) {
    				return ;
    			}
    			$("#page").val(currentPage);
    			$("#changePageForm").submit();// 手动提交表单
    		}
    		function go_page() {
    			if($("#page").val() > $("#totalPage").html()){
    				return ;
    			}
    			if ($("#page").val() <= 0) {
    				return ;
    			}
    			$("#changePageForm").submit();
    		}
    		function go_page(i) {
    			if(i > $("#totalPage").html()){
    				return ;
    			}
    			if (i <= 0) {
    				return ;
    			}
    			$("#page").val(i)
    			$("#changePageForm").submit();
    		}
    		function go() {
    			$("#changePageForm").submit();
    		}
    		function del() {
    			var msg = "您真的确定要删除吗？";
    			if (confirm(msg)==true){
    			return true;
    			}else{
    			return false;
    			}
    		}
    		
    		
    		function change(type)
    		   {
    		       if(type == "black")
    		     {
    		    	   
    		          document.getElementById("myCss").href="${pageContext.request.contextPath }/css/black.css";
    		     }
    		     if(type == "gray")
    		    {
    		    	 
    		         document.getElementById("myCss").href="${pageContext.request.contextPath }/css/gray.css"; 
    		    }
    		    if(type == "blue")
    		    {
    		        document.getElementById("myCss").href="${pageContext.request.contextPath }/css/blue.css"; 
    		    }
    		    if(type == "index")
    		    {
    		        document.getElementById("myCss").href="${pageContext.request.contextPath }/css/index.css"; 
    		    }
    		    return ;
    		  }
    		</script>
    </head>
    <body>
    
     	<%--一键换皮肤--%>
     	 <div  class="color-change">
     	 <ul>
     	 	<li style="color:#175199;font-size:25px">换肤</li>
     	 	<li> <a onclick="change('index')" style="color:rgb(255, 255, 255);"><span class="fa fa-circle"></span></a></li>
     	 	<li> <a onclick="change('gray')" style="color:rgb(206, 120, 84);"><span class="fa fa-circle"></span></a></li>
     	 	<li> <a onclick="change('blue')" style="color:rgb(130, 185, 224);"><span class="fa fa-circle"></span></a></li>
     	 	<li><a onclick="change('black')" style="color:rgb(152, 194, 66);"><span class="fa fa-circle"></span></a></li>
     	 </ul>
 		</div> 
 		
 		<%--登录弹窗 --%>
 	<div class="theme-popover">
     <div class="theme-poptit">
          <a href="javascript:;" title="关闭" class="close">×</a>
          <h3>登录 是一种态度</h3>
     </div>
     <div class="theme-popbod dform">
           <form class="theme-signin" name="loginform" action="${pageContext.request.contextPath}/login.user" method="get" id="form">
           <div id="error" style="color: red;display: none">用户或密码输入错误</div>
                <ol>
                     <li><h4>你必须先登录！</h4></li>
                     <li><strong>用户名：</strong><input class="ipt" type="text" name="username" size="20" id="username"/></li>
                     <li><strong>密码：</strong><input class="ipt" type="password" name="password" size="20" id="password"/></li>
                     <li><input class="btn btn-primary" type="submit" name="submit" value=" 登 录 " id="login-click"/></li>
                </ol>
           </form>
     </div>
    </div>
     <div class="theme-popover-mask"></div>
    
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
					<span id="redpoint" style="display: none;"><a style="color:red;font-size:15px;" href="${pageContext.request.contextPath }/show.message" target="_blank"><span class="fa fa-envelope" style="margin-right:5px;"></span>新回复!</a></span>				
					<span><a href="${pageContext.request.contextPath }/getmytext.personal">Hi!  ${user.nickname }</a></span>
					<span><a href="${pageContext.request.contextPath}/exit.user">注销</a></span>
				</c:if>
    		</div>
    		</div>
    	</div>
    
    	<div class="whole">
    		<div class="left">
    			<a href="javascript:;" id="new" >发布新帖</a>
    			<c:forEach items="${list }" var="text">
    			<div class="context" name="context${text[0].tId }">
    				<div class="hua">话题:${text[0].bname}</div>
    				
    				<div class="username">
    					<c:if test="${!empty text[2].img}">
    					<img src="${text[2].img}"/>
    					</c:if>
    					<c:if test="${empty text[2].img}">
    					<img src="img/morentouxiang.jpg"/>
    					</c:if>
    					<div class="username-text"><p style="font-size:20px;">${text[2].nickname }</p><p>${text[2].single}</p></div>
    				</div>
    				<div class="title"><a href="${pageContext.request.contextPath }/show.text?tid=${text[0].tId}" target="view_window">${text[0].tname }</a></div>
    				
    			
    				<!-- 不带主题图的显示 -->
    				<c:if test="${empty text[0].img}">
    				<div class="text" id="ftext${text[0].tId }" style="height:50px;overflow:hidden"><a href="${pageContext.request.contextPath }/show.text?tid=${text[0].tId }" target="view_window">
    				${text[0].context }
    				</a>
    				</div>
    				<!-- </div> -->
    				<div class="text" id="stext${text[0].tId }" style="display:none"><a href="${pageContext.request.contextPath }/show.text?tid=${text[0].tId }" target="view_window">${text[0].context}</a><br><a class="a btn" onclick="hidediv(${text[0].tId });" id="hideAll${text[0].tId }"><font color="#175199">收起全文</font></a>
    				</div>
    				 <c:if test="${fn:length(text[0].context) > 100}">
    				<font color="#175199"><a onclick="showdiv(${text[0].tId })" id="showAll${text[0].tId }" class="a">点击查看全文</a></font>
    				</c:if>
    				</c:if>
    				
    				<!-- 带有主题图的格式 -->
    				<c:if test="${!empty text[0].img}">
    				<div class="context-img" id="ftext${text[0].tId }">
    				<img src="${ text[0].img }">
    				<div class="text-inline"  style="height:80px;overflow:hidden"><a href="${pageContext.request.contextPath }/show.text?tid=${text[0].tId }" target="view_window">
    				${text[0].context }
    				</a>
    				</div>
    				<c:if test="${fn:length(text[0].context) > 80}">
    				<font color="#175199"><a onclick="showdiv_img(${text[0].tId })" id="showAll${text[0].tId }" class="a" style="display: block;position: absolute;margin-top: -28px;margin-left:190px">点击查看全文</a></font>
    				</c:if>
    				
    				 
    				</div>
    				<div class="text" id="stext${text[0].tId }" style="display:none"><a href="${pageContext.request.contextPath }/show.text?tid=${text[0].tId }" target="view_window">${text[0].context}</a><br><a class="a btn" onclick="hidediv_img(${text[0].tId });" id="hideAll${text[0].tId }"><font color="#175199">收起全文</font></a>
    				</div>
    				
    				</c:if>
    				
    				
    				
    				
    				<div class="footer">
    				
   					<div class="pinglun">
   					<c:if test="${user.identity==1||user.identity==2}">
	    			<a href="${pageContext.request.contextPath }/delete.text?tid=${text[0].tId}" onclick="return del()">删除</a>
	    			</c:if>
   					</div>
    				<div class="pinglun"><span class="fa fa-comment"></span>评论${text[1] }</div>
	    			<div class="pinglun"><span class="fa fa-paper-plane"></span>访问量${text[0].clicks}</div>
	    			<c:if test="${fn:contains(user.collections,text[0].tId)}">
	    				<%-- <div class="star" id="fstar${text[0].tId }"><a class="blin" href="javascript:void(0);" ><font style="color:#EEAD0E"><span class="fa fa-star"></span>收藏</font></a><a style="display:none" value="${text[0].tId}"></a></div>
    					<div class="star" id="sstar${text[0].tId }" style="display:none"><a class="blin" href="javascript:void(0);" ><span class="fa fa-star"></span>收藏</a><a style="display:none" value="${text[0].tId}"></a></div>
 					--%>
 					
	    				 <div class="star"><a href="javascript:;" onclick="checkCollection(${text[0].tId})"><font style="color:#EEAD0E"><span class="fa fa-star"></span>收藏</font></a></div>
    				 </c:if>
    				<c:if test="${!(fn:contains(user.collections,text[0].tId))}">
	    				<%-- <div class="star" id="fstar${text[0].tId }" style="display:none"><a class="blin" href="javascript:void(0);" ><font style="color:#EEAD0E"><span class="fa fa-star"></span>收藏</font></a><a style="display:none" value="${text[0].tId}"></a></div>
    					<div class="star" id="sstar${text[0].tId }"><a class="blin" href="javascript:void(0);" ><span class="fa fa-star"></span>收藏</a><a style="display:none" value="${text[0].tId}"></a></div>
    				 --%>
	    				
	    				 <div class="star"><a href="javascript:;" onclick="checkCollection(${text[0].tId})"><span class="fa fa-star"></span>收藏</a></div>
    				 </c:if>
    				</div>
    			</div>
    			</c:forEach>
    			<form id="changePageForm" action="${pageContext.request.contextPath }/TextServlet?bid=${bid}" method="post">
    			<div class="page">
    				<div class="block"><a href="javascript:void(0);" onclick="changePage(1)">首页</a></div>    				
    				<div class="block"><a href="javascript:void(0);" onclick="changePage(${pageBean.currentPage}-1)">上一页</a></div>
    				<c:forEach begin="0" end="4" var="i">
    				<c:if test="${(pageBean.currentPage+i-2)>0 &&(pageBean.currentPage+i-2)<=pageBean.totalPage}">
	    				<c:if test="${(pageBean.currentPage+i-2)==(pageBean.currentPage) }">
	    				<div class="block"><a href="javascript:void(0);" onclick="go_page(${pageBean.currentPage+i-2 })" style="color:rgb(0, 119, 230)">${pageBean.currentPage+i-2 }</a></div>
	    				</c:if>
	    				<c:if test="${(pageBean.currentPage+i-2)!=(pageBean.currentPage) }">
	    				<div class="block"><a href="javascript:void(0);" onclick="go_page(${pageBean.currentPage+i-2 })">${pageBean.currentPage+i-2 }</a></div>
	    				</c:if>
    				</c:if>
    				</c:forEach>
    				<div class="block"><a href="javascript:void(0);" onclick="changePage(${pageBean.currentPage}+1)">下一页</a></div>
    				<font>主题帖共<B>${pageBean.totalCount }</B>条,共<B id="totalPage">${pageBean.totalPage }</B>页  </font>
    			 	<input type="text" size="3" id="page" name="currentPage" value="${pageBean.currentPage}" style="display:none"/>
    			</div>
    			</form>
    		</div>
    		 <div class="right">
    			<div class="bankuai">
    				<div style="width: 100%;height: 20px;"></div>
    				<div class="huati">话题</div>
    				<ul>
    				<li><a href="${pageContext.request.contextPath }/TextServlet?bid=1"><span class="fa fa-graduation-cap" style="display: block;font-size: 40px;margin-bottom: 20px;color:rgb(255, 207, 0);"></span>学习</a></li>
    				<li><a href="${pageContext.request.contextPath }/TextServlet?bid=2"><span class="fa fa-heartbeat" style="display: block;font-size: 40px;margin-bottom: 20px;color: red;"></span>情感</a></li>
    				<li><a href="${pageContext.request.contextPath }/TextServlet?bid=3"><span class="fa fa-podcast" style="display: block;font-size: 40px;margin-bottom: 20px;color: rgb(67, 212, 128);"></span>娱乐</a></li>
    				</ul>
    			</div>
    			<div class="hot">
    				<div style="width: 100%;height: 20px;"></div>
    				<div class="huati">绿帽热搜</div>
    				<ul>
    				<c:forEach items="${hot}" var="text">
    				<li><span class="fa fa-fire"></span><a href="${pageContext.request.contextPath }/show.text?tid=${text.tId }" target="view_window">${text.tname}</a></li>
    				</c:forEach>
    				</ul>
    			</div>
    			<div class="hot">
	    			<div style="width: 100%;height: 20px;"></div>
	    			<div class="huati">友情链接</div>
	    			<ul>
	    				<li><a href="http://192.168.4.87:8080/Website/jsp/index.jsp" style="color:rgb(63, 68, 78)"><span class="fa fa-film" style="color:rgb(63, 68, 78)"></span>合作电影网站</a></li>
	    				<li><a href="http://192.168.4.12:8080/program/init.hello" style="color:rgb(47, 218, 184)"><span class="fa fa-shopping-cart" style="color:rgb(47, 218, 184)"></span>合作商城网站</a> </li>
	    				<li><a href="http://192.168.4.55:8080/Insight/Index" style="color:rgb(34, 34, 34)"><span class="fa fa-music" style="color:rgb(34, 34, 34)"></span>合作音乐网站</a> </li>
	    			</ul>
	    			<div class="hezuo">小组成员：王振哲，马洁，宣呈辉，龙丽媛</div>
    			</div>
    		</div> 
    	</div>
 	</body>
</html>