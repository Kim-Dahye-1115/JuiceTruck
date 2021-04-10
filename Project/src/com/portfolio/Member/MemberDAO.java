package com.portfolio.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.fabric.Response;

public class MemberDAO {
	/* member 테이블에 대한 DB 처리 */
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	/** DB Connection Method */
	private Connection getConn() throws Exception {
		Context initCTX = new InitialContext();
		
		//DB 연결정보 (Context.xml)
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/portfolioDB");
		conn = ds.getConnection();
		
		System.out.println(" DAO : DB connection success !! ");
		
		return conn;
	}
	/* DB Connection Method **/
	
	/** DB Clear Method */
	public void closeDB(){
		try {
			if(rs != null) rs.close();
			if(rs != null) pstmt.close();
			if(rs != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println(" DAO : DB Connection clear success !! ");
		
	}
	/* DB Clear Method **/
	
	/** ID & Password Check Method */
	public int idCheck(String id, String pw){
		int check = -1;
		try {
			conn = getConn();
			sql = "select pw from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){	//아이디가 존재
				if(pw.equals(rs.getString("pw"))){	// 비밀번호 존재
					check = 1;
				}else{	//비밀번호 오류
					check = 0;
				}
			}else{	//아이디가 존재 X
				check = -1;
			}
			
			System.out.println("DAO : id n password check method");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	/* ID & Password Check Method **/
	
	/** ID & Email Overlap Check Method */
	public int overlapCheck(String id, String email){
		int check = -1;
		try {
			conn = getConn();
			sql = "select id, email from member where id=? or email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()){	//아이디 또는 이메일 중복
				if(id.equals(rs.getString("id"))){	//아이디 중복
					check = -1;
				}else{	//이메일 중복
					check = 0;
				}
			}else{	//아이디와 이메일 중복 X
				check = 1;
			}
			
			System.out.println("DAO : id n email check method");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	/* ID & Email Overlap Check Method **/
	
	/** ID & Email & nick Overlap Check Method */
	public int overlapCheck(String id, String email, String nick){
		int check = -1;
		try {
			conn = getConn();
			sql = "select id, email, nick from member where id=? or email=? or nick=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			pstmt.setString(3, nick);
			
			rs = pstmt.executeQuery();
			if(rs.next()){	//아이디 또는 이메일 중복
				if(id.equals(rs.getString("id"))){	//아이디 중복
					check = -1;
				}else if(email.equals("email")){	//이메일 중복
					check = 0;
				}else{	//닉네임 중복
					check = -2;
				}
			}else{	//아이디와 이메일 중복 X
				check = 1;
			}
			
			System.out.println("DAO : id n email n nick check method");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	/* ID & Email & nick Overlap Check Method **/
	
	/** Update Overlap Check */
	public int updateOverlapCheck(String id, String email){
		int check = -1;
		try {
			conn = getConn();
			sql = "select email from member where id != ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(email.equals(rs.getString("email"))){	//이메일 중복
					check = 0;
				} else{	//이메일 중복 X
					check = 1;
				}
			} else{	//아이디 정보 X
				check = -1;
			}
			
			System.out.println("DAO : update overlap check : "+check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	
	public int updateOverlapCheck(String id, String email, String nick){
		int check = -1;
		
		try {
			conn = getConn();
			sql = "select email, nick from member where id != ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(email.equals(rs.getString("email"))){	//이메일 중복
					check = 0;
				} else if(nick.equals(rs.getString("nick"))){	//닉네임 중복
					check = -2;
				} else{	//이메일과 닉네임 중복 X
					check = 1;
				}
			} else{	//아이디 존재 X
				check = -1;
			}
			
			System.out.println("DAO : update overlap check : "+check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	/* Update Overlap Check **/
	
	/** Insert Member Method */
	public void insertMember(MemberBean mb){
		try {
			conn = getConn();
			sql = "insert into member "
					+"(id,pw,email,nick,name,postcode,address,detail_address,extra_address,profile_img) "
					+"values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			//필수 입력 사항
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPw());
			pstmt.setString(3, mb.getEmail());
			//선택 입력 사항
			pstmt.setString(4, mb.getNick());
			pstmt.setString(5, mb.getName());
			pstmt.setString(6, mb.getPostcode());
			pstmt.setString(7, mb.getAddress());
			pstmt.setString(8, mb.getDetailAddress());
			pstmt.setString(9, mb.getExtraAddress());
			pstmt.setString(10, mb.getProfile_img());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : insert member success ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Insert Member Method **/
	
	/** Get Member Method */
	public MemberBean getMember(String id){
		MemberBean mb = null;
		try {
			conn = getConn();
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				mb = new MemberBean();
				
				mb.setId(rs.getString("id"));
				mb.setPw(rs.getString("pw"));
				mb.setEmail(rs.getString("email"));
				mb.setNick(rs.getString("nick"));
				mb.setName(rs.getString("name"));
				mb.setPostcode(rs.getString("postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setDetailAddress(rs.getString("detail_address"));
				mb.setExtraAddress(rs.getString("extra_address"));
				mb.setProfile_img(rs.getString("profile_img"));
			}
			
			System.out.println("DAO : get member information !! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return mb;
	}
	/* Get Member Method **/
	
	/** Update Member Method */
	public int updateMember(MemberBean mb){
		int check = idCheck(mb.getId(), mb.getPw());
		//아이디와 비밀번호가 일치 할 때
		if(check == 1){
			try {
				conn = getConn();
				sql = "update member set email=?,nick=?,name=?,postcode=?,address=?,detail_address=?,extra_address=?,profile_img=? where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mb.getEmail());
				pstmt.setString(2, mb.getNick());
				pstmt.setString(3, mb.getName());
				pstmt.setString(4, mb.getPostcode());
				pstmt.setString(5, mb.getAddress());
				pstmt.setString(6, mb.getDetailAddress());
				pstmt.setString(7, mb.getExtraAddress());
				pstmt.setString(8, mb.getProfile_img());
				pstmt.setString(9, mb.getId());
				
				pstmt.executeUpdate();
				
				System.out.println("DAO : update member success ! "+mb);
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				closeDB();
			}
		}
		
		return check;
	}
	/* Update Member Method **/
	
	/** Delete Member Method */
	public int deleteMember(String id, String pw){
		int check = idCheck(id, pw);
		
		if(check == 1){
			try {
				conn = getConn();
				sql = "delete from member where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				
				pstmt.executeUpdate();
				
				System.out.println("DAO : delete member success ! ");
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				closeDB();
			}
		}
		
		return check;
	}
	/* Delete Member Method **/
}
