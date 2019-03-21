<!--
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


		这是html页面，把注释去掉是jsp页面，jsyl和jap写不了
-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>关于我们</title>
        <link href="bootstrap.css" rel="stylesheet"/>
        <script src="jquery.js"></script>
        <script src="bootstrap.js"></script>
    </head>
    <body class="container">
    	<div style="text-align: center;"><h4>休闲交流论坛</h4></div>
    	<ul class="nav nav-pills">
			<li role="presentation" class="active"><a href="#">主页</a></li>
			<li role="presentation"><a href="#">热门帖子</a></li>
			<li role="presentation"><a href="recharge.jsp">账户充值</a></li>
			<li role="presentation"><a href="#">网友交流</a></li>
			<li role="presentation" class="dropdown">
				<a class="dropdown-toggle" data-toggle = "dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
				更多<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="#">关于我们</a></li>
					<li><a href="#">打赏支持</a></li>
				</ul>
			</li>
			<li role="presentation"><a href="#">退出</a></li>
		</ul>
		
		
		<img src="7.jpg" />
		<div style="position: absolute;left: 580px; top: 200px;">
		<h1>制作成员</h1>
		<h2>王振哲，马洁，宣成辉，龙丽媛</h2>
		</div>
 	</body>
</html>