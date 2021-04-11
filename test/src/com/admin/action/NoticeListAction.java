//공지사항 리스트 저장,페이징 관련 페이지
package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.db.NoticeDAO;

import sun.print.resources.serviceui;

public class NoticeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("NoticeListAction_execute() 호출");

		//세션제어 없음
		//한글처리
		request.setCharacterEncoding("UTF-8");
		//값 저장
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null){
			pageNum = "1";
		}
		
		String search = request.getParameter("search");
		System.out.println("검색어 : "+search);
		if(search==null){
			search="all";
		}
		
		//객체 생성
		NoticeDAO ndao = new NoticeDAO();
		pagingVO pv = new pagingVO();
		pv.setN_pageBlock(2);
		pv.setN_noticeCount(ndao.getNoticeCount(search));
		pv.setN_pageNum(Integer.parseInt(pageNum));
		pv.setN_pageSize(10);
		int startNum = (pv.getN_pageNum()-1)*pv.getN_pageSize()+1;
		pv.setN_startNum(startNum);
		
		System.out.println(pv);
		
		request.setAttribute("noticeList", ndao.getNoticeList(pv,search));
		request.setAttribute("pagingVO", pv);

		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./notice/noticeList.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
