package com.member.db;

import java.sql.Date;

public class MemberBean {
	
	private int user_num;
	private String email;
	private String pass;
	private String nick;
	private String zip;
	private String addr;
	private String addr2;
	private String name;
	private String phone;
	private Date join_date;
	private String user_img;
	private String platform_type;
	private String access_token;
	
	
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public String getUser_img() {
		return user_img;
	}
	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}
	public String getPlatform_type() {
		return platform_type;
	}
	public void setPlatform_type(String platform_type) {
		this.platform_type = platform_type;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	
	
	@Override
	public String toString() {
		return "MemberBean [user_num=" + user_num + ", email=" + email + ", pass=" + pass + ", nick=" + nick + ", zip="
				+ zip + ", addr=" + addr + ", addr2=" + addr2 + ", name=" + name + ", phone=" + phone + ", join_date="
				+ join_date + ", user_img=" + user_img + ", platform_type=" + platform_type + ", access_token="
				+ access_token + "]";
	}

	
	
	
}
