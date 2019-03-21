package com.forum.service.impl;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;

import com.forum.beans.Message;
import com.forum.dao.MessageDao;
import com.forum.dao.impl.MessageDaoImpl;
import com.forum.service.MessageService;
import com.forum.utils.C3P0Utils;

public class MessageServiceImpl implements MessageService {
	MessageDao md=new MessageDaoImpl();
	@Override
	public boolean isNewMessage(int userId) {
		List<Message> lm= md.queryNewMessageByUID(userId);
		if(lm.size()==0){
			return false;
		}
		return true;
	}

	@Override
	public void sendMessage(int userid, String da,String tname,int tid) {
		md.addMessage(userid,da,tname,tid);
	}

	@Override
	public void deleteMessage(String c) {
		md.deleteMessage(c);
		
	}

	@Override
	public List<Message> queryNewMessage(int userId) {
		return md.queryNewMessageByUID(userId);
	}

	@Override
	public void setAll(int userId) {
		md.setAll(userId);	
	}

	@Override
	public void setStatu(int mid) {
		md.setStatu(mid);
	}

}
