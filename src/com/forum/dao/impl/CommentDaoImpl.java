package com.forum.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.forum.beans.Comment;
import com.forum.dao.CommentDao;
import com.forum.utils.C3P0Utils;
import com.forum.utils.PageBean;
/**
 * 
 * @author Administrator
 *				实现类的注释全写在dao层了
 */

public class CommentDaoImpl implements CommentDao {
	private static DataSource ds;
	private static QueryRunner qu;
	
	static{
		ds=C3P0Utils.getDataSource();
		qu=new QueryRunner(ds);
	}
	@Override
	public void addConment(Comment c) {
		String sql="insert into conment values(null,?,?,?,?,?)";
		try {
			qu.update(sql,c.getTid(),c.getUserid(),c.getContext(),c.getDate(),c.getFloor());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteConment(Comment c) {
		String sql="delete from conment where cid=?";
		try {
			qu.update(sql,c.getcId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Comment> findConmentByTextId(int tid) {
		String sql="select * from conment where tid=?";
		try {
			List<Comment> list = qu.query(sql,new BeanListHandler<Comment>(Comment.class),tid);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public PageBean<Comment> queryCommentPage(int pageSize, int currentPage,int tid) {
		PageBean<Comment> pb = new PageBean<Comment>(pageSize, currentPage);
		// 调用dao 获得list 和totalCount
		String sql = "select * from conment where tid=? limit ?,?";
		String sqlCount = "select count(*) from conment where tid=?";
		List<Comment> list;
		try {
			list = qu.query(sql, new BeanListHandler<Comment>(Comment.class),tid,(currentPage-1)*pageSize, pageSize);
			long totalCount = (Long) qu.query(sqlCount, new ScalarHandler(),tid);
			pb.setList(list);
			pb.setTotalCount(totalCount);
			int totalPage = (int)((totalCount+pb.getPageSize()-1)/pb.getPageSize());
			pb.setTotalPage(totalPage);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pb;
	}

	@Override
	public Long count(int tId) {
		String sql="select count(*) from conment where tid=?";
		try {
			return (Long) qu.query(sql, new ScalarHandler(),tId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void deleteConmentByTid(int tid) {
		String sql="delete from conment where tid=?";
		try {
			qu.update(sql,tid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	

}
