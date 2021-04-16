package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.ReviewDAO;

public class ReviewUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("M : ReviewUpdateAction_excute 호출");
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		ActionForward forward = new ActionForward();
		if(nick == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		// 전달된 파라미터값 저장(num)
		int num = Integer.parseInt(request.getParameter("num"));
		
		// DAO 객체 생성 -> num에 해당하는 정보 가져옴
		ReviewDAO rdao = new ReviewDAO();
		//ReviewBean rb = rdao.getReview(num);
		request.setAttribute("rb", rdao.getReview(num));
		
		// 페이지 이동
		forward.setPath("./review/reviewUpdateForm.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
