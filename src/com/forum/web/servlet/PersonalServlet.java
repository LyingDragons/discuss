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
import com.forum.service.UserService;
import com.forum.service.impl.TextServiceImpl;
import com.forum.service.impl.UserServiceImpl;
import com.forum.utils.MD5Utils;
import com.google.gson.Gson;

public class PersonalServlet extends HttpServlet {

	private TextServiceImpl tsi = new TextServiceImpl();
	private UserServiceImpl usi = new UserServiceImpl();

	UserService us = new UserServiceImpl();
	TextServiceImpl ts = new TextServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String command = uri.substring(uri.lastIndexOf("/") + 1, uri.lastIndexOf("."));
		System.out.println(command);
		switch (command) {
		case "mytext":
			doMytext(request, response);
			break;
		case "modify":
			doModify(request, response);
			break;
		case "score":
			doScore(request, response);
			break;
		case "collection":
			doCollection(request, response);
			try {
				response.sendRedirect(request.getContextPath() + "/TextServlet");
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "ccollection":
			String isColl = doCollection(request, response);

			// {"isColl":isColl,"cos":cos}
			User user = (User) request.getSession().getAttribute("user");// 获取当前登陆用户
			String tid = request.getParameter("tid");// 获取点击帖子TID
			if (ts.findTextByID(Integer.parseInt(tid)).getUserid() == user.getUserId()) {
				int cos = user.getCollections().split(":").length - 1;
				response.getWriter().write("{\"isColl\":" + isColl + ",\"cos\":" + cos + "}");
			} else {

				response.getWriter().write("{\"isColl\":" + isColl + "}");

			}
			// response.getWriter().write("true");

			/*
			 * if(isColl){ response.getWriter().write("{\"isColl\":true}");
			 * }else{ response.getWriter().write("{\"isColl\":false}"); }
			 */
			// String tid = request.getParameter("tid");//获取点击帖子TID
			// Text text = ts.findTextByID(Integer.parseInt(tid));
			// text.setClicks(text.getClicks()-1);//不增加访问量
			// ts.modifyClicks(text);
			// try {
			// response.sendRedirect(request.getContextPath()
			// +"/show.text?tid="+request.getParameter("tid"));
			// } catch (IOException e) {
			// e.printStackTrace();
			// }

			break;

		case "headimg":
			headimg(request, response);
			break;

		case "text1":
			text1(request, response);
			break;

		case "pinglun":
			pinglun(request, response);
			break;

		case "mycollection":
			mycollection(request, response);
			break;

		// 进入个人中心获得我的帖子
		case "getmytext":
			getmytext(request, response);
			break;
		}

	}

	private String doCollection(HttpServletRequest request, HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("user");// 获取当前登陆用户
		String tid = request.getParameter("tid");// 获取点击帖子TID
		String currentPage = request.getParameter("currentPage");// 获取当前页数
		String oldCollctions = user.getCollections();// 获取原有收藏夹
		String newCollctions;// 创建新收藏夹
		if (oldCollctions != null) {// 如果原有收藏夹不为空
			String[] collctions = oldCollctions.split(":");// 分割原有收藏夹
			for (String co : collctions) {// 循环
				if (tid.equals(co)) {// 如果有重复收藏
					oldCollctions = oldCollctions.replaceAll(":" + tid, "");// 取消收藏
					user.setCollections(oldCollctions);
					us.modify(user);
					return "false"; // 退出方法
				}
			}
			newCollctions = oldCollctions.concat(":" + tid);// 把tid加入新收藏夹
		} else {
			newCollctions = ":" + tid;// 如果原收藏夹为空则新建收藏夹
		}
		// 把新收藏夹存入数据库替换原收藏夹
		user.setCollections(newCollctions);
		us.modify(user);
		return "true";
	}

	public void doMytext(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().getAttribute("user");

		User user = (User) request.getSession().getAttribute("user");
		String nickname = user.getNickname();
		List<Text> list = tsi.findTextByNickname(nickname);
		request.setAttribute("mylist", list);
		request.getRequestDispatcher("jsp/personCenter/mytext.jsp").forward(request, response);
	}

	public void doModify(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nickname = request.getParameter("nickname");
		//String password = request.getParameter("password");
		//password=MD5Utils.md5(password);
		String phone = request.getParameter("phone");
		String age=request.getParameter("age");
		String sex = request.getParameter("sex");
		// 从session获得用户
		User user = (User) request.getSession().getAttribute("user");
		user.setNickname(nickname);
		//user.setPassword(password);
		user.setAge(Integer.parseInt(age));
		user.setPhone(phone);
		user.setSex(sex);
		// 调用数据库
		UserServiceImpl us = new UserServiceImpl();
		us.modify(user);
		request.getRequestDispatcher("getmytext.personal").forward(request, response);
		// response.sendRedirect("");
	}

	public void doScore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("score", user.getScore());

		request.getRequestDispatcher("jsp/personCenter/score.jsp").forward(request, response);
	}

	public void headimg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserServiceImpl usi = new UserServiceImpl();
		User user = (User) request.getSession().getAttribute("user");
		System.out.println(user.getUserId());
		String imgTouPath = usi.imgTouPath(user.getUserId());
		if (imgTouPath == null) {
			System.out.println("没有头像");
			request.getRequestDispatcher("text1.personal").forward(request, response);
			return;
		} else {
			System.out.println(imgTouPath);
			request.setAttribute("xiangduiimg", imgTouPath);
			request.getRequestDispatcher("jsp/personCenter/personal.jsp").forward(request, response);
		}
	}

	public void text1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		String parameter = request.getParameter("mytext");

		List<Text> list = tsi.findTextByUserid(user.getUserId());

		// request.getRequestDispatcher("jsp/personCenter/personal.jsp").forward(request,
		// response);
		// request.getRequestDispatcher("updataText1.personal").forward(request,
		// response);
		// request.getRequestDispatcher("jsp/personCenter/mytext1.jsp").forward(request,
		// response);
		Gson gson = new Gson();
		String json = gson.toJson(list);
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().write(json);
	}

	public void pinglun(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		String parameter = request.getParameter("mytext");

		List<Comment> list = usi.findcommentByUserId(user.getUserId());

		request.setAttribute("pinglunlist", list);
		request.getRequestDispatcher("jsp/personCenter/personal.jsp").forward(request, response);

	}

	public void mycollection(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		String parameter = request.getParameter("mytext");
		List<Text> list = usi.findfmycollection(user.getUserId());

		// Gson gson = new Gson();
		// String json = gson.toJson(mycollection);
		// System.out.println(json);
		// response.setContentType("text/plain;charset=utf-8");
		// response.getWriter().write(json);
		request.setAttribute("collectionlist", list);
		request.getRequestDispatcher("jsp/personCenter/personal.jsp").forward(request, response);
	}

	public void getmytext(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = (User) request.getSession().getAttribute("user");

		List<Text> textlist = tsi.findTextByUserid(user.getUserId());

		request.setAttribute("textlist", textlist);

		List<Comment> commentlist = usi.findcommentByUserId(user.getUserId());
		List<Object> lo = new ArrayList<Object>();
		if (commentlist != null) {
			for (Comment co : commentlist) {
				Object[] o = new Object[2];
				String tname = tsi.findTextByID(co.getTid()).getTname();
				o[0] = co;
				o[1] = tname;
				lo.add(o);
			}
		}
		request.setAttribute("pinglunlist", lo);

		List<Text> list = usi.findfmycollection(user.getUserId());

		request.setAttribute("collectionlist", list);

		request.getRequestDispatcher("jsp/personCenter/personal.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}