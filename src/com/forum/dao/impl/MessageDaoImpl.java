package com.forum.dao.impl;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.forum.beans.Message;
import com.forum.dao.MessageDao;
import com.forum.utils.C3P0Utils;

public class MessageDaoImpl implements MessageDao {
	private static DataSource ds;
	private static QueryRunner qu;
	
	static{
		ds=C3P0Utils.getDataSource();
		qu=new QueryRunner(ds);
	}
	
	@Override
	public List<Message> queryNewMessageByUID(int userId) {
		String sql="select * from message where reciverid=? and statu=0";
		try {
			return qu.query(sql, new BeanListHandler<Message>(Message.class),userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void addMessage(int userid, String da,String tname,int tid) {
		String sql="insert into message values(null,?,?,?,?,?,?)";
		try {
			qu.update(sql,"管理员",userid,"您的贴子《"+tname+"》收到一条新回复！",da,0,tid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteMessage(String date) {
		String sql="delete from message where statu=1 and date<?";
		try {
			qu.update(sql,date);
		} catch (SQLException e) {
		}
		
	}

	@Override
	public void setAll(int userId) {
		String sql="update message set statu =1 where reciverid=?";
		try {
			qu.update(sql,userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setStatu(int mid) {
		String sql="update message set statu =1 where mid=?";
		try {
			qu.update(sql,mid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}


}
