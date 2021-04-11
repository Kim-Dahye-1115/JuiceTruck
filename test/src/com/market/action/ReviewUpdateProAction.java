package com.market.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.ReviewBean;
import com.market.db.ReviewDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReviewUpdateProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : reviewUpdateProAction_excute 호출");
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		ActionForward forward = new ActionForward();
		if(nick == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		// 파일이 저장되는 위치
		ServletContext ctx = request.getServletContext();
		String realpath = ctx.getRealPath("/upload");
						
		System.out.println("M : realpath -"+realpath);
						
		// 파일의 용량
		int maxSize = 10 * 1024 * 1024; //10MB
						
		MultipartRequest multi =
				new MultipartRequest(
						request,
						realpath,
						maxSize,
						"UTF-8",
						new DefaultFileRenamePolicy()
				);
						
		System.out.println("M : 파일업로드 완료!");
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 파라미터값 저장
		ReviewBean rb = new ReviewBean();
		
		rb.setRe_content(multi.getParameter("re_content"));
		rb.setRe_num(Integer.parseInt(multi.getParameter("re_num")));
		rb.setRe_star(Integer.parseInt(multi.getParameter("re_star")));
		rb.setS_nick(multi.getParameter("s_nick"));
		rb.setW_nick(multi.getParameter("w_nick"));
		
		String img = multi.getFilesystemName("inputFile");
		rb.setFile(img);
		System.out.println("M : img "+img);
		
		System.out.println("M : 전달된 파라미터값 저장완료");
		
		// DAO 객체 생성
		ReviewDAO rdao = new ReviewDAO();
		rdao.updateReview(rb);
		
		// 페이지 이동
		forward.setPath("./reviewList.re");
		forward.setRedirect(true);
		
		return forward;
	}

}
