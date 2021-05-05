package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.db.MemberDAO;

public class MemberFindPwAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberFindPwAction");
		MemberDAO mdao = new MemberDAO();
		
		request.setCharacterEncoding("UTF-8");
		
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		System.out.println("M : 회원정보 >>"+email+" | "+phone);
		
		String pass = mdao.findpass(email, phone);
		if(pass != null){
			request.setAttribute("findpass", pass);
		}
		
		//if (pass == null)
		ActionForward forward = new ActionForward();
		forward.setPath("./member/findPwForm.jsp");
		forward.setRedirect(false);
		return forward;
		
	}

}
