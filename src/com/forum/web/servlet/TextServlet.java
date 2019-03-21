package com.forum.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.beans.User;
import com.forum.dao.CommentDao;
import com.forum.dao.impl.CommentDaoImpl;
import com.forum.service.TextService;
import com.forum.service.UserService;
import com.forum.service.impl.TextServiceImpl;
import com.forum.service.impl.UserServiceImpl;
import com.forum.utils.PageBean;

public class TextServlet extends HttpServlet {
	TextService ts =new TextServiceImpl();
	CommentDao cd=new CommentDaoImpl();
	UserService us = new UserServiceImpl();
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cp_str = request.getParameter("currentPage");
		int currentPage = 1;
		if (cp_str != null) {
			currentPage = Integer.parseInt(cp_str);
		}
		int pagesize=5;
		PageBean<Text> pb;
		String word=request.getParameter("word");
		if(word!=null){
			pb=ts.queryTextPageLikeTname(pagesize, currentPage, word);
//			System.out.println(pb);
		}else{
			String bid = request.getParameter("bid");
			if(bid!=null&&bid!=""){
				request.setAttribute("bid", bid);
				pb = ts.queryTextPageByBID(pagesize, currentPage, Integer.parseInt(bid));
			}else{
				pb=ts.queryTextPage(pagesize, currentPage);
			}
		}
		List<Text> li=pb.getList();
		List<Object[]> list = new ArrayList<Object[]>();
		for (int i = 0; i < li.size(); i++) {// 查询出发帖对应的user
			Long count = cd.count(li.get(i).gettId());
			User user = us.findUserByID(li.get(i).getUserid());
			Object[] o=new Object[3];
			if(count!=null){				
				o[0]=li.get(i);
				o[1]=count;
				o[2]=user;
			}else{
				o[0]=li.get(i);
				o[1]=0;
				o[2]=user;
			}
			list.add(o);
		}
		List<Text> hot =ts.findhotPoint();
		request.setAttribute("list", list);//0是帖子列表 1是回复数 2是发帖用户
		request.setAttribute("hot", hot);
		request.setAttribute("pageBean", pb);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}