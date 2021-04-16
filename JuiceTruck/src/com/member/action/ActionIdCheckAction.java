package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.db.MemberDAO;

public class ActionIdCheckAction implements ActionIdCheck {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		 
		String email = request.getParameter("email");
		
		MemberDAO mdao = new MemberDAO();
		int result = mdao.confirm(email);
		
		PrintWriter out = response.getWriter();
		
		if(result == 0){
			out.print("사용 가능한 이메일입니다.");
		}else if(result == -1){
			out.println("이메일을 입력해주세요.");
		}else{
			out.println("사용 중인 이메일입니다. 다른 이메일을 이용하세요.");
		}

	}

}
