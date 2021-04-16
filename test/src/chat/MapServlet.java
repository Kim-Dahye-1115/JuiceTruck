package chat;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/MapServlet")
public class MapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MapServlet doPost() 호출!!");
		
		request.setCharacterEncoding("utf8");
		
		HttpSession session = request.getSession();
		String fromID =  request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String mapImg = request.getParameter("mapImg")+request.getParameter("clickLatlng");
		
		if(fromID == null || fromID.equals("") // fromID,toID,chatContent 값이 널 값이거나, 비어있다면 오류 발생. 왜냐하면  보낸사람과 받는 사람이 모두 들어가 있어야 하기 때문.
				|| toID == null || toID.equals("") 
				|| mapImg == null || mapImg.equals("")){
			response.getWriter().write("0");
		} else if(fromID.equals(toID)) {
			response.getWriter().write("-1");
		} else {
			fromID = URLDecoder.decode(fromID,"UTF-8"); //사용자에게서 건너온 값을 UTF-8로 디코딩 해주는 코드 
			toID = URLDecoder.decode(toID,"UTF-8"); //사용자에게서 건너온 값을 UTF-8로 디코딩 해주는 코드 
			if(!URLDecoder.decode(fromID,"UTF-8").equals((String) session.getAttribute("nick"))) {
				response.getWriter().write("");
				return;
			}
			mapImg = URLDecoder.decode(mapImg,"UTF-8"); //사용자에게서 건너온 값을 UTF-8로 디코딩 해주는 코드 
			response.getWriter().write(new ChatDAO().submit(fromID, toID, mapImg) + ""); // submit이라는 함수를 실행해서, 실행된 결과를 클라이언트 측으로 반환 해 줄 수 있도록 해주는 코드.
			response.sendRedirect("./chat?toID="+URLEncoder.encode(toID, "UTF-8"));
		}
	}

}
