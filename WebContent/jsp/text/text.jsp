<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/lanrenzhijia1.css ">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/text.css" />
		 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/all.css"/>
		 <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/messages_zh.js" ></script>
		<title>${text.tname}</title>
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
	    top: 60px;
	    width:297px;
	    margin-left:14px;
	    z-index: 1;
	    float:right;
		}
        </style>
		<script type="text/javascript">
			$(function() {
	    			var nav=$(".header"); //得到导航对象
	    			var win=$(window); //得到窗口对象
	    			var sc=$(document);//得到document文档对象。
	    			win.scroll(function(){
	    			  if(sc.scrollTop()>=214){
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
	    			  if(sc1.scrollTop()>=214){
	    			    nav1.addClass("fixed"); 
	    			    $(".right").fadeIn(); 
	    			  }else{
	    			   nav1.removeClass("fixed");
	    			  }
	    			})  
				$("#selectAll").click(
					function() {
						$("input[type='checkbox']").prop("checked",$("#selectAll").prop("checked"));
				});
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
    			});
				
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
				
				
				$(".blin").click(function(){
					if(${empty user}){
						$('.theme-popover-mask').fadeIn(100);
						$('.theme-popover').slideDown(200);
					}else{
						//window.location.href = "${pageContext.request.contextPath }/ccollection.personal?tid=${text.tId}";
						$.ajax({
							type:"get",
							async:true,
							url:"${pageContext.request.contextPath}/ccollection.personal?tid=${text.tId }",
							dataType:"json",
							success: function(data){
								if(data.isColl==false){
							        $("#fstar").css("display","none");
							        $("#sstar").css("display","inline-block");
							        }else{
							        $("#fstar").css("display","inline-block");
							        $("#sstar").css("display","none");
							        }
									if(${user.userId==text.userid}){
										$("#cos").text(data.cos)
									2222}
								},
						});
					}
					
					
				});
				
				//校验器
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
							}else{
								window.location.href="${pageContext.request.contextPath}/show.text?tid=${text.tId}";
							}
						},
						dataType:"json",
						async:false
					});
				});
				
			});
			//发言时是否登录
			function checkLogin(i){
				if(${empty user}){
					$('.theme-popover-mask').fadeIn(100);
					$('.theme-popover').slideDown(200);
				}else{
					//window.location.href = "${pageContext.request.contextPath }/.jsp";
					$("#replayForm"+i).submit();
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
				searchByWord()
				}
			function searchByWord(){
	    		$("#searchByWord").submit();
	    	}
    		
    		function outSearch(obj){
    			$("#search").css("display","none")
    		}
    		function showdiv(obj,i) {
    			$("#hideAll"+i).css("display","block");
    			$("#showAll"+i).css("display","none");
    			$("#ftext"+i).css("height","0px")
    			$("#stext"+i).css("display","block")
    			}
    		function hidediv(obj,i) {
    			$("#hideAll"+i).css("display","none");
    			$("#showAll"+i).css("display","block");
    			$("#ftext"+i).css("height","25px")
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
function re1(){
	$("#replayForm1").css("display","block");
	$("#replayForm2").css("display","none");
}
function re2(nickname,date,uid){
	$("#replayForm2").css("display","block");
	$("#replayForm1").css("display","none");
	$("#write-huifu").html("回复："+nickname+"（"+date+"）");
	$("#writehuifu").html(uid+"回复："+nickname+"（"+date+"）");
}



var oTxt = document.getElementById("txt");
/***********************
 * 函数：判断滚轮滚动方向
 * 作者：walkingp
 * 参数：event
 * 返回：滚轮方向 1：向上 -1：向下
 *************************/
 
 var scrollFunc = function(e) {
	var nav=$(".header"); //得到导航对象
	var win=$(window); //得到窗口对象
	var sc=$(document);//得到document文档对象。
	  if(sc.scrollTop()>=200){
	var direct = 0;
	e = e || window.event;
		if(e.wheelDelta>0||e.detail==-3){
			$(".up").css("display","block");
			$(".down").css("display","none");
		}
		if(e.wheelDelta<0||e.detail==3){
			$(".down").css("display","block");
			$(".up").css("display","none");
		}
	ScrollText(direct);
	  }
}
/*注册事件*/
if(document.addEventListener) {
	document.addEventListener('DOMMouseScroll', scrollFunc, false);
} //W3C
window.onmousewheel = document.onmousewheel = scrollFunc; //IE/Opera/Chrome/Safari

</script>
	</head>
	<body>
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
		<div class="up">
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
	    	<div class="down" style="display:none">
	    	<div class="down-div">
	    			<h1>${text.tname}</h1>
	    			<a href="#replayForm1" onclick="re1()"><button><span class="fa fa-pencil-alt" style="margin-right: 5px;"></span>写评论</button></a>
	    	</div>
	    	</div>	
    	</div>
    		<div class="title-whole">
    			<div class="title-context">
    			<div class="type"><a>${text.bname }</a></div>
	    			<h1>${text.tname}</h1>
	    			<a href="#replayForm1" onclick="re1()"><button><span class="fa fa-pencil-alt" style="margin-right: 5px;"></span>写评论</button></a>
	    			<div class="pinglun"><span class="fa fa-comment"></span>${pageBean.totalCount}条评论</div>
    				<div class="pinglun"><span class="fa fa-comment"></span>${text.clicks}次访问</div>
    				<c:if test="${(fn:contains(user.collections,text.tId))}">
    						<div class="star" id="fstar"><a class="blin" href="javascript:void(0);" ><font style="color:#EEAD0E"><span class="fa fa-star"></span>收藏</font></a></div>
    						<div class="star" id="sstar" style="display:none"><a class="blin" href="javascript:void(0);" ><span class="fa fa-star"></span>收藏</a></div>
    				</c:if>
    				<c:if test="${!(fn:contains(user.collections,text.tId))}">
    						<div class="star" id="fstar" style="display:none"><a class="blin" href="javascript:void(0);"><font style="color:#EEAD0E"><span class="fa fa-star"></span>收藏</font></a></div>
    						<div class="star" id="sstar"><a class="blin" href="javascript:void(0);" ><span class="fa fa-star"></span>收藏</a></div>
    				
    				</c:if>
    				</div>
    		</div>
    		<div class="whole">
    			<div class="left">
    				
    				<div class="context" >
    					<div class="main" style="color:rgb(67, 212, 128);">主楼</div>
	    				<div class="username">
		    				<c:if test="${!empty textuser.img}">
	    					<img src="${textuser.img}"/>
	    					</c:if>
	    					<c:if test="${empty textuser.img}">
	    					<img src="${pageContext.request.contextPath}/img/morentouxiang.jpg"/>
	    					</c:if>
		    				<div class="username-text"><p style="font-size:20px;">${textuser.nickname }</p><p>${textuser.single}</p></div>
	    				</div>
	    				<div class="text">${text.context}</div>
	    				<div class="footer">
	    				<div class="time">创建于${text.date}</div>
	    				<div class="pinglun"><a href="#replayForm1" onclick="re1()">评论</a></div>
	    				<c:if test="${user.userId==text.userid }">
	    				<div class="pinglun"><a href="${pageContext.request.contextPath }/showEdit.text?tid=${text.tId}">编辑</a></div>
    					</c:if>
    					</div>
    				</div>
    				<c:forEach items="${replies}" var="reply">
    				<div class="context"  id="post1strow${reply[0].floor}">
    					<div class="username">
	    					<c:if test="${!empty reply[1].img}">
	    					<img src="${reply[1].img}"/>
	    					</c:if>
	    					<c:if test="${empty reply[1].img}">
	    					<img src="${pageContext.request.contextPath}/img/morentouxiang.jpg"/>
	    					</c:if>
	    					<div class="username-text"><p style="font-size:20px;">${reply[1].nickname }</p><p>${reply[1].single}</p></div>
    					</div>
    					<div class="text">${reply[0].context}</div>
    					<div class="footer">
		    				<div class="time">评论于${reply[0].date}</div>
		    				<div class="pinglun"><a href="#replayForm2" onclick="re2('${reply[1].nickname}','${reply[0].date}',${reply[1].userId})">回复</a></div>
		    				<div class="pinglun"><span class="fa fa-piggy-bank"></span>${reply[0].floor}楼</div>
    					</div>
    				</div>
    				</c:forEach>
    				<form id="changePageForm" action="${pageContext.request.contextPath}/show.text?tid=${text.tId}" method="post">
    					<div class="page">
    					<div class="block" style="padding: 15px 15px;"><a href="javascript:void(0);" onclick="changePage(1)">首页</a></div>
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
    						<div class="block" style="padding: 15px 15px;"><a href="javascript:void(0);" onclick="changePage(${pageBean.totalPage})">尾页</a></div>
    						<font>评论共<B>${pageBean.totalCount}</B>条,共<B id="totalPage">${pageBean.totalPage}</B>页  </font>
    			 			<input type="text" size="3" id="page" name="currentPage" value="${pageBean.currentPage}" style="display:none"/>
    					</div>
    				</form>
	    			<form  id="replayForm1" action="${pageContext.request.contextPath}/replay.text?tid=${text.tId}"  method="post">
	    			<div class="write">
	    				<div class="write-textarea">
	    					<textarea placeholder="请输入回复内容" name="context"></textarea>
	    				</div>
	    				<input type="button" value="发表评论" onclick="checkLogin(1)">
	    			</div>
	    			</form>
	    			<form  id="replayForm2" action="${pageContext.request.contextPath}/replay.text?tid=${text.tId}"  method="post" style="display:none">
	    			<div class="write">
	    				<div class="write-huifu" id="write-huifu" ></div>
	    				<textarea id="writehuifu" name="writehuifu" style="display:none"></textarea>
	    				<div class="write-textarea">
	    					<textarea placeholder="请输入回复内容" name="context"></textarea>
	    				</div>
	    				<input type="button" value="发表评论" onclick="checkLogin(2)">
	    			</div>
	    			</form>
    			</div>
    			<div class="right">
    				<div class="userin">
    					<div style="width: 100%;height: 20px;"></div>
    					<div class="huati">作者信息</div>
    					<div class="img-name">
    						<c:if test="${!empty authorInfo[0].img}">
	    					<img src="${authorInfo[0].img}"/>
	    					</c:if>
	    					<c:if test="${empty authorInfo[0].img}">
	    					<img src="${pageContext.request.contextPath}/img/morentouxiang.jpg"/>
	    					</c:if>
	    					
    						<div class=" userin-name">
    						<h2>${authorInfo[0].nickname }</h2>
    						<p>${authorInfo[0].single }</p>
    						</div>
    					</div>
    					<div class="tnum">
    						<div class="num" style="	margin-right:40px ;">
    							发帖数<br />
    							<font>${authorInfo[1]}</font>
    						</div>
    						<div class="num">
    							收藏数<br />
    							<font id="cos">${authorInfo[2]}</font>
    						</div>
    					</div>
    				</div>
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
	    			<div class="huati">友情链接</div>
	    			<ul>
	    				<li><a href="http://192.168.4.87:8080/Website/jsp/index.jsp" style="color:rgb(63, 68, 78)"><span class="fa fa-film" style="color:rgb(63, 68, 78)"></span>合作电影网站</a></li>
	    				<li><a href="http://192.168.4.10:8080/program/init.hello" style="color:rgb(47, 218, 184)"><span class="fa fa-shopping-cart" style="color:rgb(47, 218, 184)"></span>合作商城网站</a> </li>
	    			</ul>
	    			<div class="hezuo">小组成员：王振哲，马洁，宣呈辉，龙丽媛</div>
    			</div>
    			</div>
    		</div>
	</body>
</html>