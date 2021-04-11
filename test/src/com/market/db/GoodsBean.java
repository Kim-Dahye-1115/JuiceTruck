package com.market.db;

import java.sql.Date;

public class GoodsBean {
	
	private int g_num;
	private String nick; 
	private String g_name; 
	private int price;
	private String content;
	private String category;
	private String imgs;
	private String location;
	private String nego;
	private int read_count;
	private int heart;
	private Date date;
	private String condi;
	
	
	
	public int getG_num() {
		return g_num;
	}
	public void setG_num(int g_num) {
		this.g_num = g_num;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String g_name) {
		this.g_name = g_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getNego() {
		return nego;
	}
	public void setNego(String nego) {
		this.nego = nego;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public int getHeart() {
		return heart;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getCondi() {
		return condi;
	}
	public void setCondi(String condi) {
		this.condi = condi;
	}
	
	
	@Override
	public String toString() {
		return "GoodsBean [g_num=" + g_num + ", nick=" + nick + ", g_name=" + g_name + ", price=" + price + ", content="
				+ content + ", category=" + category + ", imgs=" + imgs + ", location=" + location + ", nego=" + nego
				+ ", read_count=" + read_count + ", heart=" + heart + ", date=" + date + ", condi=" + condi + "]";
	}
	
	
	


}
