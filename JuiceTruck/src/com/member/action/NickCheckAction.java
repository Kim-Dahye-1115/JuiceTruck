package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.db.MemberDAO;

public class NickCheckAction implements ActionIdCheck {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		 
		String nick = request.getParameter("nick");
		
		MemberDAO mdao = new MemberDAO();
		
		int result = mdao.nickCheck(nick);
		
		PrintWriter out = response.getWriter();
		
		if(result == 0){
			out.print("사용 가능한 닉네임입니다.");
		}else if(result == -1){
			out.println("닉네임을 입력해주세요.");
		}else{
			out.println("사용 중인 닉네임입니다. 다시 입력해 주세요.");
		}
	}
	
}
