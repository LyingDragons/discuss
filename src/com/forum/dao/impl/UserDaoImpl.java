package com.forum.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.forum.beans.Comment;
import com.forum.beans.User;
import com.forum.dao.UserDao;
import com.forum.utils.C3P0Utils;
/*
 * 实现类的注释全写在dao层了
 */
public class UserDaoImpl implements UserDao {
	private QueryRunner qu=new QueryRunner(C3P0Utils.getDataSource());
	@Override
	public User findUserByUsername_Password(String username, String password) {
		String sql="select * from user where username=? and password=?";
		try {
			User user = qu.query(sql, new BeanHandler<User>(User.class), username,password);
			
			return user;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public User findUserByUsername(String username) {
		String sql="select * from user where username=?";
		try {
			User user = qu.query(sql, new BeanHandler<User>(User.class), username);
			return user;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public User findUserByEmail(String email) {
		String sql="select * from user where email=?";
		try {
			User user = qu.query(sql, new BeanHandler<User>(User.class), email);
			return user;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public User findUserBynickname(String nickname) {
		String sql="select * from user where nickname=?";
		try {
			User user = qu.query(sql, new BeanHandler<User>(User.class));
			return user;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void addUser(User user) {
		String sql="insert into user values(null,?,?,?,?,?,?,?,?,?,0,?,?,?)";
		try {
			qu.update(sql, user.getUsername(),user.getPassword(),user.getNickname()
					,user.getEmail(),user.getAge(),user.getSex(),user.getPhone()
					,user.getArea(),user.getScore(),user.getCollections(),user.getImg(),user.getSingle());
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void modify(User user) {
		String sql="update user set password=?,nickname=?,email=?"
				+ ",age=?,sex=?,phone=?,area=?,collections=?,img=?,single=? where username=?";
		try {
			qu.update(sql, user.getPassword(),user.getNickname(),user.getEmail()
					,user.getAge(),user.getSex(),user.getPhone(),user.getArea(),user.getCollections(),user.getImg(),user.getSingle()
					,user.getUsername());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public User findUserByID(int uid) {
		String sql="select * from user where userid=?";
		try {
			return qu.query(sql,new BeanHandler<User>(User.class),uid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void addimg(int id,String imgaddress) {
		String sql="UPDATE user SET img=?  WHERE userid=?";
		System.out.println("dao层图片路径"+imgaddress);
		try {
			qu.update(sql, imgaddress,id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public String imgTouPath(int id) {
		String sql="select img from user where userid=?";
		try {
			String path =(String) qu.query(sql, new ScalarHandler(),id);
			return path;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Comment> findcommentByUserId(int userid) {
		String sql="select * from conment where userid=?";
		try {
			List<Comment> list = qu.query(sql, new BeanListHandler<Comment>(Comment.class), userid);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void setPSW(String password,String username) {
		String sql="update user set password=? where username=?";
		try {
			qu.update(sql,password,username);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
