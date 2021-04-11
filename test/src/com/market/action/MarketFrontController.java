package com.market.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"*.re","*.ag","*.se","*.he"}) //url 패턴(가상주소의 형태)
public class MarketFrontController extends HttpServlet {
	
	/* 컨트롤러 : 모델과 뷰의 연결지점 => 서블릿 */

	protected void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MarketFrontController-doProcess()");
		
		System.out.println("\n\n 1. 가상주소 계산");
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();

		String command = requestURI.substring(contextPath.length());
		System.out.println("command : " + command);
		System.out.println("\n 1. 가상주소 계산");

		
		System.out.println("\n 2. 가상주소 매핑");
		Action action = null;
		ActionForward forward = null;
		
		//("/이동 할 가상주소")
		// 리뷰 작성 페이지 이동
		if(command.equals("/reviewWrite.re")){
			System.out.println("C : /reviewWrite.re 호출");
			
			forward = new ActionForward();
			forward.setPath("./review/reviewWriteForm.jsp");
			forward.setRedirect(false);
			
		// 리뷰 작성 액션 페이지 이동
		}else if(command.equals("/reviewWriteAction.re")){
			System.out.println("C : /reviewWriteAction.re 호출");
			action = new ReviewWriteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		// 리뷰 리스트 이동
		}else if(command.equals("/reviewList.re")){
			System.out.println("C : /reviewList.re 호출");
			action = new ReviewListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		// 리뷰 수정 페이지 이동
		}else if(command.equals("/reviewUpdate.re")){
			System.out.println("C : /reviewUpdate.re 호출");
			action = new ReviewUpdateAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		// 리뷰 수정 액션 이동
		}else if(command.equals("/reviewUpdateProAction.re")){
			System.out.println("C : /reviewUpdateProAction.re 호출");
			action = new ReviewUpdateProAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		// 리뷰 삭제
		}else if(command.equals("/reviewDelete.re")){
			System.out.println("C : /reviewDelete.re 호출");
			action = new ReviewDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/heartAdd.he")){
			System.out.println("C : /heartAdd.he 호출");
			
			// LoveAddAction 객체 생성
			action = new HeartAddAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}else if(command.equals("/heartList.he")){
			System.out.println("C : /heartList.he 호출");
			
			action = new HeartListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/heartDelete.he")){
			System.out.println("C : /heartDelete.he 호출");
			
			action = new HeartDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
/******************************** 여기서부터 은비님 코드 ************************************/
		else if(command.equals("/GoodsList.ag")){
			System.out.println("C : /GoodsList.ag 호출");
			System.out.println("C : DB에서 정보를 가져와서 view 출력");
			
			// GoodsListAction 객체 생성
			action = new GoodsListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsDetail.ag")){
			System.out.println("C : /GoodsDetail.go 호출");
			System.out.println("C : DB정보를 저장해서 view페이지 출력");
			
			// GoodsDetailAction 객체 생성
			action = new GoodsDetailAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsAdd.ag")){
			System.out.println("C : /GoodsAdd.ag 호출");
			System.out.println("C : view페이지로 이동");
			
			forward = new ActionForward();
			forward.setPath("./mainGoods/goods_write.jsp");
			forward.setRedirect(false);			
		}else if(command.equals("/GoodsAddAction.ag")){
			System.out.println("C : /GoodsAddAction.ag 호출");
			System.out.println("C : DB에 정보를 저장 후 페이지 이동");
			
			// GoodsAddAction 객체 생성
			action = new GoodsAddAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}else if(command.equals("/GoodsModify.ag")){
			System.out.println("C : /GoodsModify.ag 호출 ");
			System.out.println("C : DB정보를 가져와서 수정 -> 저장");
			
			// GoodsModifyAction 객체 생성
			action = new GoodsModifyAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsModifyProAction.ag")){
			System.out.println("C : /GoodsModifyProAction.ag 호출");
			System.out.println("C : 전달정보를 받아서 DB에 저장");
			
			// GoodsModifyProAction 객체 생성
			action = new GoodsModifyProAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/GoodsDelete.ag")){
			System.out.println("C : /GoodsDelete.ag 호출 ");
			System.out.println("C : DB이동후 정보 삭제 ");
			// GoodsDeleteAction
			
			action = new GoodsDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/search.se")){
			System.out.println("C : /search.se 호출 ");
			
			action = new SearchAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("\n 2. 가상주소 매핑");
		

		System.out.println("\n 3. 페이지 이동");
		if (forward != null) {
			if (forward.isRedirect()) {		//이동정보가 있을경우 페이지 이동
				//true
				response.sendRedirect(forward.getPath());
			} else {
				//false
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}

		System.out.println("\n 3. 페이지 이동");
	}
	
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	    System.out.println("MarketFrontController-doGet()");
	    doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MarketFrontController-doPost()");
		doProcess(request, response);
		
	}
}
