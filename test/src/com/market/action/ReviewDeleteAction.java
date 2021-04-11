package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.ReviewDAO;

public class ReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("M : ReviewDeleteAction_excute 호출");
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		ActionForward forward = new ActionForward();
		if(nick == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		// 전달된 파라미터값 저장
		int re_num = Integer.parseInt(request.getParameter("num"));
		
		// DAO 객체생성
		// 리뷰번호 이용하여 해당 리뷰 삭제
		ReviewDAO rdao = new ReviewDAO();
		rdao.deleteReview(re_num);
		
		// 페이지 이동
		forward.setPath("./reviewList.re");
		forward.setRedirect(true);
		
		return forward;
	}

}
