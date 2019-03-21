<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>编辑</title>
		<link rel="stylesheet" type="text/css" href="css/NewText.css"/>
        <link rel="stylesheet" type="text/css" href="css/all.css"/>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/kindeditor/themes/default/default.css"/>
        <link rel="stylesheet"  href="css/bootstrap.css" media="screen">
		<script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/kindeditor-all-min.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/lang/zh-CN.js"></script>
    	<script charset="utf-8" src="js/jquery-1.11.0.min.js"></script>
        <script charset="utf-8" src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
        	$(function(){
        			$("#imageInput").change(function() {
        		        	if (window.FileReader) {
        		        		var oPreviewImg = null, oFReader = new window.FileReader();
        		        		rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i; 
        		         		
        		         		oFReader.readAsDataURL(this.files[0]);
        		        		oFReader.onload = function(oFREvent){ 
        		        			document.getElementById("img").src = oFREvent.target.result;
        		         
        		        			var width = $("#img").innerWidth();
        		        			var height = $("#img").innerHeight();
        		        			if(width*0.9 < height)
        		        				$("#img").css('height', width*0.9);
        		        		};
        		        		
        		        		return function(){ 
        		        			var aFiles = document.getElementById("imageInput").files; 
        		        			if (aFiles.length === 0) { return; } 
        		        			if (!rFilter.test(aFiles[0].type)) { alert("You must select a valid image file!"); return; } 
        		        			oFReader.readAsDataURL(aFiles[0]); 
        		        		};
        		        		
        		        	} 
        			});
        });
        var editor;
        /* var loadImageFile = (function (e) { 
        	if (window.FileReader) {
        		var oPreviewImg = null, oFReader = new window.FileReader();
        		rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i; 
         		
         		
        		oFReader.onload = function(oFREvent){ 
        			alert(oFREvent);
        			document.getElementById("img").src = oFREvent.target.result;
         
        			var width = $("#img").innerWidth();
        			var height = $("#img").innerHeight();
        			if(width*0.9 < height)
        				$("#img").css('height', width*0.9);
        		};
        		
        		
         
        		return function(){ 
        			var aFiles = document.getElementById("imageInput").files; 
        			if (aFiles.length === 0) { return; } 
        			if (!rFilter.test(aFiles[0].type)) { alert("You must select a valid image file!"); return; } 
        			oFReader.readAsDataURL(aFiles[0]); 
        		};
        		
        	} 
        }); */
        KindEditor.ready(function(K) {
            editor = K.create('textarea[name="content"]', {
                resizeType : 1,
                allowPreviewEmoticons : false,
                allowImageUpload : false,
                items : [
                    'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                    'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                    'insertunorderedlist', '|', 'emoticons', 'image', 'link']
            });
        });
        
        KindEditor.ready(function(K){
        	K.create('textarea[name="content"]',{
        	themeType: 'simple',
        	resizeType: 1,
        	uploadJson:'common/KEditor/upload_json.php',
        	fileManagerJson:'common/KEditor/file_manager_json.php',
        	allowFileManager:true,
        	        //经测试，下面这行代码可有可无，不影响获取textarea的值
        	        //afterCreate:function(){this.sync();}
        	        //下面这行代码就是关键的所在，当失去焦点时执行this.sync();
        	        afterBlur:function(){this.sync();}
        	});
        	});
        
        
        minlen=function(){//判断标题长度
        	var tname=document.getElementById('tname');
        	 if(tname.value.length<1){
        		$("#cant").css("display","inline-block");
        		$("#fakesub").css("display","inline-block");
        		$("#truesub").css("display","none");
        	} else{
        		$("#cant").css("display","none");
        		$("#truesub").css("display","inline-block");
        		$("#fakesub").css("display","none");
        	}
        };
        
        
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
					<span><a href="${pageContext.request.contextPath }/jsp/personCenter/personalCenter.jsp">Hi!  ${user.nickname }</a></span>
					<span><a href="${pageContext.request.contextPath}/jsp/login.jsp">注销</a></span>
				</c:if>
    		</div>
    		</div>
    		</div>
    		<h1>编&nbsp&nbsp辑</h1>
		
    		<div class="whole">
    		
    		<form action="${pageContext.request.contextPath}/edit.text?tid=${text.tId}" method="post">
				
	    		<div class="title">
	    			<input placeholder="输入标题（最多12个字）"  maxlength="12" type="text" name="tname" id="tname" onblur="minlen()" value="${text.tname }"/><span id="cant" style="display:none;color:red">标题不能为空！</span>
	    		</div>
	    	
	    	<div class="context">
	    		 <textarea id="mul_input" name="content" placeholder="请输入内容" >${text.context }</textarea>
	    	</div>
	    	<input  type="text" name="xiangduiimg" value="${xiangduiimg}" placeholder="图片地址" style="display: none;"/>
	    	
	    	<input type="submit" value="发表" class="submit-all" id="truesub" style="display:none;margin-left:40%"/>
	    	<input type="button" value="发表" class="submit-all" id="fakesub" style="margin-left:40%"/>
    	</form> 
    	</div>
	</body>
</html>
    