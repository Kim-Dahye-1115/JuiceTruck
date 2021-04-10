package com.portfolio.Notice;

import java.sql.Date;

public class NoticeBean {
	/* notice 테이블에 대한 자바빈 */
	
	//not null
	private int num;
	private String id;
	private String pw;
	private String title;
	private String content;
	
	private Date date;
	private int readcount;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	@Override
	public String toString() {
		return "NoticeBean [num=" + num + ", id=" + id + ", pw=" + pw + ", title=" + title + ", content=" + content
				+ ", date=" + date + ", readcount=" + readcount + "]";
	}
}
