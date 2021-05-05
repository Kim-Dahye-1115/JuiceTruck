package com.admin.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"*.qa","*.no"}) //url 패턴(가상주소의 형태)
public class AdminFrontController extends HttpServlet{
	
	/* 컨트롤러 : 모델과 뷰의 연결지점 => 서블릿 */
	
	protected void doProcess(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AdminOrderFrontController-doProcess()");
		
		System.out.println("\n\n 1. 가상주소 계산");
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		
		String command = requestURI.substring(contextPath.length());
		System.out.println("command : "+command);
		
		System.out.println("\n 1. 가상주소 계산");
		
		
		System.out.println("\n 2. 가상주소 매핑");
		
		Action action = null;
		ActionForward forward = null;
		
		//("/이동 할 가상주소")
		if(command.equals("/qnaWrite.qa")){
			System.out.println("C : ./qnaWrite.qa 호출");
			
			//Action 객체
			forward = new ActionForward();
			//("./이동 할 실제주소")
			forward.setPath("./qna/qnaWrite.jsp");
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
			
		}else if(command.equals("/qnaWriteAction.qa")){
			System.out.println("C : ./qnaWriteAction.qa 호출");
			//Action 객체
			action = new QnaWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/qnaList.qa")){
			System.out.println("C : ./qnaList.qa 호출");
			
			action = new QnaListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/qnaContent.qa")){
			System.out.println("C : ./qnaContent.qa 호출");
			
			action = new QnaContentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/AdminQnaWrite.qa")){
			System.out.println("C : adminQnaWrite.qa 호출");
			
			action = new AdminQnaWrite();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/AdminQnaWriteAction.qa")){
			System.out.println("C : ./AdminQnaWriteAction.qa 호출");
			
			action = new AdminQnaWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/noticeWrite.no")){
			System.out.println("C : / noticeWrite.no 호출");
			
			//Action 객체
			forward = new ActionForward();
			//("./이동 할 실제주소")
			forward.setPath("./notice/noticeWrite.jsp");
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
		}else if(command.equals("/noticeWriteAction.no")){
			System.out.println("C : / noticeWriteAction.no 호출");
			
			action = new NoticeWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/noticeList.no")){
			System.out.println("C : /noticeList.no 호출");
			
			action = new NoticeListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/noticeContent.no")){
			System.out.println("C : /noticeContent.no 호출");
			
			action = new NoticeContentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/noticeDelete.no")){
			System.out.println("C : /noticeDelete.no 호출");
			
			action = new NoticeDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("\n 2. 가상주소 매핑");
		
		
		System.out.println("\n 3. 페이지 이동");
		
		if(forward !=null){ 
			if(forward.isRedirect()){ //이동정보가 있을경우 페이지 이동
				response.sendRedirect(forward.getPath());
			}
			else{
				RequestDispatcher dis =
						request.getRequestDispatcher(forward.getPath());
				
				dis.forward(request, response);
			}
		}
		
		
		System.out.println("\n 3. 페이지 이동");
		
		
		
		
		
	}
	
	@Override
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AdminOrderFrontController-doGet()");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AdminOrderFrontController-doPost()");
		doProcess(request, response);
	}
	
	

}