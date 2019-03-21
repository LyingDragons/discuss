package com.forum.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.forum.beans.User;
import com.forum.service.UserService;
import com.forum.service.impl.UserServiceImpl;


public class LoginFilter implements Filter{
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		String username = null;
		String password = null;
		Cookie[] cookies = req.getCookies();
		if(cookies != null){
			for(Cookie cookie:cookies){
				if(cookie.getName().equals("username")){
					username = cookie.getValue();
				}
				if(cookie.getName().equals("password"))
				{
					password = cookie.getValue();
				}
			}
		}
		UserService us = new UserServiceImpl();
		if(username != null && password != null){
			User user = us.doLogin(username, password);
			req.getSession().setAttribute("user", user);
		}
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
	public void destroy() {
		
	}
}
