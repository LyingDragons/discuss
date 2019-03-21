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

import com.forum.beans.Message;
import com.forum.beans.Text;
import com.forum.beans.User;
import com.forum.service.MessageService;
import com.forum.service.TextService;
import com.forum.service.impl.MessageServiceImpl;
import com.forum.service.impl.TextServiceImpl;

public class MessageServlet extends HttpServlet {
	TextService ts = new TextServiceImpl();
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String uri = request.getRequestURI();//接收以.message结尾的uri
		uri = uri.substring(uri.lastIndexOf("/") + 1, uri.lastIndexOf("."));
		switch (uri) {
		case "recive"://接受
			doRecive(request, response);
			break;
		case "show"://显示
			doShow(request, response);
			break;
		case "read"://已读
			doRead(request, response);
			break;
		case "checkAll"://所有消息已读
			doCheckAll(request, response);
			break;
		}
	}

	private void doRead(HttpServletRequest request, HttpServletResponse response) {
		String tid = request.getParameter("tid");
		int mid = Integer.parseInt(request.getParameter("mid"));
		MessageService ms=new MessageServiceImpl();
		ms.setStatu(mid);
		try {
			response.sendRedirect(request.getContextPath() + "/show.text?tid=" + tid);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	static void doCheckAll(HttpServletRequest request, HttpServletResponse response) {//所有未读变已读
		User user=(User)request.getSession().getAttribute("user");
		MessageService ms=new MessageServiceImpl();
		ms.setAll(user.getUserId());	
	}

	private void doCheck(HttpServletRequest request, HttpServletResponse response,int mid) {//点击未读变已读
		MessageService ms=new MessageServiceImpl();
		ms.setStatu(mid);
	}

	private void doShow(HttpServletRequest request, HttpServletResponse response) {
		User user=(User)request.getSession().getAttribute("user");
		MessageService ms=new MessageServiceImpl();
		List<Message> list=ms.queryNewMessage(user.getUserId());
		List<Object> li=new ArrayList<Object>();
		for(int i=0;i<list.size();i++){
			Text text = ts.findTextByID(list.get(i).getTid());
			list.get(i).setDate(list.get(i).getDate().substring(0, 19));
			Object[] o =new Object[2];
			o[0]=list.get(i);
			o[1]=text;
			li.add(o);
		}
		request.setAttribute("list", li);
		try {
			request.getRequestDispatcher("jsp/message.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

	static void doSend(HttpServletRequest request, HttpServletResponse response){
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String da = format1.format(date);
		TextService ts=new TextServiceImpl();
		MessageService ms=new MessageServiceImpl();
		int tid = Integer.parseInt(request.getParameter("tid"));
		Text text = ts.findTextByID(tid);
		ms.sendMessage(text.getUserid(),da,text.getTname(),tid);
		
	}

	private void doRecive(HttpServletRequest request, HttpServletResponse response) {
		User user=(User)request.getSession().getAttribute("user");
		if(user!=null){
		MessageService ms=new MessageServiceImpl();
		boolean isNew=ms.isNewMessage(user.getUserId());
		try {
			response.getWriter().write("{\"isNew\":"+isNew+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}