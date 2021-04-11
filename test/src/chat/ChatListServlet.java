package chat;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//데이터베이스에 등록된 메세지 데이터를 가져오는 기능 구현 페이지
@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ChatListServlet doPost() 호출!!");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String listType = request.getParameter("listType");
		
		if(fromID == null || fromID.equals("") 
			|| toID == null || toID.equals("") 
			|| listType == null || listType.equals("")) {
			response.getWriter().write("");
		} else if(listType.equals("ten")) response.getWriter().write(getTen(URLDecoder.decode(fromID,"UTF-8"), URLDecoder.decode(toID,"UTF-8"))); // 값이 비어있지 않은 상태에서 TEN이라는 이름으로 리스트 타입이 주어졌다면, getTen이라는 함수를 실행하고 출력할 수 있게 해주는 코드 
		else { 
			try {
				HttpSession session = request.getSession();
				if(!URLDecoder.decode(fromID,"UTF-8").equals((String) session.getAttribute("nick"))) {
					response.getWriter().write("");
					return;
				}
				response.getWriter().write(getID(URLDecoder.decode(fromID,"UTF-8"), URLDecoder.decode(toID,"UTF-8"), listType)); //특정한 채팅 아이디 값을 기준으로 대화 정보를 가져오는 코드
			} catch(Exception e) {
				response.getWriter().write("");
			}
		}
	}

	public String getTen(String fromID, String toID) { //31번째줄 getTen과 연결
		StringBuffer result = new StringBuffer(""); //스트링 버퍼를 이용해서 값을 반환할 수 있도록 하나의 인스턴스를 만들어 줄 수 있도록 해주는 코드 
		result.append("{\"result\":["); //이제부터 제이슨이라는 형태가 사용되는데, 제이슨은 배열을 표현하고 담을 수 있는 하나의 약속이라고 보면 됨.
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatDTO> chatList = chatDAO.getChatListByRecent(fromID, toID, 100); //클라이언트에게 제이슨 형태의 배열을 반환 할 수 있도록 해주는 코드
		if(chatList.size() == 0) return ""; //챗 리스트가 비어있는 상태라면 공백문자 반환
		for(int i = 0; i < chatList.size();i++) { //그렇지 않은 경우에는 실제로 대화 정보를 출력해줌
			result.append("[{\"value\": \"" + chatList.get(i).getFromID() + "\"},"); //현재 메세지를 이용해서 메세지 내용을 출력할수 있도록 해주는 코드 
			result.append("{\"value\": \"" + chatList.get(i).getToID() + "\"},"); //보낸 아이디 
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},"); //보낸 메세지 내용
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]"); //보낸 시각

			if(i != chatList.size() -1) result.append(","); //만약 마지막 원소가 아니라면 , 출력해주는 코드
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size()-1).getChatID() + "\"}");
		chatDAO.readChat(fromID, toID);
		return result.toString(); //만들어진 제이슨 형태의 문자열을 반환해주는 코드
	}
	
	public String getID(String fromID, String toID, String chatID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatDTO> chatList = chatDAO.getChatListByID(fromID, toID, chatID);
		if(chatList.size() == 0) return "";
		for(int i = 0; i < chatList.size();i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getFromID() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToID() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
			if(i != chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size()-1).getChatID() + "\"}");
		chatDAO.readChat(fromID, toID);
		return result.toString();
	}
	
}
