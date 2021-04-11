package com.market.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.market.db.GoodsBean;
import com.market.db.GoodsDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class GoodsModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : GoodsModifyProAction_execute() 호출");
		
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

		request.setCharacterEncoding("UTF-8");		
		// 파라미터값 저장
		// -> GoodsBean 객체에 저장
		GoodsBean goods = new GoodsBean();
		
		goods.setG_name(multi.getParameter("g_name"));
		goods.setCategory(multi.getParameter("category"));
		goods.setNego(multi.getParameter("nego"));
		goods.setPrice(Integer.parseInt(multi.getParameter("price")));
		goods.setContent(multi.getParameter("content"));
		goods.setCondi(multi.getParameter("condi"));
		goods.setG_num(Integer.parseInt(multi.getParameter("num")));
		
		
		String img =null;
	
		if(multi.getFilesystemName("file0") != null ||
		   multi.getFilesystemName("file1") != null ||
		   multi.getFilesystemName("file2") != null ||
		   multi.getFilesystemName("file3") != null ||
		   multi.getFilesystemName("file4") != null ||
		   multi.getFilesystemName("file5") != null
		   ){
			  
				if(multi.getFilesystemName("file0") == null){
					 img= multi.getParameter("oldfile0")+",";
				  }else{
					 img= multi.getFilesystemName("file0")+",";
				  }
				
				if(multi.getFilesystemName("file1") == null){
					img += multi.getParameter("oldfile1")+",";
				}else{
					img += multi.getFilesystemName("file1")+",";
				}
				
				if(multi.getFilesystemName("file2") == null){
					img += multi.getParameter("oldfile2")+",";
				}else{
					img += multi.getFilesystemName("file2")+",";
				}
				
				if(multi.getFilesystemName("file3") == null){
					img += multi.getParameter("oldfile3")+",";
				}else{
					img += multi.getFilesystemName("file3")+",";
				}
				
				if(multi.getFilesystemName("file4") == null){
					img += multi.getParameter("oldfile4")+",";
				}else{
					img += multi.getFilesystemName("file4")+",";
				}
				
				if(multi.getFilesystemName("file5") == null){
					img += multi.getParameter("oldfile5");
				}else{
					img += multi.getFilesystemName("file5");
				}
				
		}
		
		
		goods.setImgs(img);
		
		System.out.println("M : 전달된 파라미터값 저장완료 >> "+goods);
		
		// DAO 객체생성 - modifyGoods(상품정보)
		GoodsDAO gdao = new GoodsDAO();
		gdao.modifyGoods(goods);
		
		
		
		
		
		// 페이지이동 (GoodsList)
		forward.setPath("./GoodsList.ag");
		forward.setRedirect(true);
		
		return forward;
	}
}
