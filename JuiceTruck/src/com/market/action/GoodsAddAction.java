package com.market.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsBean;
import com.market.db.GoodsDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class GoodsAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : GoodsAddAction_execute() 호출");

		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		ActionForward forward = new ActionForward();
		if(email == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 한글처리
		request.setCharacterEncoding("utf-8");
		
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
		GoodsBean goods = new GoodsBean();
		
		goods.setNick(multi.getParameter("nick"));
		goods.setG_name(multi.getParameter("g_name"));
		goods.setCategory(multi.getParameter("category"));
		goods.setLocation(multi.getParameter("location"));
		goods.setNego(multi.getParameter("nego"));
		goods.setPrice(Integer.parseInt(multi.getParameter("price")));
		goods.setContent(multi.getParameter("content"));
		goods.setCondi(multi.getParameter("condi"));
		/*goods.setDate(multi.getParameter("reg_date"));*/
		
		String img= multi.getFilesystemName("file0")+","
		          + multi.getFilesystemName("file1")+","
		          + multi.getFilesystemName("file2")+","
		          + multi.getFilesystemName("file3")+","
				  + multi.getFilesystemName("file4")+","
				  + multi.getFilesystemName("file5");
		System.out.println("M : img "+ img);		
		
		goods.setImgs(img);
		
		System.out.println("M : 전달된 파라미터값 저장완료 >> "+goods);
		
		// DAO객체 생성후 메서드 호출
		GoodsDAO gdao = new GoodsDAO();
		
		gdao.insertGoods(goods);
		
		// 페이지 이동
		forward.setPath("./GoodsList.ag");
		forward.setRedirect(true);
		return forward;
	}

}
