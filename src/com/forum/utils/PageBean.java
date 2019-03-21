package com.forum.utils;

import java.util.List;

public class PageBean<T> {
	// 显示列表 - 当前页的列表
	private List<T> list;
	// 总记录条数
	private Long totalCount;
	// 总页数
	private Integer totalPage;
	// 每页显示条数
	private Integer pageSize;
	// 当前页数
	private Integer currentPage;

	// 初始化属性
	public PageBean(Integer pageSize, Integer currentPage, long totalCount, List<T> list) {
		// 前端传入
		this.pageSize = pageSize;
		if (this.pageSize == null || this.pageSize == 0) {
			this.pageSize = 3;
		}
		// 前端传入
		this.currentPage = currentPage;
		if (this.currentPage == null || this.currentPage == 0) {
			this.currentPage = 1;
		}
		// dao查询
		this.totalCount = totalCount;
		// dao查询
		this.list = list;

		this.totalPage = (int) ((this.totalCount + this.pageSize - 1) / this.pageSize);
	}

	public PageBean(int pageSize, int currentPage) {
		// 前端传入
		this.pageSize = pageSize;
		if (this.pageSize == null || this.pageSize == 0) {
			this.pageSize = 3;
		}
		// 前端传入
		this.currentPage = currentPage;
		if (this.currentPage == null || this.currentPage == 0) {
			this.currentPage = 1;
		}
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public Long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Long totalCount) {
		this.totalCount = totalCount;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

}
