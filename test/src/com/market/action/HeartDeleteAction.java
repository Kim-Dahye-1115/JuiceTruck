package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.HeartDAO;

public class HeartDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

System.out.println("M : HeartDeleteAction_execute 호출");
		
		// 로그인 세션 제어
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		// 전달된 파라미터값 저장(num)
		int h_num = Integer.parseInt(request.getParameter("h_num"));
		int num = Integer.parseInt(request.getParameter("num"));
		
		// DAO 객체 생성
		HeartDAO hdao = new HeartDAO();
		
		// 좋아요 1감소 후 찜목록에서 삭제
		hdao.updateHeartMul(num);
		System.out.println("M : 좋아요1 감소");
		
		hdao.heartDelete(h_num);
		
		// 페이지 이동
		forward.setPath("./heartList.he");
		forward.setRedirect(true);
		
		return forward;
	}

}
