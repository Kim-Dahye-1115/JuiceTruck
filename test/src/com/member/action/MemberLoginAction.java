package com.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.member.db.MemberBean;
import com.member.db.MemberDAO;

public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : MemberLoginAction_execute() 호출");

		// 한글처리 
		request.setCharacterEncoding("UTF-8");
		// 전달되는 파라미터 정보 저장(id,pass)
		// 자바빈 객체 생성후 파라미터 정보 저장
		MemberBean mb = new MemberBean();
		mb.setEmail(request.getParameter("email"));
		mb.setPass(request.getParameter("pass"));
		
		System.out.println("M : 전달정보 "+mb);
		
		// DAO 객체 생성후 처리메서드 생성
		MemberDAO mdao = new MemberDAO();
		// 로그인 체크 메서드
		int result = mdao.loginCheck(mb);
		
		System.out.println("M : 로그인 체크 결과 >> "+result);
		
		//페이지 이동을 자바스크립트를 사용
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 결과에 따라서 페이지 이동
		if(result == 0){ // 비밀번호 오류
			out.print("<script>");
			out.print(" alert('비밀번호 오류!');");
			out.print(" history.back(); ");
			out.print("</script>");
			
			out.close();
			
			return null;//js 이동시 컨트롤러의 이동정보는 null		
		}else if(result == -1){ // 아이디 없음
			out.print("<script>");
			out.print(" alert('아이디 없음!');");
			out.print(" history.back(); ");
			out.print("</script>");
			
			out.close();
			
			return null;//js 이동시 컨트롤러의 이동정보는 null	
		}else{ //result == 1 로그인성공
			//로그인 성공시 -> 로그인 정보 유지(session)
			
			mb = mdao.getMember(mb.getEmail());
			
			HttpSession session = request.getSession();
			session.setAttribute("email", mb.getEmail());
			session.setAttribute("nick", mb.getNick());
			session.setAttribute("user_img", mb.getUser_img());
			
			//2.
			out.print("<script>");
			out.print(" alert('로그인 성공!!');");
			out.print(" location.href='./GoodsList.ag' ");
			out.print("</script>");
			
			out.close();
			
			return null;//js 이동시 컨트롤러의 이동정보는 null	
		 			
		}
		
	}

}
