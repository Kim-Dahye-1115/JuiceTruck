package com.market.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.HeartDAO;

public class HeartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : LoveListAction_execute 호출");
		
		// 로그인 체크
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
				
		ActionForward forward = new ActionForward();
		if(email==null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);

			return forward;
		}
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// DAO 객체 생성
		HeartDAO hdao = new HeartDAO();
		
		// 찜목록 정보를 가져오는 메서드
		List heartList = hdao.getHeartList(email);
		
		System.out.println("M : 찜목록 - "+heartList);
		
		// request 영역에 저장
		request.setAttribute("heartList", heartList);
		
		// 페이지 이동
		forward.setPath("./heart/heartList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
