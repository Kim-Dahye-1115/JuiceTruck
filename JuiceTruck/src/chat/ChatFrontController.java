package chat;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/map","/chat","/box","/index","/find"}) //url 패턴(가상주소의 형태)
public class ChatFrontController extends HttpServlet {
	
	/* 컨트롤러 : 모델과 뷰의 연결지점 => 서블릿 */

	protected void doProcess(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ChatFrontController-doProcess()");
		
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
		if(command.equals("/map")){
			//Action 객체
			forward = new ActionForward();
			
			//("./이동 할 실제주소")
			forward.setPath("./chatting/mapAddr.jsp");
			
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
		} else if(command.equals("/chat")){
			//Action 객체
			forward = new ActionForward();
			
			//("./이동 할 실제주소")
			forward.setPath("./chatting/chat.jsp");
			
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
		}  else if(command.equals("/box")){
			//Action 객체
			forward = new ActionForward();
			
			//("./이동 할 실제주소")
			forward.setPath("./chatting/box.jsp");
			
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
		}   else if(command.equals("/index")){
			//Action 객체
			forward = new ActionForward();
			
			//("./이동 할 실제주소")
			forward.setPath("./chatting/index.jsp");
			
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
		} else if(command.equals("/find")){
			//Action 객체
			forward = new ActionForward();
			
			//("./이동 할 실제주소")
			forward.setPath("./chatting/find.jsp");
			
			// false - forward로 이동(주소 변경x, 화면 변경 O)
			forward.setRedirect(false);
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
	    System.out.println("ChatFrontController-doGet()");
	    doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ChatFrontController-doPost()");
		doProcess(request, response);
		
	}
}
