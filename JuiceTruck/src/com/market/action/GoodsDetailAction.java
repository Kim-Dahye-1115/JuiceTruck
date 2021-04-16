package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsBean;
import com.market.db.GoodsDAO;
import com.market.db.ReviewDAO;
import com.member.db.MemberDAO;

public class GoodsDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : GoodsDetailAction_execute() 호출");
		
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		String nick = (String) session.getAttribute("nick");
		
		// 전달된 데이터 저장(파라미터값)
		int num = Integer.parseInt(request.getParameter("num"));
		// DAO 객체 생성 - getGoods(num)
		GoodsDAO gdao = new GoodsDAO(); 
		MemberDAO mdao = new MemberDAO();
		ReviewDAO rdao = new ReviewDAO();
		
		GoodsBean goods = gdao.getGoods(num);
		
		// request 영역에 저장
		request.setAttribute("goods", goods);
		request.setAttribute("userImg", mdao.getProfile(goods.getNick()));
		request.setAttribute("avgStar", rdao.getAvgReStar(goods.getNick(),nick));
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./mainGoods/goods_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
