<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width ,initial-scale=1">
<link href="css/bootstrap.css" rel="stylesheet"/>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>
<title>我的帖子</title>
</head>
<body class="container bg-info" style="background-color: lightyellow;">
<div class="page-header"><h1>我的帖子</h1></div>


   
	<table class="table table-bordered table-hover">
		<!-- class="table table-bordered table-hover" -->
	<thead>
	<th>帖子标题</th>
	<th>帖子内容</th>
	<th>发帖时间</th>
	<th>点击量</th>
	</thead>
	<tbody>
	<c:forEach items="${mylist }"  var="text">
		<tr>
		<td>${text.tname }</td>
		<td>${text.context }</td>
		<td>${text.date }</td>
		<td>${text.clicks }</td>
		</tr>
	</c:forEach>
	</tbody>
	</table>
	
	

</body>
</html>