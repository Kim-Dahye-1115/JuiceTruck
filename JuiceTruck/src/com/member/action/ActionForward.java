package com.member.action;

public class ActionForward {
	/* 페이지의 이동정보를 저장하는 객체
	 * 변수 : path(�주소) | isRedirect(이동방식 2가지)
	 * true - sendRedirect() 방식으로 이동 (주소,화면 변경O)
	 * false - forward() 방식으로 이동 (주소 변경x, 화면 변경 O)
	 * */
		
	private String path;
	private boolean isRedirect;
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
}
