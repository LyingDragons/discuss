package com.forum.service.impl;

import java.util.List;

import com.forum.beans.Comment;
import com.forum.beans.Text;
import com.forum.dao.TextDao;
import com.forum.dao.impl.TextDaoImpl;
import com.forum.service.TextService;
import com.forum.utils.PageBean;

public class TextServiceImpl implements TextService{
private TextDao ts= new TextDaoImpl();

	@Override
	public void addText(Text text) {
		ts.addText(text);
	}

	@Override
	public void deleteTextByTextID(int tid) {
		ts.deleteTextByTextID(tid);
		
	}

	@Override
	public void modifyTextByTextID(Text text) {
		ts.modifyTextByTextID(text);
		
	}

	@Override
	public Text findTextByTname(String word) {
		Text text = ts.findTextByTname(word);
		return text;
	}

	@Override
	public List<Text> findLikeTextByname(String word) {
		List<Text> list = ts.findLikeTextByname(word);
		return list;
	}

	@Override
	public List<Text> findTextByClicks() {
		List<Text> list = ts.findTextByClicks();
		return list;
	}

	@Override
	public List<Text> findTextByNickname(String nickname) {
		List<Text> list = ts.findTextByNickname(nickname);
		return list;
	}

	@Override
	public List<Text> findAllText(int currentPage, int pageSize) {
		List<Text> list = ts.findAllText(currentPage, pageSize);
		return list;
	}

	@Override
	public List<Text> findhotPoint() {
		List<Text> hot =ts.findHotPoint();
		return hot;
	}

	@Override
	public Text findTextByID(int tid) {
		return ts.findTextBytid(tid);
	
	}

	@Override
	public List<Text> findTextByBID(int bid) {
		return ts.findTextByBid(bid);
	}

	@Override
	public String br(String context) {
		String replace = context.replaceAll("\\r\\n", "<br>");
		replace = context.replaceAll("\\n", "<br>");
		return replace;
	}

	@Override
	public void modifyClicks(Text text) {
		ts.modifyClicks(text);
	}

	@Override
	public PageBean<Text> queryTextPage(int pageSize, int currentPage) {
		PageBean<Text> pb = new PageBean<Text>(pageSize, currentPage);
		List<Text> list = ts.queryTextPage(pb.getCurrentPage(), pb.getPageSize());
		long totalCount = ts.findCount();
		pb.setList(list);
		pb.setTotalCount(totalCount);
		int totalPage = (int)((totalCount+pb.getPageSize()-1)/pb.getPageSize());
		pb.setTotalPage(totalPage);
		return pb;
	}

	@Override
	public PageBean<Text> queryTextPageByBID(int pageSize, int currentPage, int bid) {
		PageBean<Text> pb = new PageBean<Text>(pageSize, currentPage);
		List<Text> list = ts.queryTextPageByBID(pageSize, currentPage, bid);
		long totalCount = ts.findCount(bid);
		pb.setList(list);
		pb.setTotalCount(totalCount);
		int totalPage = (int)((totalCount+pb.getPageSize()-1)/pb.getPageSize());
		pb.setTotalPage(totalPage);
		return pb;
	}

	@Override
	public List<Text> findTextByUID(int uid) {
		return ts.queryTextByUID(uid);
	}


	@Override
	public List<Text> findTextByUserid(int userid) {
		return ts.findTextByUserid(userid);
		 
	}


	@Override
	public PageBean<Text> queryTextPageLikeTname(int pageSize, int currentPage, String word) {
		PageBean<Text> pb = new PageBean<Text>(pageSize, currentPage);
		List<Text> list = ts.queryTextPageLikeTname(pageSize, currentPage, word);
		List<Text> lt = ts.findLikeTextByname(word);
		Long totalCount =(long) lt.size();
		pb.setList(list);
		pb.setTotalCount(totalCount);
		int totalPage = (int)((totalCount+pb.getPageSize()-1)/pb.getPageSize());
		pb.setTotalPage(totalPage);
		return pb;
	}


}
