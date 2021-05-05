/*
문의글 내용 보기
*/
package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.db.QnaDAO;

public class QnaContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("QnaContentAction_execute()호출");
		
		//로그인제어
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		System.out.println(email);
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 파라미터값 저장(글번호)
		int num = Integer.parseInt(request.getParameter("num"));
		//dao객체생성 ->request에 저장
		QnaDAO qdao = new QnaDAO();
		request.setAttribute("qnaContent", qdao.getQnaContent(num));
		System.out.println(qdao.getQnaContent(num));
		//페이지이동
		forward.setPath("./qna/qnaContent.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
