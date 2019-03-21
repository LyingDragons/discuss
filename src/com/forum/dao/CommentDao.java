package com.forum.dao;

import java.util.List;

import com.forum.beans.Comment;
import com.forum.utils.PageBean;

public interface CommentDao {

	//增加评论
	void addConment(Comment c);
	
	//删除评论
	void deleteConment(Comment c);
	
	//根据帖子id找评论
	List<Comment> findConmentByTextId(int id);
	
	//根据点赞数找评论
	//List<Conment> findConmentByDianzan();

	PageBean<Comment> queryCommentPage(int pageSize, int currentPage, int tid);

	Long count(int tId);

	void deleteConmentByTid(int tid);
}
