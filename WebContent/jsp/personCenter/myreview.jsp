<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myreview.css" />
		<title></title>
	</head>
	<body>
		<div class="context"  id="post1strow${reply[0].floor}">
    					<div class="username"><span class="fa fa-user">用户名字</span></div>
    					<div class="huifu">回复：帖子标题</div>
    					<div class="text">评论内容</div>
    					<div class="footer">
		    				<div class="time">评论于时间</div>
    					</div>
    				</div>
    			
	</body>
</html>

