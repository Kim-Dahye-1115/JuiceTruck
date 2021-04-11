package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsDAO;

public class GoodsDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : GoodsDeleteAction_execute() 호출");
		
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 전달된 파라미터정보 저장 (num)
		int num = Integer.parseInt(request.getParameter("num"));
		
		// DAO 객체 생성 - deleteGoods(num)
		//  상품번호를 사용하여 해당 상품 삭제
		GoodsDAO gdao = new GoodsDAO();
		gdao.deleteGoods(num);

		// 페이지 이동(GoodsList.ag)		
		forward.setPath("./GoodsList.ag");
		forward.setRedirect(true);
		
		return forward;
	}

}
