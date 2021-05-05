package com.kakao.action;

public class ActionForward {
	// 페이지의 이동정보를 저장하는 객체
	// 페이지 이동시 항상 정보를 저장 (주소, 이동방식)
	
	private String path; //주소
	private boolean isRedirect; //이동방식-2가지
	// true - sendRedirect() 방식으로 이동 (주소,화면 변경O)
	// false - forward() 방식으로 이동 (주소 변경x, 화면 변경 O)	
	
	// alt shift s + r => set/get()
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
