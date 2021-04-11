package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsBean;
import com.market.db.GoodsDAO;
import com.market.db.HeartBean;
import com.market.db.HeartDAO;

public class HeartAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : LoveAddAction_excute() 호출");
		
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
				
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달받은 상품번호 저장
		int num =Integer.parseInt(request.getParameter("num"));
		
		// GoodsDAO 객체 생성 - 상품정보 받아와서 저장
		GoodsDAO gdao = new GoodsDAO();
		GoodsBean gb = gdao.getGoods(num);
		
		System.out.println("M : 상품 정보"+gb);
		
		// HeartBean 생성 후 저장
		HeartBean hb = new HeartBean();
		
		hb.setH_email(email);
		hb.setH_g_num(gb.getG_num());
		hb.setH_g_name(gb.getG_name());
		hb.setH_g_img(gb.getImgs());
		hb.setH_s_nick(gb.getNick());
		hb.setH_g_price(gb.getPrice());
		hb.setH_g_location(gb.getLocation());

		System.out.println("M : 찜한 상품 정보"+hb);
		
		HeartDAO hdao = new HeartDAO();
		
		// 찜목록 정보 중복체크 - 중복상품인 경우 먼저 있던 정보 삭제
		int check = hdao.checkGoods(hb);
		System.out.println("M : 중복체크 - "+check);
		
		// 좋아요 1 증가 메서드
		hdao.updateHeartAdd(num);
		System.out.println("M : 좋아요 1증가");
		
		// 중복체크와 좋아요 증가된 정보를 저장
		hdao.heartAdd(hb);
		System.out.println("M : 찜목록 저장완료");
		
		
		// 페이지 이동
		forward = new ActionForward();
		forward.setPath("./heartList.he");
		forward.setRedirect(true);
		
		return forward;
	}

}
