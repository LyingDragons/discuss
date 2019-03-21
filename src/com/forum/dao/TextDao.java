package com.forum.dao;

import java.util.List;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.utils.PageBean;

public interface TextDao {

	//增加帖子
	void addText(Text text);
	
	//删除帖子
	void deleteTextByTextID(int tid);
	
	//修改帖子
	void modifyTextByTextID(Text text);
	
	//根据帖子名字找
	Text findTextByTname(String word);
	
	//根据帖子名中类似关键字 找
	List<Text> findLikeTextByname(String word);
	
	//根据帖子最高点击量找
	List<Text> findTextByClicks();
	
	//根据指定昵称找帖子
	List<Text> findTextByNickname(String nickname);
	
	//查询全部帖子，分页查询
	List<Text> findAllText(int currentPage, int pageSize);

	//查询点击量前三的热搜
	List<Text> findHotPoint();

	Text findTextBytid(int tid);

	List<Text> findTextByBid(int bid);

	void modifyClicks(Text text);

	Long findCount();
	
	Long findCount(int bid);

	List<Text> queryTextPage(Integer currentPage, Integer pageSize);

	List<Text> queryTextPageByBID(int pageSize, int currentPage, int bid);

	List<Text> queryTextByUID(int uid);

	List<Text> queryTextPageLikeTname(int pagesize, int currentPage, String word);

	
	//根据用户id找
	List<Text> findTextByUserid(int userid);
	
	
}
