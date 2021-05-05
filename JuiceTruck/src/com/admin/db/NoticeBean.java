package com.admin.db;

import java.sql.Date;

public class NoticeBean {
	//DTO
	private int n_num;
	private String n_title;
	private String n_content;
	private Date n_date;
	private int n_read_count;
	
	public int getN_num() {
		return n_num;
	}
	public void setN_num(int n_num) {
		this.n_num = n_num;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public Date getN_date() {
		return n_date;
	}
	public void setN_date(Date n_date) {
		this.n_date = n_date;
	}
	public int getN_read_count() {
		return n_read_count;
	}
	public void setN_read_count(int n_read_count) {
		this.n_read_count = n_read_count;
	}
	
	@Override
	public String toString() {
		return "noticeBean [n_num=" + n_num + ", n_title=" + n_title + ", n_content=" + n_content + ", n_date=" + n_date
				+ ", n_read_count=" + n_read_count + "]";
	}
	
	
	

}
