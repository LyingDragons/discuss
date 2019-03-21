package com.forum.dao;

import java.util.List;

import com.forum.beans.Message;

public interface MessageDao {

	List<Message> queryNewMessageByUID(int userId);

	void addMessage(int userid, String da,String tname,int tid);

	void deleteMessage(String c);

	void setAll(int userId);

	void setStatu(int mid);



}
