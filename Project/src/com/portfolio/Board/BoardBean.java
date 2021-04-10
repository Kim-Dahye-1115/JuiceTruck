package com.portfolio.Board;

import java.sql.Date;

public class BoardBean {
	/* 게시판에 대한 객체 */
	
	private int num;
	private String id;
	private String pw;
	private String title;
	private String content;
	private Date date;
	private int readcount;
	private String file;
	
	//답글에 대한 변수
	private int re_ref;
	private int re_lev;
	private int re_seq;
	
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
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	
	@Override
	public String toString() {
		return "BoardBean [num=" + num + ", id=" + id + ", pw=" + pw + ", title=" + title + ", content=" + content
				+ ", date=" + date + ", readcount=" + readcount + ", file=" + file + ", re_ref=" + re_ref + ", re_lev="
				+ re_lev + ", re_seq=" + re_seq + "]";
	}
}
