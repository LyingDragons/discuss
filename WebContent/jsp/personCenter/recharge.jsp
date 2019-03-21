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
        <meta name="viewport" content="width=device-width ,initial-scale=1">
        <title>充值中心</title>
        <link href="bootstrap.css" rel="stylesheet"/>
        <script src="jquery.js"></script>
        <script src="bootstrap.js"></script>
        <style>
        	td{vertical-align: middle !important;}
        </style>
    </head>
    <body class="container">
    	<div style="text-align: center;"><h4>休闲交流论坛</h4></div>
    	<ul class="nav nav-pills">
			<li role="presentation" class="active"><a href="#">主页</a></li>
			<li role="presentation"><a>热门帖子</a></li>
			<li role="presentation"><a href="#">账户充值</a></li>
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
    	
    	
    	<div style="text-align: center;"><h1>充值中心</h1></div>
    	<div class="page-header "><p style="font-size: 15pt;">账户余额：10.00元</p></div>
    	<h3>充值处</h3>
    	<table class="table table-bordered table-hover" style="height: 250px;">
    		<tr >
    			<td class="text-center "><a href="#">10元</a></td>
    			<td class="text-center "><a href="#">50元</a></td>
    		</tr>
    		<tr>
    			<td class="text-center "><a href="#">100元</a></td>
    			<td class="text-center "><a href="#">500元</a></td>
    		</tr>
    	</table>
 	</body>
</html>