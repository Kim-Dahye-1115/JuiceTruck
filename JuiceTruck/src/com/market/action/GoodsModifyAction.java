package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsDAO;

public class GoodsModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : GoodsModifyAction_execute() 실행");
		
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}

		// 전달된 파라미터값 저장(num)
		int num = Integer.parseInt(request.getParameter("num"));

		// DAO 객체 생성 -> num에 해당하는 상품정보를 가져옴(GoodsBean)
		// -> getGoods(num)
		GoodsDAO gdao = new GoodsDAO();
		
		
		request.setAttribute("goodsbean", gdao.getGoods(num));

		// 페이지 이동
		forward.setPath("./mainGoods/goods_modify.jsp");
		forward.setRedirect(false);

		return forward;
	}

}
