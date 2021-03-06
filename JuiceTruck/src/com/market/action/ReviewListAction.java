package com.market.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.action.pagingVO;
import com.market.db.ReviewDAO;
import com.member.db.MemberDAO;

public class ReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/ReviewListAction_excute 호출");
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String w_nick = (String) session.getAttribute("nick");
		
		ActionForward forward = new ActionForward();
		if(w_nick == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		String s_nick = request.getParameter("s_nick");
		
		System.out.println("M : s_nick >>"+s_nick);
		
		String nick = w_nick;
		if(s_nick != null) nick  = s_nick;	//s_nick 이 존재하면
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null){
			pageNum = "1";
		}
		
		// DAO 객체 생성 - 상품정보 모두를 가져오는 메서드
		ReviewDAO rdao = new ReviewDAO();
		MemberDAO mdao = new MemberDAO();
		
		pagingVO pv = new pagingVO();
		pv.setN_pageBlock(10);
		pv.setN_noticeCount(rdao.getReviewCount(s_nick, w_nick));
		pv.setN_pageNum(Integer.parseInt(pageNum));
		pv.setN_pageSize(5);
		int startNum = (pv.getN_pageNum()-1)*pv.getN_pageSize()+1;
		pv.setN_startNum(startNum);
		
		
		
		// request 영역에 저장
		request.setAttribute("reviewList", rdao.getReviewList(s_nick, w_nick, pv));
		request.setAttribute("pv", pv);
		request.setAttribute("userImg", mdao.getProfile(nick));
		request.setAttribute("avgStar", rdao.getAvgReStar(s_nick,w_nick));
		
		// 페이지 이동 (./review/reviewList.jsp)
		forward.setPath("./review/reviewList.jsp");
		forward.setRedirect(false);		
		return forward;
	}

}
