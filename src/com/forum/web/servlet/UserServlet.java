package com.forum.web.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.forum.beans.User;
import com.forum.service.UserService;
import com.forum.service.impl.UserServiceImpl;
import com.forum.utils.MD5Utils;

public class UserServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	private UserService us = new UserServiceImpl();
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		uri = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		switch(uri){
		case "login" :
			doLogin(request,response);
			break;
		case "add" :
			doAdd(request,response);
			break;
		case "zhuce" :
			doZhuce(request,response);
			break;
		case "zhuceEmail" :
			doZhuceEmail(request,response);
			break;
		case "sendEmail" :
			doSendEmail(request,response);
			break;
		case "next" :
			doNext(request,response);
			break;
		case "check" :
			doCheck(request,response);
			break;
		case "exit" :
			doExit(request,response);
 			break;
		case "checkLogin":
			doCheckLogin(request,response);
			break;
		case "thenemail" :
			doThenEmail(request,response);
 			break;
		case "thenpsw" :
			doThenPsw(request,response);
 			break;
		case "resetpsw" :
			doResetpsw(request,response);
 			break;
		case "sendEmailToFind" :
			doSendEmailToFind(request,response);
			break;
		case "changePSW" :
			doChangePSW(request,response);
			break;
		}
		

	}
	
	private void doChangePSW(HttpServletRequest request, HttpServletResponse response) {
		String password = request.getParameter("password");
		password=MD5Utils.md5(password);
		String username = ((User)request.getSession().getAttribute("user")).getUsername();
		us.setPSW(password,username);
		System.out.println("修改成功");
		try {
			response.sendRedirect(request.getContextPath()+"/modify.personal");
//			response.sendRedirect(request.getContextPath()+"/modify.personal");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	//发送验证邮箱
		private void doSendEmailToFind(HttpServletRequest request, HttpServletResponse response) {
			String email = request.getParameter("email");
			int i = 1000+(int) (Math.random()*8999);
			request.getSession().setAttribute("i", i);
			us.sendEmailToFind(email,i);
			System.out.println("已发送");
		}
	
	//重置密码
	private void doResetpsw(HttpServletRequest request, HttpServletResponse response) {
		String password = request.getParameter("password");
		password=MD5Utils.md5(password);
		String username = ((User)request.getSession().getAttribute("us")).getUsername();
		us.setPSW(password,username);
		try {
			response.sendRedirect(request.getContextPath()+"/jsp/login.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//下一个页面
	private void doThenPsw(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String username = ((User)request.getSession().getAttribute("us")).getUsername();
		request.setAttribute("username", username);
		try {
			response.sendRedirect(request.getContextPath()+"/jsp/findpsw3.jsp?username="+username);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//下一个页面
	private void doThenEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String username = request.getParameter("username");
		User user = us.findUserByUsername(username);
		request.getSession().setAttribute("us", user);
		try {
			response.sendRedirect(request.getContextPath()+"/jsp/findpsw2.jsp?email="+user.getEmail()+"&username="+username);
			//request.getRequestDispatcher("jsp/findpsw2.jsp?email="+user.getEmail()+"&username="+username).forward(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}


	//注销
	private void doExit(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies=request.getCookies();
		for(Cookie cookie:cookies){
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		}
		request.getSession().setAttribute("user", null);
		try {
			response.sendRedirect(request.getContextPath()+"/jsp/login.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//检查输入验证码是否正确
	private void doCheck(HttpServletRequest request, HttpServletResponse response) {
		//随机生成的验证码
		int i = (int) request.getSession().getAttribute("i");
		System.out.println(i);
		//用户输入的验证码
		int ii = Integer.parseInt(request.getParameter("ii"));
		System.out.println(ii);
		boolean ans = false;
		if(i==ii){
			ans = true;
		}
		try {
			response.getWriter().write("{\"ans\":"+ans+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//传递参数到下一页
	private void doNext(HttpServletRequest request, HttpServletResponse response) {
		Map<String, String[]> parameterMap = request.getParameterMap();
		request.getSession().setAttribute("parameter", parameterMap);
		try {
			request.getRequestDispatcher("/jsp/email.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//发送验证邮箱
	private void doSendEmail(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		int i = 1000+(int) (Math.random()*8999);
		request.getSession().setAttribute("i", i);
		us.sendEmail(email,i);
	}
	//注册 - 添加新用户
	private void doAdd(HttpServletRequest request, HttpServletResponse response) {
		String username  = request.getParameter("username");
		String password = request.getParameter("password");
		password=MD5Utils.md5(password);
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		try {
			nickname=new String(nickname.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String sex = request.getParameter("sex");
		System.out.println("servlet"+username);
		us.add(username,password,email,nickname,sex);
		System.out.println("注冊成功");
		User user = us.doLogin(username,password);
		request.getSession().setAttribute("user", user);
		try {
			response.getWriter().write("{\"user\":"+user+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//注册判断用户名是否重复
	private void doZhuce(HttpServletRequest request, HttpServletResponse response) {
		String username = request.getParameter("username");
		boolean isExists = us.isExists(username);
		try {
			response.getWriter().write("{\"isExists\":"+isExists+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//注册判断邮箱是否重复
	private void doZhuceEmail(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		boolean isExistsEmail = us.isExistsEmail(email);
		try {
			response.getWriter().write("{\"isExistsEmail\":"+isExistsEmail+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//登录检查
	private void doCheckLogin(HttpServletRequest request, HttpServletResponse response) {
		String username  = request.getParameter("username");
		String password = request.getParameter("password");
		password=MD5Utils.md5(password);
		User user = us.doLogin(username,password);
		boolean u = false;
		if(user != null){
			 u = true;
		}
		//{"user":user}
		try {
			response.getWriter().write("{\"user\":"+u+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	
	//登录
	private void doLogin(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies=request.getCookies();
		for(Cookie cookie:cookies){
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		}
		String username  = request.getParameter("username");
		String password = request.getParameter("password");
		if(password!=null) {
			password=MD5Utils.md5(password);
		}
		
		String autoLogin = request.getParameter("autoLogin");
		User user = us.doLogin(username,password);
		if(user == null){
			try {
				response.sendRedirect(request.getContextPath()+"/jsp/login.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			if("remember-me".equals(autoLogin)){
				Cookie usn = new Cookie("username", username);
				Cookie psw = new Cookie("password", password);
				usn.setMaxAge(10000);
				psw.setMaxAge(10000); 
				usn.setPath("/");
				psw.setPath("/");
				response.addCookie(usn);
				response.addCookie(psw);
			}
			request.getSession().setAttribute("user", user);
			try {
				response.sendRedirect(request.getContextPath()+"/TextServlet");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	

}