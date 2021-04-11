package com.market.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsBean;
import com.market.db.GoodsDAO;

public class GoodsListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : GoodsListAction_execute() 호출");
		
		/*HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		if(email==null){
			
		}
		//String email = "aa"; //임시 아이디
*/		
		// DAO 객체 생성 - 상품정보 모두를 가져오는 메서드
		GoodsDAO agdao = new GoodsDAO();
		
		String item = request.getParameter("item");
		if(item == null){
			item = "all";
		}
		
		List<GoodsBean> goodsList = agdao.getGoodsList(item);

		// request 영역에 저장
		request.setAttribute("goodsList", goodsList);
		
		// 페이지 이동 (view  ./admingoods/admin_goods_list.jsp)
		ActionForward forward = new ActionForward();
		forward.setPath("./mainGoods/goods_list.jsp");
		forward.setRedirect(false);		
		return forward;
	}

}
