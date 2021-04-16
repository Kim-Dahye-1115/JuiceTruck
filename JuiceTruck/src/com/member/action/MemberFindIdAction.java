package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.db.MemberDAO;


public class MemberFindIdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberFindIdAction");
		MemberDAO mdao = new MemberDAO();
		
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		
		System.out.println("M : 회원정보 >>"+name+" | "+phone);
		
		String email = mdao.findemail(name, phone);
		if(email != null){
			request.setAttribute("findemail", email);
		}
		
		//if (email == null)
		ActionForward forward = new ActionForward();
		forward.setPath("./member/findIdForm.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
