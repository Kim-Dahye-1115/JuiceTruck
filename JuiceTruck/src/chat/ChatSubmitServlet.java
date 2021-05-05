package chat;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // UTF-8 인코딩
		response.setContentType("text/html;charset=UTF-8"); 
		String fromID = request.getParameter("fromID"); // 사용자가 보낸 fromID라는 파라미터에 담긴 값을 넣어주는 코드
		String toID = request.getParameter("toID"); // // 사용자가 보낸 toID라는 파라미터에 담긴 값을 넣어주는 코드
		String chatContent = request.getParameter("chatContent"); 
		
		if(fromID == null || fromID.equals("") // fromID,toID,chatContent 값이 널 값이거나, 비어있다면 오류 발생. 왜냐하면  보낸사람과 받는 사람이 모두 들어가 있어야 하기 때문.
			|| toID == null || toID.equals("") 
			|| chatContent == null || chatContent.equals("")) {
			response.getWriter().write("0"); // 값이 비어있는 경우가 있다면 0이라는 문자를 클라이언트에게 반환해주는 코드 
		} else if(fromID.equals(toID)) {
			response.getWriter().write("-1");
		} else {
			fromID = URLDecoder.decode(fromID,"UTF-8"); //사용자에게서 건너온 값을 UTF-8로 디코딩 해주는 코드 
			toID = URLDecoder.decode(toID,"UTF-8"); //사용자에게서 건너온 값을 UTF-8로 디코딩 해주는 코드 
			HttpSession session = request.getSession();
			if(!URLDecoder.decode(fromID,"UTF-8").equals((String) session.getAttribute("nick"))) {
				response.getWriter().write("");
				return;
			}
			chatContent = URLDecoder.decode(chatContent,"UTF-8"); //사용자에게서 건너온 값을 UTF-8로 디코딩 해주는 코드 
			response.getWriter().write(new ChatDAO().submit(fromID, toID, chatContent) + ""); // submit이라는 함수를 실행해서, 실행된 결과를 클라이언트 측으로 반환 해 줄 수 있도록 해주는 코드. 
		}
	}

}
