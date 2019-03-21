package com.forum.dao;

import java.util.List;

import com.forum.beans.Comment;
import com.forum.beans.User;

public interface UserDao {
	
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

	//根据ID找
	User findUserByID(int uid);
	
	//给用户添加图片地址
	void addimg(int id,String imgaddress);
	
	//找头像路径
	String imgTouPath(int id);

	
	//根据用户id找评论
	List<Comment> findcommentByUserId(int id);
	
	


	//查找邮箱
	User findUserByEmail(String email);


	void setPSW(String password, String username);

}
