package com.kakao.action;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


// 참고한 홈페이지 : https://itstudy-mary.tistory.com/m/148?category=920400
// 라이브 러리를 추가해야합니다. 두개... 그래야 오류가 없습니다. 
// http://localhost:8080/
@WebServlet("/oauth/kakao")
public class KakaoController extends HttpServlet {
	private final static String TAG = "KakaoController : ";
	private static final long serialVersionUID = 1L;
       
    public KakaoController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// http://localhost:8080/kakao_v2/
		String cmd = request.getParameter("cmd");
		System.out.println(TAG+"router : "+cmd);
		Action action = router(cmd);
		try {  // action.execute(request, response); 원래 이것만 있는데 오류떠서 try~ catch로 변경함.
			action.execute(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("d@@@@@@@"+cmd);
		}
	}
	
	public Action router(String cmd) {
		if(cmd.equals("callback")) {
			// 홈페이지로 이동
			return new KakaocallbackAction();
		}
		return null;
		
	}
	

}