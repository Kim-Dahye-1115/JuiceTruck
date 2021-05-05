package com.member.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.db.MemberBean;
import com.member.db.MemberDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class JoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : JoinAction_execute() 호출");
		//한글데이터 처리
		request.setCharacterEncoding("UTF-8");
		
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
			
			
		//저장된 파라미터값
		MemberBean mb = new MemberBean();
			
		mb.setEmail(multi.getParameter("email"));
		mb.setPass(multi.getParameter("pass"));
		mb.setNick(multi.getParameter("nick"));
		mb.setZip(multi.getParameter("zip"));
		mb.setAddr(multi.getParameter("addr"));
		mb.setAddr2(multi.getParameter("addr2"));
		mb.setName(multi.getParameter("name"));
		mb.setPhone(multi.getParameter("phone"));
			
		String user_img = multi.getFilesystemName("user_img");
		mb.setUser_img(user_img);
		//mb.setPlatform_type(request.getParameter("platform_type"));
		//mb.setAccess_token(request.getParameter("access_token"));
		
		
		System.out.println("mb >>> "+mb);
		
		// DAO 생성
		MemberDAO mdao = new MemberDAO();
					
		// 회원가입 메서드
		mdao.joinMember(mb);
					
		// 페이지 이동 (로그인 페이지로 이동)
		ActionForward forward = new ActionForward();
		forward.setPath("./MemberLogin.me");
		forward.setRedirect(true);
			
		return forward;
	}
}
