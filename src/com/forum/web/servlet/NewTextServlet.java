package com.forum.web.servlet;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

public class NewTextServlet extends HttpServlet {
	TextService ts = new TextServiceImpl();
	UserService us = new UserServiceImpl();
	CommentDao cd = new CommentDaoImpl();
	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String uri = request.getRequestURI();//接收以.text结尾的uri
		uri = uri.substring(uri.lastIndexOf("/") + 1, uri.lastIndexOf("."));
		switch (uri) {
		case "new"://新建帖子
			doNew(request, response);
			break;
		case "show"://显示帖子
			doShow(request, response);
			break;
		case "replay"://新增回复
			doReplay(request, response);
			break;
		case "edit"://编辑帖子
			doEdit(request, response);
			break;
		case "showEdit"://显示编辑帖子网页中该有的内容
			doShowEdit(request, response);
			break;
		case "delete"://删除帖子
			doDel(request, response);
			break;
		case "test":
			doTest(request, response);
			break;
		}

	}

	private void doDel(HttpServletRequest request, HttpServletResponse response) {
		int tid=Integer.parseInt(request.getParameter("tid"));
		ts.deleteTextByTextID(tid);
		cd.deleteConmentByTid(tid);
		try {
			response.sendRedirect("TextServlet");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void doShowEdit(HttpServletRequest request, HttpServletResponse response) {
		String tid = request.getParameter("tid");
		Text text=ts.findTextByID(Integer.parseInt(tid));
		request.setAttribute("text", text);
		try {
			request.getRequestDispatcher("EditText.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	private void doEdit(HttpServletRequest request, HttpServletResponse response) {
		String tname = request.getParameter("tname");// 读取贴名
		String context = request.getParameter("content");// 读取帖子内容
		String tid=request.getParameter("tid");
//		context = ts.br(context);
		Date date = new Date(); // 发帖时间
//		String da = "<div class=\"huifu\">编辑于:"+format1.format(date)+"</div>";
//		context=da.concat(context);
		Text text = ts.findTextByID(Integer.parseInt(tid));
		text.setTname(tname);
		text.setContext(context);
		ts.modifyTextByTextID(text);
		try {
			response.sendRedirect(request.getContextPath() + "/show.text?tid=" + tid);// 显示该帖子页面
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void doShow(HttpServletRequest request, HttpServletResponse response) {
		String tid = request.getParameter("tid");// 获取所点击的帖子名
		// String context=request.getParameter("context");//获取点击帖子的内容
		Text text = ts.findTextByID(Integer.parseInt(tid));// 查找对应帖子
	
		// 1.接受客户端参数
		String cp_str = request.getParameter("currentPage");
		int currentPage = 1;
		if (cp_str != null) {//不增加访问量
			currentPage = Integer.parseInt(cp_str);
		}else{
			text.setClicks(text.getClicks()+1);
			ts.modifyClicks(text);
		}
		// 2.封装为javaBean
		// 3.调用service层获得结果
		PageBean<Comment> pb = cd.queryCommentPage(10, currentPage, Integer.parseInt(tid));
		List<Comment> comments =pb.getList();
		User textuser = us.findUserByID(text.getUserid());
		List<Object[]> replies = new ArrayList<Object[]>();
		for (int i = 0; i < comments.size(); i++) {// 查询出回复对应的user
			User user = us.findUserByID(comments.get(i).getUserid());
			Object[] o = { comments.get(i), user };
			replies.add(o);
		}
		User author = us.findUserByID(text.getUserid());
		int tNum = ts.findTextByUID(text.getUserid()).size();//作者发帖数
		int cNum=0;
		if(author.getCollections()!=null){
			String[] collections=author.getCollections().split(":");
			cNum=collections.length-1;
		}
		List<Object> authorInfo = new ArrayList<Object>();
		authorInfo.add(author);
		authorInfo.add(tNum);
		authorInfo.add(cNum);

		// 4.指派jsp显示 -> 携带list数据
		// 存域对象
		request.setAttribute("authorInfo", authorInfo);
		request.setAttribute("replies", replies);
		request.setAttribute("text", text);
		request.setAttribute("textuser", textuser);
		request.setAttribute("pageBean", pb);
		try {
			request.getRequestDispatcher("jsp/text/text.jsp?tid="+tid).forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void doNew(HttpServletRequest request, HttpServletResponse response) {
		User u=(User)request.getSession().getAttribute("user");
		if(u==null){}
		String bname = request.getParameter("bname");// 获取板块代号
		int bid = 1;
		switch (bname) {// 获取板块ID并设置板块名字
		case "study":
			bid = 1;
			bname="学习";
			break;
		case "love":
			bid = 2;
			bname="情感";
			break;
		case "play":
			bid = 3;
			bname="娱乐";
			break;
		}
		String tname = request.getParameter("tname");// 读取贴名
		String context = request.getParameter("content");// 读取帖子内容
		String xiangduiimg=request.getParameter("xiangduiimg"); //获取图片地址
		
//		context = ts.br(context);
		Date date = new Date(); // 发帖时间
		String da = format1.format(date);
		Text text = new Text();
		text.setTname(tname);
		text.setContext(context);
		text.setDate(da);
		text.setUserid(((User) request.getSession().getAttribute("user")).getUserId());
		text.setClicks(0);
		text.setbId(bid);
		text.setBname(bname);
		text.setImg(xiangduiimg);
		ts.addText(text); // 存入数据库
		int gettId = ts.findTextByTname(tname).gettId();// 获取自动增长的tid
		try {
			response.sendRedirect(request.getContextPath() + "/show.text?tid=" + gettId);// 显示该帖子页面
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void doReplay(HttpServletRequest request, HttpServletResponse response) {
		Integer tid = Integer.parseInt(request.getParameter("tid"));// 获取当前帖子ID
		String context=request.getParameter("context");
		String huifu = request.getParameter("writehuifu");
		if(huifu!=null){
			int h=huifu.indexOf("回");
			String uid=huifu.substring(0, h);//得到uid
			huifu=huifu.substring(h);//回复内容
		String reply="<div class=\"huifu\">"+huifu+"</div>";//获取回复对象信息
		context=reply.concat(context);//获取回复内容
		}
		context = ts.br(context);
		Comment comment = new Comment();
		Date date = new Date(); // 回帖时间
		String da = format1.format(date);
		List<Comment> comments = cd.findConmentByTextId(tid);// 查找该贴的回复
		Text text = ts.findTextByID(tid);
		text.setLastdate(da);
		ts.modifyTextByTextID(text);
		comment.setContext(context);
		comment.setDate(da);
		comment.setFloor(comments.size() + 1);
		comment.setTid(tid);
		comment.setUserid(((User) request.getSession().getAttribute("user")).getUserId());
		cd.addConment(comment); // 存入数据库
		MessageServlet.doSend(request, response);
		try {
			response.sendRedirect(request.getContextPath() + "/show.text?tid=" + tid);// 显示该帖子页面
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	private void doTest(HttpServletRequest request, HttpServletResponse response) {
		User u=(User)request.getSession().getAttribute("user");
		if(u==null){}
		String bname = request.getParameter("bname");// 获取板块代号
		int bid = 1;
		switch (bname) {// 获取板块ID并设置板块名字
		case "study":
			bid = 1;
			bname="学习";
			break;
		case "love":
			bid = 2;
			bname="情感";
			break;
		case "play":
			bid = 3;
			bname="娱乐";
			break;
		}
		String tname = request.getParameter("tname");// 读取贴名
		String context = request.getParameter("content");// 读取帖子内容
		String xiangduiimg=request.getParameter("xiangduiimg"); //获取图片地址
		
//		context = ts.br(context);
		Date date = new Date(); // 发帖时间
		String da = format1.format(date);
		Text text = new Text();
		text.setTname(tname);
		text.setContext(context);
		text.setDate(da);
		text.setUserid(((User) request.getSession().getAttribute("user")).getUserId());
		text.setClicks(0);
		text.setbId(bid);
		text.setBname(bname);
		text.setImg(xiangduiimg);
		System.out.println("tname:"+tname);
		System.out.println("context:"+context);
		System.out.println("xiangduiimg"+xiangduiimg);
		
		
		
//		ts.addText(text); // 存入数据库
//		int gettId = ts.findTextByTname(tname).gettId();// 获取自动增长的tid
//		try {
//			response.sendRedirect(request.getContextPath() + "/show.text?tid=" + gettId);// 显示该帖子页面
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
	}
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}