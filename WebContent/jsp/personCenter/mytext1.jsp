<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mytext.css" />
	    <script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js" type="text/javascript"></script>
		
		<title></title>
		<script type="text/javascript">
			
			
		<%-- 	onload=function(){
				location.href="jsp/personCenter/personal.jsp";
			}
		--%>		
			
		
		
		</script>
	</head>
	<body>
		<div class="context">
    				<div class="hua">话题:娱乐</div>
    				<div class="username"><span class="fa fa-user"></span>我是你爸爸</div>
    				<div class="title"><a href="#">王者荣耀司马懿怎么玩？</a></div>
    				<div class="text"><a href="#">司马懿一到商店，所有英雄便都看着他笑，有的叫道，“司马懿，你又被大削了了！”他不回答，对框里说，“来两本咒术典籍，要一个红玛瑙。”便排出九百文大钱。...<font color="#175199">点击查看全文</font></a></div>
    				<div class="footer">
    				<div class="pinglun"><span class="fa fa-comment"></span>评论${text[1] }</div>
	    			<div class="pinglun"><span class="fa fa-paper-plane"></span>访问量${text[0].clicks}</div>
    				</div>
    			</div>
    		这是进入text1了
    		<c:forEach items="${list }" var="text" begin="0" end="5" step="1">
    		<div class="context">
    		<div class="hua">话题:${ text.bname }</div>
    		<div class="username"><span class="fa fa-user"></span>${user.nickname }</div>
    		<div class="title"><a href="#">${text.tname }</a></div>
    		<div class="text"><a href="#">${ text.context }<font color="#175199">点击查看全文</font></a></div>
    		<div class="footer">
    		<div class="pinglun"><span class="fa fa-comment"></span>4条评论</div>
    		<div class="star"><a href="#"><span class="fa fa-star"></span>收藏</a></div>
    		</div>
    		</div>
    		</c:forEach>	
	</body>
</html>
