/*
문의글 등록 액션 클래스
*/

package com.admin.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.db.QnaBean;
import com.admin.db.QnaDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class QnaWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("qnaWriteAction_execute()호출");
		
		//로그인제어
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
				
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//업로드 폴더 지정
		ServletContext ctx = request.getServletContext();
		String realPath = ctx.getRealPath("/upload");
		
		//파일 크기 10MB
		int maxSize = 10*1024*1024; 
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		// QnaBean에 파라미터 저장
		QnaBean qb = new QnaBean();
		qb.setEmail(email);
		qb.setFiles(multi.getFilesystemName("file"));
		qb.setQ_category(multi.getParameter("category"));
		qb.setQ_content(multi.getParameter("content"));
		qb.setQ_subject(multi.getParameter("subject"));
		System.out.println(qb);
		//dao 객체 생성 -> db에 저장
		QnaDAO qdao = new QnaDAO();
		qdao.insertQna(qb);
		//페이지이동
		forward.setPath("./qnaList.qa");
		forward.setRedirect(true);
		
		return forward;
	}

}
