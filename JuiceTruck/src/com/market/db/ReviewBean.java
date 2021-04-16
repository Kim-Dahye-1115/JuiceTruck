package com.market.db;

import java.sql.Date;

public class ReviewBean {
	
	private int re_num;
	private String s_nick;
	private String w_nick;
	private String file;
	private String re_content;
	private Date re_date;
	private int re_star;
	
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public String getS_nick() {
		return s_nick;
	}
	public void setS_nick(String s_nick) {
		this.s_nick = s_nick;
	}
	public String getW_nick() {
		return w_nick;
	}
	public void setW_nick(String w_nick) {
		this.w_nick = w_nick;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public int getRe_star() {
		return re_star;
	}
	public void setRe_star(int re_star) {
		this.re_star = re_star;
	}
	
	@Override
	public String toString() {
		return "ReviewBean [re_num=" + re_num + ", s_nick=" + s_nick + ", w_nick=" + w_nick + ", file=" + file
				+ ", re_content=" + re_content + ", re_date=" + re_date + ", re_star=" + re_star + "]";
	}
	
}
