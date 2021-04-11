package com.member.action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.db.MemberBean;
import com.member.db.MemberDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemberUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : MemberUpdateAction_execute() 호출");
		
		// 로그인 제어
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./Login.me");
			forward.setRedirect(true);
			return forward;
		}
		
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
		
		String user_img=multi.getFilesystemName("user_img");
		
		mb.setUser_img(user_img);
		//mb.setPlatform_type(request.getParameter("platform_type"));
		//mb.setAccess_token(request.getParameter("access_token"));

		
		System.out.println("M : 수정할 정보 "+mb);
		
		// DAO 객체 생성 - 정보 수정메서드 updateMember(mb);
		MemberDAO mdao = new MemberDAO();
		int check = mdao.updateMember(mb);
		
		System.out.println("M : 수정결과 >> "+check);
		
		// 수정 처리 결과에 따른 페이지 이동
		// 자바스크립트 사용해서 이동
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(check == 0){
			out.print("<script>");
//			out.print(" alert('비밀번호를 입력하세요.'); ");
			out.print(" history.back(); ");
			out.print("</script>");
//			
			out.close();
			return null;
			
		}else if(check == -1){
			out.print("<script>");
//			out.print(" alert('회원 정보 없음'); ");
			out.print(" history.back(); ");
			out.print("</script>");
			
			out.close();
			return null;
		}else{ // check == 1
			out.print("<script>");
//			out.print(" alert('회원 정보 수정이 완료되었습니다.'); ");
			out.print(" location.href='./GoodsList.ag'; ");
			out.print("</script>");
			
			out.close();
			return null;
		}
		
	}

}
