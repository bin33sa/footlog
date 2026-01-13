package com.fl.model;

import java.util.List;

public class PageResult<T> {

	private final List<T> list;
	private final int pageNo;
	private final int totalPage;
	private final int dataCount;
	
	public PageResult(List<T> list, int pageNo, int totalPage, int dataCount) {
        this.list = list;
        this.pageNo = pageNo;
        this.totalPage = totalPage;
        this.dataCount = dataCount;
    }

	public List<T> getList() {
		return list;
	}

	public int getPageNo() {
		return pageNo;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getDataCount() {
		return dataCount;
	}
	
	
}
