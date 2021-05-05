package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("M : MemberLogoutAction_execute() 호출 ");
		
		// 세션 초기화
		HttpSession session = request.getSession();
		session.invalidate();
		
		// 페이지이동 (메인페이지)
		// 자바스크립트 사용
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.print("<script>");
		out.print(" alert('로그아웃 성공!');");
		out.print(" location.href='./GoodsList.ag'; ");
		out.print("</script>");
		
		out.close();
		
		return null;
	}

}
