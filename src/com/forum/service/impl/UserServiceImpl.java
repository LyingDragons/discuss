package com.forum.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.apache.commons.beanutils.BeanUtils;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.beans.User;
import com.forum.dao.UserDao;
import com.forum.dao.impl.UserDaoImpl;
import com.forum.service.TextService;
import com.forum.service.UserService;
import com.forum.utils.MailUtils;

public class UserServiceImpl implements UserService {
	private UserDao ud = new UserDaoImpl();
	private TextService ts = new TextServiceImpl();

	@Override
	public void addUser(User user) {
		ud.addUser(user);

	}

	@Override
	public void modify(User user) {
		ud.modify(user);

	}

	@Override
	public User findUserByUsername_Password(String username, String password) {
		User user = ud.findUserByUsername_Password(username, password);
		System.out.println("service里" + user);
		return user;
	}

	@Override
	public User findUserByUsername(String username) {
		User user = ud.findUserByUsername(username);
		return user;
	}

	@Override
	public User findUserBynickname(String nickname) {
		User user = ud.findUserBynickname(nickname);
		return user;
	}

	@Override
	public User doLogin(String username, String password) {

		return ud.findUserByUsername_Password(username, password);
	}

	@Override
	public void add(String username,String password,String email,String nickname,String sex) {
		User user = new User();
		System.out.println("service"+username);
		try {
			Map<String,String> parameterMap = new HashMap<String,String>();
			parameterMap.put("username", username);
			parameterMap.put("password", password);
			parameterMap.put("email", email);
			parameterMap.put("nickname", nickname);
			parameterMap.put("sex", sex);
			BeanUtils.populate(user, parameterMap);
			System.out.println("service"+user);
			UserDao ud = new UserDaoImpl();
			ud.addUser(user);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

	@Override
	public User findUserByID(int uid) {
		return ud.findUserByID(uid);
	}

	@Override
	public boolean isExists(String username) {
		UserDao ud = new UserDaoImpl();
		User user = ud.findUserByUsername(username);
		return user != null;
	}

	public boolean isExistsEmail(String email) {
		UserDao ud = new UserDaoImpl();
		User user = ud.findUserByEmail(email);
		return user != null;
	}

	@Override
	public void sendEmail(String email, int i) {

		String emailMsg = "欢迎注册绿帽论坛！您的验证码是:" + i;
		try {
			MailUtils.sendMail(email, emailMsg, "验证码");
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void sendEmailToFind(String email, int i) {
		String emailMsg = "您找回密码的验证码是:" + i;
		try {
			MailUtils.sendMail(email, emailMsg, "验证码");
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}
	

	public void addimg(int id, String xiangduiimg) {
		ud.addimg(id, xiangduiimg);

	}

	@Override
	public String imgTouPath(int id) {
		return ud.imgTouPath(id);

	}

	@Override
	public List<Comment> findcommentByUserId(int id) {
		return ud.findcommentByUserId(id);

	}

	@Override
	public List<Text> findfmycollection(int userid) {
		List<Text> list = new ArrayList<Text>();
		User user = ud.findUserByID(userid);
		String collections = user.getCollections();
		if (collections != null) {
			String[] cc = collections.split(":");
			for (int i = 1; i < cc.length; i++) {
				Text text = ts.findTextByID(Integer.parseInt(cc[i]));
				list.add(text);
			}
		}
		return list;
	}

	@Override
	public void setPSW(String password,String username) {
		ud.setPSW(password,username);
	}

}
