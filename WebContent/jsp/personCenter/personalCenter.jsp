<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width ,initial-scale=1">
        <title>个人中心</title>
        <link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet"/>
        <script src="${pageContext.request.contextPath }/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath }/js/bootstrap.js"></script>
        
    </head>
    <body class="container " >
    	<div style="text-align: center;"><h4>休闲交流论坛</h4></div>
    	<ul class="nav nav-pills">
			<li role="presentation" class="active"><a href="${pageContext.request.contextPath }/TextServlet">主页</a></li>
			<li role="presentation"><a href="${pageContext.request.contextPath }/TextServlet">热门帖子</a></li>
			<li role="presentation"><a href="${pageContext.request.contextPath }/score.personal">账户积分</a></li>
			<li role="presentation" class="dropdown">
				<a class="dropdown-toggle" data-toggle = "dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
				更多<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="aboutUs.jsp">关于我们</a></li>
					<li><a href="#">打赏支持</a></li>
				</ul>
			</li>
			<li role="presentation"><a href="#">退出</a></li>
		</ul>
    	
    	
    	<div style="text-align: center;"><h1>个人中心</h1></div>
    	<div style="background-color: dodgerblue; width: 100% ; height: 250px;" >
    	<!-- <div>  <img src="touxiang.png" style="position: absolute; left: 600px; top: 180px; width: 150px;"/>  </div> -->	
    		
    		
    	
    		<div>  <img src="${pageContext.request.contextPath }/${xiangduiimg}" style="position: absolute; left: 600px; top: 180px; width: 150px;"/>  </div>
			
    		<form action="${pageContext.request.contextPath }/FileUpload" method="post" enctype="multipart/form-data"
    				style="position: absolute; left: 900px; top: 180px; width: 150px;">
			<input type="file" name="filename" value="跟换头像"><br>
			<input type="submit" value="文件上传">
			</form>
			
    		<div style="text-align: center;"> <p style="color: white; position: absolute; left: 600px; top: 350px; width: 150px; font-size: 20pt;">${user.nickname}</p>  </div>
    	</div>
    	<br />
    	<br />
    	<div class="row" >
    		<div class="col-sm-4 bg-success text-center"><a href="${pageContext.request.contextPath }/mytext.personal" style="font-size: 20pt;">我的帖子</a></div>
    		
    		<div class="col-sm-4 bg-success text-center"><a href="${pageContext.request.contextPath }/jsp/personCenter/modify.jsp" style="font-size: 20pt;">修改资料</a></div>
    		<div class="col-sm-4 bg-success text-center"><a href="${pageContext.request.contextPath }/score.personal" style="font-size: 20pt;">账户积分</a></div>
    	</div>
    	<br />
    	
    	
    	<c:forEach items="${text_list}"  var="text">
    		<br />
    		<div style="text-align: center; height: 150px; background-color: lightyellow;">
    			<!--${text.tname}  <br />-->
    			<h3> <a href="#">如何提高效学习</a> </h3>   
    		</div>
    		
    		</c:forEach>
    	
    	
    	
    	
    	
    	
    	
    	
    	
 	</body>
</html>