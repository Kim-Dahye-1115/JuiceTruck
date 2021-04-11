package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ActionIdCheck {
	//추상메서드
	public void execute(HttpServletRequest request,
				HttpServletResponse response) throws Exception;

}
