/*
 공지사항 글 content 가져오는 클래스
 */
package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.db.NoticeDAO;

public class NoticeContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : noticeContentAction_execute() 호출");
		//파라미터 저장
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		System.out.println("@@@@@"+pageNum);
		
		//객체 생성 ->조회수 1증가, DB 글 저장
		NoticeDAO ndao = new NoticeDAO();
		ndao.updateReadCount(num);
		request.setAttribute("noticeContent", ndao.getNoticeContent(num));
		request.setAttribute("pageNum", pageNum);

		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./notice/noticeContent.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
