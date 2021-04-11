package com.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.me") //url 패턴(가상주소의 형태)
public class MemberFrontController extends HttpServlet {
	
	/* 컨트롤러 : 모델과 뷰의 연결지점 => 서블릿 */

	protected void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberFrontController-doProcess()");
		
		System.out.println("\n\n 1. 가상주소 계산");
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();

		String command = requestURI.substring(contextPath.length());
		System.out.println("command : " + command);
		System.out.println("\n 1. 가상주소 계산");

		
		System.out.println("\n 2. 가상주소 매핑");
		Action action = null;
		ActionIdCheck actionID = null;
		ActionForward forward = null;
		
		if(command.equals("/Join.me")){
			//Action 객체
			forward = new ActionForward();
				
			//("./이동 할 실제주소")
			forward.setPath("./member/join_Form.jsp");
					
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
		} else if(command.equals("/JoinAction.me")){
			//Action 객체
			action = new JoinAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/IdCheck.me")){
			actionID = new ActionIdCheckAction();
			try {
				actionID.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/NickCheck.me")){
			actionID = new NickCheckAction();
			try {
				actionID.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
/*************************** 여기서부터는 진우님 코드 ************************************/
		else if(command.equals("/MemberLogin.me")){
			System.out.println("C : /MemberLogin.me 호출 ");
			System.out.println("C : DB사용없이 view페이지로 이동");
			
			// 페이지 이동객체 생성
			forward = new ActionForward();
			forward.setPath("./member/loginForm.jsp");
			forward.setRedirect(false);			
		 } else if(command.equals("/MemberLoginAction.me")){
			System.out.println("C : /MemberLoginAction.me 호출");
			System.out.println("C : DB에 정보 처리 후 페이지 이동");
			
			// MemberLoginAction 객체 생성
			action = new MemberLoginAction();
			
			try {
				System.out.println("C : execute() 호출! ");
				forward = action.execute(request, response);
				System.out.println("C : 호출결과 forward 저장후 이동 ");
			} catch (Exception e) {
				e.printStackTrace();
			}		
		} else if(command.equals("/MemberLogout.me")){
			System.out.println("C : /MemberLogout.me 호출");
			System.out.println("C : 데이터처리 로직 사용후 이동");
			
			// MemberLogoutAction 객체 생성
			action = new MemberLogoutAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/MemberFindId.me")){
			System.out.println("C : /MemberFindId.me 호출");
			System.out.println("C : DB정보를 받아서 view 출력");
			
			forward = new ActionForward();
			forward.setPath("./member/findIdForm.jsp");
			forward.setRedirect(false);
		}
		else if(command.equals("/MemberFindIdAction.me")){
			System.out.println("C : /MemberFindIdAction.me 호출");
			System.out.println("C : DB정보를 받아서 view 출력");
			
			action = new MemberFindIdAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				}
			}
		else if(command.equals("/MemberFindPw.me")){
			System.out.println("C : /MemberFindPw.me 호출");
			System.out.println("C : DB정보를 받아서 view 출력");
			
			forward = new ActionForward();
			forward.setPath("./member/findPwForm.jsp");
			forward.setRedirect(false);
		}
		else if(command.equals("/MemberFindPwEmailAction.me")){
			System.out.println("C : /MemberFindPwEmailAction.me 호출");
			System.out.println("C : DB정보를 받아서 view 출력");
			
			action = new MemberFindPwEmailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
/*************************** 여기서부터는 윤정님 코드 ************************************/
		 else if(command.equals("/Update.me")){
			System.out.println("C : /Update.me 호출");
			System.out.println("C : DB결과를 가지고 view페이지 출력");
			
			// MemberUpdate 객체 생성
			action = new MemberUpdate();
		
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/MemberUpdateAction.me")){
				System.out.println("C : /MemberUpdateAction.me 호출");
				System.out.println("C : 전달정보를 DB에 저장 후 이동");
				
				// MemberUpdateAction 객체 생성
				action = new MemberUpdateAction();
				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
		} else if(command.equals("/Delete.me")){
			System.out.println("C : /Delete.me 호출");
			System.out.println("C : view 페이지로 이동");
			
			forward = new ActionForward();
			forward.setPath("./member/deleteMember.jsp");
			forward.setRedirect(false);
			
		} else if(command.equals("/MemberDeleteAction.me")){
			System.out.println("C : /MemberDeleteAction.me 호출");
			System.out.println("C : 전달받은 정보를 사용해서 DB에서 삭제 ");
			
			// MemberDeleteAction 객체 생성
			action = new MemberDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/PhoneCheck.me")){
			actionID = new smsAction();
			try {
				actionID.execute(request, response);
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
	    System.out.println("MemberFrontController-doGet()");
	    doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberFrontController-doPost()");
		doProcess(request, response);
		
	}
}
