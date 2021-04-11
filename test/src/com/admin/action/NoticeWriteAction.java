/*
(꽌리자)공지사항 등록 액션
*/

package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.db.NoticeBean;
import com.admin.db.NoticeDAO;

public class NoticeWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("NoticeWriteAction_execute()호출");
		
		//로그인제어(관리자만 접근)
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
				
		ActionForward forward = new ActionForward();
		if(!email.equals("admin@itwill.com")){
			forward.setPath("./noticeList.no");
			forward.setRedirect(true);
			return forward;
		}
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//bean에 파라미터 저장
		NoticeBean nb = new NoticeBean();
		nb.setN_content(request.getParameter("content"));
		nb.setN_title(request.getParameter("title"));
		System.out.println(nb);
		
		//DAO객체 생성 -> DB에 저장
		NoticeDAO ndao = new NoticeDAO();
		ndao.insertNotice(nb);

		//페이지이동
		forward.setPath("./noticeList.no");
		forward.setRedirect(true);
		
		return forward;
	}

}
