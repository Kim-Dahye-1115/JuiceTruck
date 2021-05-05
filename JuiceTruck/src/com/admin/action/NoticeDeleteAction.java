//(관리자)공지사항 삭제
package com.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.db.NoticeDAO;


public class NoticeDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("noticeDeleteAction_execute() 호출");

		//로그인제어(관리자만)
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
				
		ActionForward forward = new ActionForward();
		if(!(email.equals("juicetruck.ad@gmail.com"))){
			forward.setPath("./noticeList.no");
			forward.setRedirect(true);
			return forward;
		}
		
		//글번호 저장
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("글번호"+num);
		//객체생성 -> 삭제
		NoticeDAO ndao = new NoticeDAO();
		ndao.deleteNotice(num);

		//페이지 이동
		forward.setPath("./noticeList.no");
		forward.setRedirect(true);
		return forward;
	}

}
