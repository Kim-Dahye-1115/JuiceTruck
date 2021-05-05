package com.market.db;

import java.sql.Date;

public class HeartBean {
	
	private int h_num;
	private String h_email;
	private String h_s_img;
	private String h_s_nick;
	private int h_g_num;
	private String h_g_img;
	private String h_g_name;
	private int h_g_price;
	private String h_g_location;
	private Date h_date;
	
	
	public int getH_num() {
		return h_num;
	}
	public void setH_num(int h_num) {
		this.h_num = h_num;
	}
	public String getH_email() {
		return h_email;
	}
	public void setH_email(String h_email) {
		this.h_email = h_email;
	}
	public String getH_s_img() {
		return h_s_img;
	}
	public void setH_s_img(String h_s_img) {
		this.h_s_img = h_s_img;
	}
	public String getH_s_nick() {
		return h_s_nick;
	}
	public void setH_s_nick(String h_s_nick) {
		this.h_s_nick = h_s_nick;
	}
	public int getH_g_num() {
		return h_g_num;
	}
	public void setH_g_num(int h_g_num) {
		this.h_g_num = h_g_num;
	}
	public String getH_g_img() {
		return h_g_img;
	}
	public void setH_g_img(String h_g_img) {
		this.h_g_img = h_g_img;
	}
	public String getH_g_name() {
		return h_g_name;
	}
	public void setH_g_name(String h_g_name) {
		this.h_g_name = h_g_name;
	}
	public int getH_g_price() {
		return h_g_price;
	}
	public void setH_g_price(int h_g_price) {
		this.h_g_price = h_g_price;
	}
	public String getH_g_location() {
		return h_g_location;
	}
	public void setH_g_location(String h_g_location) {
		this.h_g_location = h_g_location;
	}
	public Date getH_date() {
		return h_date;
	}
	public void setH_date(Date h_date) {
		this.h_date = h_date;
	}
	
	
	@Override
	public String toString() {
		return "HeartBean [h_num=" + h_num + ", h_email=" + h_email + ", h_s_img=" + h_s_img + ", h_s_nick=" + h_s_nick
				+ ", h_g_num=" + h_g_num + ", h_g_img=" + h_g_img + ", h_g_name=" + h_g_name + ", h_g_price="
				+ h_g_price  + ", h_g_location=" + h_g_location + ", h_date=" + h_date + "]";
	}
	
}
