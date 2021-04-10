package com.portfolio.Member;

public class MemberBean {
	/* member 테이블에 대한 자바빈 */
	
	//필수 입력 사항
	private String id;
	private String pw;
	private String email;
	
	//선택 입력 사항
	private String nick;
	private String name;
	private String profile_img;
	
	//우편번호 n 주소 관련 변수
	private String postcode;
	private String address;
	private String detailAddress;
	private String extraAddress;
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	
	@Override
	public String toString() {
		return "MemberBean [id=" + id + ", pw=" + pw + ", email=" + email + ", nick=" + nick + ", name=" + name
				+ ", postcode=" + postcode + ", address=" + address + ", detailAddress=" + detailAddress
				+ ", extraAddress=" + extraAddress + ", profile_img=" + profile_img + "]";
	}
}
