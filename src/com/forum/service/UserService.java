package com.forum.service;

import java.util.List;
import java.util.Map;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.beans.User;


public interface UserService {


	//增加用户
	void addUser(User user);
	
	
	//修改信息
	void modify(User user);

	//根据用户名密码找
	User findUserByUsername_Password(String username,String password);
	
	//根据用户名找
	User findUserByUsername(String username);
	
	//根据昵称找
	User findUserBynickname(String nickname);

	//登录验证
	User doLogin(String username, String password);

	User findUserByID(int uid);
	
	//注册添加用户
	void add(String username,String password,String email,String nickname,String sex);

	//判断用户是否存在
	boolean isExists(String username);

	//发送验证邮件
	void sendEmail(String email,int i );
	
	//查找头像图片路径
	String imgTouPath(int id);

	

	//根据用户id找评论
	List<Comment> findcommentByUserId(int id);
	
	//查找我收藏的帖子
	List<Text>  findfmycollection(int userid);


	//判断邮箱是否重复
	boolean isExistsEmail(String email);

	//设置密码
	void setPSW(String password, String username);


	void sendEmailToFind(String email, int i);

}
