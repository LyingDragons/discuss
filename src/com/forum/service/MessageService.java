package com.forum.service;

import java.util.List;

import com.forum.beans.Message;

public interface MessageService {

	boolean isNewMessage(int userId);

	void sendMessage(int userid, String da,String tname,int tid);

	void deleteMessage(String c);

	List<Message> queryNewMessage(int userId);

	void setAll(int userId);

	void setStatu(int mid);

}
