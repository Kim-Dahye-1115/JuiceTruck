package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.db.MemberBean;
import com.member.db.MemberDAO;

public class MemberUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : MemberUpdate_execute() 호출 ");

		// 로그인 세션 제어
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		System.out.println(email);

		ActionForward forward = new ActionForward();
		if (email == null) {
			forward.setPath("./Login.me");
			forward.setRedirect(true);
			return forward;
		}

		// DAO객체 생성 - getMember(id)
		MemberDAO mdao = new MemberDAO();
		MemberBean mb = mdao.getMember(email);

		// request 영역 정보 저장
		request.setAttribute("mb", mb);
		//request.setAttribute("mb", mdao.getMember("email"));
 
		// 페이지 이동(./member/updateMember.jsp)
		forward.setPath("./member/updateMember.jsp");
		forward.setRedirect(false);

		return forward;
	}

}
