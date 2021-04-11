/*
(관리자) db에서 글내용(content) 가져와서 문의글 답변 작성 페이지로 이동
*/

package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.db.QnaDAO;

public class AdminQnaWrite implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : AdminQnaWrite_execute() 호출");
		
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		ActionForward forward = new ActionForward();
		//로그인제어
		if(!email.equals("admin@itwill.com")){
			forward.setPath("./qnaList.qa");
			forward.setRedirect(true);
			return forward;
		}
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 파라미터값 저장(글번호) -> request 저장
		int num = Integer.parseInt(request.getParameter("num"));
		QnaDAO qdao = new QnaDAO();
		// 영역객체에 content 저장
		request.setAttribute("qnaContent", qdao.getQnaContent(num));
		
		//페이지이동
		forward.setPath("./qna/adminQnaWrite.jsp");
		forward.setRedirect(false);
		
		return forward;
		
		
		
	}

}
