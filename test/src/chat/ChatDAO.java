package chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChatDAO {
	DataSource ds = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 데이터베이스에 접근하는 코드
	public ChatDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/JuiceDB");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

	public void closechatDB() {
		try {
			if (rs != null) { rs.close(); }
			if (pstmt != null) { pstmt.close();	}
			if (con != null) { con.close();	}
		} catch (Exception e) {	e.printStackTrace(); }
	}
	
	//역할을 수행하는 함수 
	public ArrayList<ChatDTO> getChatListByID(String fromID, String toID, String chatID) {// getChatListByID : 특정한 아이디에 따라서 채팅 내역을 가져오는 코드
		ArrayList<ChatDTO> chatList = null; //하나하나의 메세지를 리스트에 담아서 보관하는 코드
		sql = "select * from chat where((fromID=? and toID=?) or (fromID =? and toID=?)) and chatID > ? order by chatTime"; //보낸 사람이거나 받은 사람이거나 상관 없이 모두 가져오는 코드 
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>(); // 챗 리스트 초기화 코드
			while(rs.next()) { //결과가 나올때마다 실제 리스트에 담아 주는 코드
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")); // 스크립트 공격을 방어하기 위해 특수문자 치환 
				chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType ="오전";
				if(chatTime >= 12) { //12보다 크다면  오후로 변경
					timeType ="오후"; 
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16) + "");
				chatList.add(chat);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return chatList;
	}
	
	public ArrayList<ChatDTO> getChatListByRecent(String fromID, String toID, int number) {
		ArrayList<ChatDTO> chatList = null;
		sql = "select * from chat where((fromID=? and toID=?) or (fromID =? and toID=?)) and chatID > (select max(chatID) - ? from chat where (fromID =? and toID = ?)) order by chatTime";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, number);
			pstmt.setString(6, fromID);
			pstmt.setString(7, toID);
			pstmt.setString(8, toID);
			pstmt.setString(9, fromID);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime >= 12) {
					timeType ="오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16) + "");
				chatList.add(chat);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return chatList;
	}
	
	
	//전송기능이 있는 코드
	public int submit(String fromID, String toID, String chatContent) {
		sql = "insert into chat values(null,?,?,?,now(),0)"; 
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, chatContent);
			return pstmt.executeUpdate(); //실행한 결과 반환 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return -1; //리스트 반환, 데이터베이스 오류 
	}
	
	public ArrayList<ChatDTO> getBox(String userID) {
		ArrayList<ChatDTO> chatList = null;
		sql = " SELECT * FROM CHAT WHERE chatID IN (SELECT (chatID) FROM chat WHERE toID = ? OR fromID = ? GROUP BY fromID, toID);";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType ="오전";
				if(chatTime >= 12) {
					timeType ="오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14,16) + "");
				chatList.add(chat);
			}
			for(int i = 0; i < chatList.size(); i++) {
				ChatDTO x = chatList.get(i);
				for(int j = 0; j < chatList.size(); j++) {
					ChatDTO y = chatList.get(j);
					if(x.getFromID().equals(y.getToID()) && x.getToID().equals(y.getFromID())) {
						if(x.getChatID() < y.getChatID()) {
							chatList.remove(x);
							i--;
							break;
						} else {
							chatList.remove(y);
							j--;
						}
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return chatList;
	}
	
	public int readChat(String fromID, String toID) {
		sql = "update chat set chatRead = 1 where (fromID = ? and toID = ?)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return -1;
	}
	
	public int getAllUnreadChat(String userID) {
		sql = "select count(chatID) from chat where toID =? and chatRead = 0";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("count(chatID)");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return -1;
	}
	
	public int getUnreadChat(String fromID, String toID) {
		sql = "select count(chatID) from chat where fromID =? and toID = ? and chatRead = 0";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(1, toID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("count(chatID)");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closechatDB();
		}
		return -1;
	}
}
