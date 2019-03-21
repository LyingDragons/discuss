package com.forum.dao.impl;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.dao.TextDao;
import com.forum.utils.C3P0Utils;
import com.forum.utils.PageBean;
/*
 * 实现类的注释全写在dao层了
 */
public class TextDaoImpl implements TextDao {
	private static DataSource ds;
	private static QueryRunner qu;
	
	static{
		ds=C3P0Utils.getDataSource();
		qu=new QueryRunner(ds);
	}
	
	@Override
	public void addText(Text text) {
		String sql="insert into text values(null,?,?,?,?,?,?,?,?,?)";
		try {
			qu.update(sql, text.getTname(),text.getUserid(),text.getContext(),text.getImg(),
					text.getbId(),text.getBname()
					,text.getDate(),text.getClicks(),text.getDate());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteTextByTextID(int tid) {
		String sql="delete from text where tid=?";
		try {
			qu.update(sql,tid);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void modifyTextByTextID(Text text) {
		String sql="update text set tname=?,userid=?,context=?,bid=?,bname=?"
				+ ",date=now(),clicks=?,lastdate=? where tid=?";
		try {
			qu.update(sql, text.getTname(),text.getUserid(),text.getContext(),
					text.getbId(),text.getBname(),text.getClicks(),text.getLastdate(),text.gettId());
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public Text findTextByTname(String word) {
		String sql="select * from text where tname=?";
		try {
			Text text = qu.query(sql, new BeanHandler<Text>(Text.class),word);
			return text;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> findLikeTextByname(String word) {
		String sql="select * from text where tname like ? ORDER BY lastdate desc";
		try {
			List<Text> list = qu.query(sql, new BeanListHandler<Text>(Text.class),"%"+word+"%");
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	//默认获得前50条热搜
	public List<Text> findTextByClicks() {
		String sql="SELECT * FROM text ORDER BY clicks DESC LIMIT ?,?;";
		try {
			qu.query(sql, new BeanListHandler<Text>(Text.class),0,50 );
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> findTextByNickname(String nickname) {
		String sql="SELECT * FROM text WHERE userid=(select userid from user where nickname=? ORDER BY lastdate desc)";
		try {
			List<Text> list = qu.query(sql,new BeanListHandler<Text>(Text.class), nickname);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> findAllText(int currentPage, int pageSize) {
		String sql="select * from text ORDER BY lastdate desc";
		try {
			List<Text> list = qu.query(sql, new BeanListHandler<Text>(Text.class));
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> findHotPoint() {
		String sql ="select * from (select * from text order by clicks desc) as hot limit 0,3";
		try {
			List<Text> list =qu.query(sql, new BeanListHandler<Text>(Text.class));
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Text findTextBytid(int tid) {
		String sql="SELECT * FROM text WHERE tid=?";
		try {
			return qu.query(sql,new BeanHandler<Text>(Text.class), tid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> findTextByBid(int bid) {
		String sql="select * from text where bid=? ORDER BY lastdate desc";
		try {
			List<Text> list = qu.query(sql, new BeanListHandler<Text>(Text.class),bid);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void modifyClicks(Text text) {
		String sql="update text set clicks=? where tid=?";
		try {
			qu.update(sql,text.getClicks(),text.gettId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Long findCount() {
		String sql="select count(*) from text";
		try {
			return (Long) qu.query(sql, new ScalarHandler());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public Long findCount(int bid) {
		String sql="select count(*) from text where bid=?";
		try {
			return (Long) qu.query(sql, new ScalarHandler(),bid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> queryTextPage(Integer currentPage, Integer pageSize) {
		String sql = "select * from text ORDER BY lastdate desc limit ?,? ";
		try {
			return qu.query(sql, new BeanListHandler<Text>(Text.class),(currentPage-1)*pageSize, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> queryTextPageByBID(int pageSize, int currentPage, int bid) {
		String sql = "select * from text where bid=? ORDER BY lastdate desc limit ?,? ";
		try {
			return qu.query(sql, new BeanListHandler<Text>(Text.class),bid,(currentPage-1)*pageSize, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Text> queryTextByUID(int uid) {
		String sql = "select * from text where userid=?";
		try {
			return qu.query(sql, new BeanListHandler<Text>(Text.class),uid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}


	@Override
	public List<Text> findTextByUserid(int userid) {
		String sql="select * from text where userid=?";
		try {
			List<Text> list = qu.query(sql,new BeanListHandler<Text>(Text.class), userid);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}


	@Override
	public List<Text> queryTextPageLikeTname(int pageSize, int currentPage, String word) {
		String sql="select * from text where tname like ? ORDER BY lastdate desc limit ?,?";
		try {
			return qu.query(sql, new BeanListHandler<Text>(Text.class),"%"+word+"%",(currentPage-1)*pageSize, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	


}
