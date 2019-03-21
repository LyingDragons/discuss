package com.forum.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.forum.beans.Text;
import com.forum.service.impl.TextServiceImpl;
import com.google.gson.Gson;

public class SearchWord extends HttpServlet {
private TextServiceImpl ts=new TextServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String word = request.getParameter("word");
		List<Text> list = ts.findLikeTextByname(word);
		//gson的参数必须用实体类
		Gson gson=new Gson();
		String json=gson.toJson(list);
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(json);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}