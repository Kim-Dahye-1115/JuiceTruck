package com.admin.db;

import java.sql.Date;

public class QnaBean {

	//DTO
	private int q_num;
	private String email;
	private String q_subject;
	private String q_content;
	private String files;
	//수정----------------------------------	----------------------
	private Date q_date;
	//수정----------------------------------	----------------------
	private String q_category;
	private int q_re_ref;
	private String nick;
	
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getQ_subject() {
		return q_subject;
	}
	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public Date getQ_date() {
		return q_date;
	}
	public void setQ_date(Date q_date) {
		this.q_date = q_date;
	}
	public String getQ_category() {
		return q_category;
	}
	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}
	public int getQ_re_ref() {
		return q_re_ref;
	}
	public void setQ_re_ref(int q_re_ref) {
		this.q_re_ref = q_re_ref;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	@Override
	public String toString() {
		return "QnaBean [q_num=" + q_num + ", email=" + email + ", q_subject=" + q_subject + ", q_content=" + q_content
				+ ", files=" + files + ", q_date=" + q_date + ", q_category=" + q_category + ", q_re_ref=" + q_re_ref
				+ ", nick=" + nick + ", getQ_num()=" + getQ_num() + ", getEmail()=" + getEmail() + ", getQ_subject()="
				+ getQ_subject() + ", getQ_content()=" + getQ_content() + ", getFiles()=" + getFiles()
				+ ", getQ_category()=" + getQ_category() + ", getQ_re_ref()=" + getQ_re_ref() + ", getNick()="
				+ getNick() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}

	

}
