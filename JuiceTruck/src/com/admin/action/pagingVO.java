//페이징에 필요한 정보 VO
package com.admin.action;

public class pagingVO {
	private int n_pageNum;
	private int n_startNum;
	private int n_pageSize;
	private int n_noticeCount;
	private int n_pageBlock;
	
	public int getN_pageNum() {
		return n_pageNum;
	}
	public void setN_pageNum(int n_pageNum) {
		this.n_pageNum = n_pageNum;
	}
	public int getN_startNum() {
		return n_startNum;
	}
	public void setN_startNum(int n_startNum) {
		this.n_startNum = n_startNum;
	}
	public int getN_pageSize() {
		return n_pageSize;
	}
	public void setN_pageSize(int n_pageSize) {
		this.n_pageSize = n_pageSize;
	}
	public int getN_noticeCount() {
		return n_noticeCount;
	}
	public void setN_noticeCount(int n_noticeCount) {
		this.n_noticeCount = n_noticeCount;
	}
	public int getN_pageBlock() {
		return n_pageBlock;
	}
	public void setN_pageBlock(int n_pageBlock) {
		this.n_pageBlock = n_pageBlock;
	}
	
	@Override
	public String toString() {
		return "pagingVO [n_pageNum=" + n_pageNum + ", n_startNum=" + n_startNum + ", n_pageSize=" + n_pageSize
				+ ", n_noticeCount=" + n_noticeCount + ", n_pageBlock=" + n_pageBlock + "]";
	}
	
}
