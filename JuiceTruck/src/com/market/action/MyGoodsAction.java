package com.market.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsBean;
import com.market.db.GoodsDAO;

public class MyGoodsAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : MyGoodsList_execute 호출");
		
		// 로그인 체크
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
				
		ActionForward forward = new ActionForward();
		if(nick==null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);

			return forward;
		}
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// DAO 객체 생성
		GoodsDAO gdao = new GoodsDAO();
		
		// 내상품목록 정보를 가져오는 메서드
		List MyGoodsList = gdao.getMyGoodsList(nick);
		
		System.out.println("M : 찜목록 - "+MyGoodsList);
		
		// request 영역에 저장
		request.setAttribute("MyGoodsList", MyGoodsList);
		
		// 페이지 이동
		forward.setPath("./mainGoods/my_goods_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
