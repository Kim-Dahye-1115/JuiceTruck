package com.market.action;

import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.ReviewBean;
import com.market.db.ReviewDAO;
import com.member.db.MemberDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : ReviewAction_excute 실행");
		
		request.setCharacterEncoding("utf8");
		response.setCharacterEncoding("utf8");
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		ActionForward forward = new ActionForward();
		if(nick == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		// 파일 업로드
		// upload 가상폴더 생성
				
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
		
		// 파라미터 저장
		ReviewBean rb = new ReviewBean();
		
		rb.setRe_content(multi.getParameter("re_content"));
		rb.setS_nick(multi.getParameter("s_nick"));
		rb.setW_nick(multi.getParameter("w_nick"));
		rb.setRe_star(Integer.parseInt(multi.getParameter("re_star")));
		
		// file을 img 변수에 담기
		String img = multi.getFilesystemName("file");
		rb.setFile(img);
		System.out.println("M : img "+ img);
		
		System.out.println("M : 전달된 파라미터값 저장완료");
		
		// DAO 객체 생성
		ReviewDAO rdao = new ReviewDAO();
		MemberDAO mdao = new MemberDAO();
		rdao.insertReview(rb);
		
		request.setAttribute("rb", rb);
		//request.setAttribute("userImg", mdao.getProfile(rb.getS_nick()));
		//request.setAttribute("avgStar", rdao.getAvgReStar(rb.getS_nick(),rb.getW_nick()));
		
		System.out.println("M : s_nick >> "+rb.getS_nick());
		
		
		// 페이지 이동
		forward.setPath("./reviewList.re?s_nick="+URLEncoder.encode(rb.getS_nick()));
		forward.setRedirect(true);
		
		return forward;
	}

}
