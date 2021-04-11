/*
문의글 리스트 액션 클래스
*/
package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.db.QnaDAO;

public class QnaListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("M : QnaListAction_execute() 호출");

		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		System.out.println(email);
		
		ActionForward forward = new ActionForward();
		
		//로그인 제어
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null){
			pageNum = "1";
		}
		
		//dao객체 생성 -> DB에서 정보 가져와서 영역객체에 저장
		QnaDAO qdao = new QnaDAO();
		pagingVO pv = new pagingVO();
		pv.setN_pageBlock(2);
		pv.setN_noticeCount(qdao.getQnaCount(email));
		pv.setN_pageNum(Integer.parseInt(pageNum));
		pv.setN_pageSize(10);
		int startNum = (pv.getN_pageNum()-1)*pv.getN_pageSize()+1;
		pv.setN_startNum(startNum);
		
		System.out.println(pv);
		
		request.setAttribute("qnaList", qdao.getQnaList(email, pv));
		request.setAttribute("pagingVO", pv);
		
		//페이지이동
		forward.setPath("./qna/qnaList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
