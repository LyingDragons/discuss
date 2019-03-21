package com.forum.service;

import java.util.List;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.utils.PageBean;

public interface TextService {

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
		
		//查询板块帖子
		List<Text> findTextByBID(int bid);
		
		//查询点击量前三的热搜
		List<Text> findhotPoint();
		
		//根据帖子ID找帖子
		Text findTextByID(int tid);
		
		//判断换行
		String br(String context);

		void modifyClicks(Text text);

		PageBean<Text> queryTextPage(int pageSize, int currentPage);

		PageBean<Text> queryTextPageByBID(int pageSize, int currentPage, int parseInt);

		List<Text> findTextByUID(int userid);

		PageBean<Text> queryTextPageLikeTname(int pagesize, int currentPage, String word);
	
		//根据用户id找
		List<Text> findTextByUserid(int userid);
}
