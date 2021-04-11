package com.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	/* DB 테이블의 모든 처리
	 * 변수 : con(DB 커넥션) | sql(DB sql 구문)
	 * 	  | pstmt(sql구문을 연결하기위한 객체) | rs(sql 구문의 리턴 값)
	 * */
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	//디비연결 - 커넥션풀 
	private Connection getCon() throws Exception {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/JuiceDB");
		con = ds.getConnection();

		System.out.println("DAO : DB 디비 연결 성공! -> " + con);

		return con;
	}

	//자원해제 
	public void closeDB() {
		try {
			if (rs != null)	rs.close();
			if (pstmt != null) pstmt.close();
			if (con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("DAO : DB 자원해제 !");
	}
	
	/************** DB 처리에 대한 Method들 **************/
	// joinMember(mb)
	public void joinMember(MemberBean mb){
		int user_num = 0;
		
		try {
			//1.2.
			con = getCon();
			// 3.sql생성 & pstmt객체
			// 상품번호 계산 (select)
			sql = "select max(user_num) from users";
			pstmt = con.prepareStatement(sql);
			
			// 4.sql 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				user_num = rs.getInt(1)+1;
			}
			System.out.println("DAO : 번호 생성 - "+user_num);
			
			
			//3.
			sql ="insert into users (user_num,email,pass,nick,zip,addr,addr2,name,phone,user_img,join_date)"
					+ " values(?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, user_num);
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getPass());
			pstmt.setString(4, mb.getNick());
			pstmt.setString(5, mb.getZip());
			pstmt.setString(6, mb.getAddr());
			pstmt.setString(7, mb.getAddr2());
			pstmt.setString(8, mb.getName());
			pstmt.setString(9, mb.getPhone());
			pstmt.setString(10, mb.getUser_img());
			//pstmt.setString(11, mb.getPlatform_type());
			//pstmt.setString(12, mb.getAccess_token());
			
			//4. 
			pstmt.executeUpdate();
			
			System.out.println("가입 완료");
			
		} catch (Exception e) {
			System.out.println("가입 실패");
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// joinMember(mb)
	
	
	// idCheck(email)
	public int confirm(String email) {
		int result = 0;
		
		if(email == ""){
			result = -1;
		}else{
			//있으면 1 없으면 0 
			try {
				con = getCon();
				sql="select * from users where email = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				//sql실행
				rs =pstmt.executeQuery();
				if(rs.next() == true) {
					result=1;
				}
				else result = 0;
			}catch(SQLException e) {
				System.err.println(" * Error 이유 : Database 구문 오류, "+e.getMessage());			
			}catch(Exception e) {
				System.err.println(" * Error 이유 : "+e.getMessage());
			}finally {
				closeDB();
			}
		}
		
		return result;
	}
	// idCheck(email)
		
	// nickCheck(nick)
	public int nickCheck(String nick) {
		int result = 0;
		
		if(nick == ""){
			result = -1;
		}else{
			//있으면 1 없으면 0 
			System.out.println(nick);
			try {
				con = getCon();
				sql="select * from users where nick = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, nick);
				
				//sql실행
				rs =pstmt.executeQuery();
				if(rs.next()) {
					result=1;
				}
				else result = 0;
				
				System.out.println(result);
				
			}catch(SQLException e) {
				System.err.println(" * Error 이유 : Database 구문 오류, "+e.getMessage());			
			}catch(Exception e) {
				System.err.println(" * Error 이유 : "+e.getMessage());
			}finally {
				closeDB();
			}
		}
		
		return result;
	}	
	// nickCheck(nick)
	
	// loginCheck(mb)
	public int loginCheck(MemberBean mb){
		int result = -1;
					
		try {
			// 1.2. 디비연결
			con = getCon();
			
			// 3. sql 생성 & pstmt 객체
			sql = "select pass from users where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
						
			// 4. sql 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리 
			if(rs.next()){
				// 회원
				if(mb.getPass().equals(rs.getString("pass"))){
					// 본인
					result = 1;
				}else{
					// 본인이지만 비밀번호 오류
					result = 0;
				}
			}else{
				// 비회원
				result = -1;
		}
						
		System.out.println("DAO : 로그인 체크 >> "+result);
						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
					
		return result;
	}
	// loginCheck(mb)
	
	//getMember(email)
	public MemberBean getMember(String email){
		MemberBean mb = null;
	
		try {
			//1.2. 디비연결
			con = getCon();
			//3. sql 작성 & pstmt생성
			sql ="select * from users where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			//4. sql 실행
			rs = pstmt.executeQuery();
			//5. 데이터 처리
			if(rs.next()){
				mb = new MemberBean();
				
				// DB -> MemberBean 저장
				mb.setEmail(rs.getString("email"));
				mb.setNick(rs.getString("nick"));
				mb.setPhone(rs.getString("phone"));
				mb.setName(rs.getString("name"));
				mb.setPass(rs.getString("pass"));
				mb.setZip(rs.getString("zip"));
				mb.setAddr(rs.getString("addr"));
				mb.setAddr2(rs.getString("addr2"));
				mb.setUser_img(rs.getString("user_img"));
			}
			
			System.out.println("DAO : 회원 정보 저장 완료  "+mb);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return mb;
	}
	//getMember(email)

	//updateMember(mb)
	public int updateMember(MemberBean mb){
		int check = -1;
		
		try {
			//1.2. 디비연결
			con = getCon();
			
			//3. sql 작성 & pstmt 객체 실행
			sql = "select pass from users where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			
			//4. sql 실행
			rs = pstmt.executeQuery();
			//5. 데이터 처리
			if(rs.next()){
				if(mb.getPass().equals(rs.getString("pass"))){
					if(mb.getUser_img() == null){
						sql ="update users set "
								+ "name=?,nick=?,zip=?,addr=?,addr2=?, phone=? where email=?";
						pstmt = con.prepareStatement(sql);
						
						
						pstmt.setString(1, mb.getName());
						pstmt.setString(2, mb.getNick());
						pstmt.setString(3, mb.getZip());
						pstmt.setString(4, mb.getAddr());
						pstmt.setString(5, mb.getAddr2());
						pstmt.setString(6, mb.getPhone());
						pstmt.setString(7, mb.getEmail());
					} else {
						//3. sql 작성 & pstmt 생성
						sql ="update users set "
								+ "user_img=?,name=?,nick=?,zip=?,addr=?,addr2=?, phone=? where email=?";
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, mb.getUser_img());
						pstmt.setString(2, mb.getName());
						pstmt.setString(3, mb.getNick());
						pstmt.setString(4, mb.getZip());
						pstmt.setString(5, mb.getAddr());
						pstmt.setString(6, mb.getAddr2());
						pstmt.setString(7, mb.getPhone());
						pstmt.setString(8, mb.getEmail());
					}

					//4. sql 실행
				check = pstmt.executeUpdate();
						//check = 1;
				}else{
					    check = 0;
				}
			}else{
					check = -1;
			}
				
			System.out.println("DAO : 회원 정보 수정 완료 >> "+check);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
			
		return check;
	}
	//updateMember(mb)
	
	//deleteMember(mb)
	public int deleteMember(MemberBean mb){
		int check =-1;
		
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3.sql 작성 & pstmt 객체 생성
			sql = "select pass from users where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			
			// 4.sql 실행
			rs = pstmt.executeQuery();
			// 5.데이터 처리
			if(rs.next()){
				if(mb.getPass().equals(rs.getString("pass"))){
					// 3. sql 작성
					sql = "delete from users where email=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, mb.getEmail());
					// 4. sql 실행
					pstmt.executeUpdate();
					
					check = 1;
				}else{
					check = 0;
				}
			}else{
				check = -1;
			}

			System.out.println("DAO : 회원 탈퇴 완료 >> "+check);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return check;
	}
	//deleteMember(mb)
	
	// pnum_check(phone)
	public int pnum_check(String phone) {
		int result = 0;
		
		if(phone == ""){
			result = -1;
		}else{
			//있으면 1 없으면 0 
			System.out.println(phone);
			try {
				con = getCon();
				sql="select * from users where phone = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, phone);
				
				//sql실행
				rs =pstmt.executeQuery();
				if(rs.next()) {
					result=1;
				}
				else result = 0;
				
				System.out.println(result);
				
			}catch(SQLException e) {
				System.err.println(" * Error 이유 : Database 구문 오류, "+e.getMessage());			
			}catch(Exception e) {
				System.err.println(" * Error 이유 : "+e.getMessage());
			}finally {
				closeDB();
			}
		}
			
		return result;
	}	
	// pnum_check(phone)
	
public String getProfile(String nick) {
		
		try {
			con = getCon();
			sql = "select user_img from users where nick = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//사용자 
				if (rs.getString("user_img").equals("")) {
					return "http://localhost:8088/test/images/icon.png";
				} else {
					return "http://localhost:8088/test/upload/" + rs.getString("user_img");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return "http://localhost:8088/test/images/icon.png";
	}

//findEmail
		public String findemail(String name, String phone) {
			System.out.println("DAO : 이름 >> "+name+" | 전화번호 >> "+phone);
			String email = null;
			try {
				sql = "select email from users where name=? and phone=?";
				con = getCon();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					email = rs.getString("email");
				} else {
					email = "회원정보를 확인해주세요";
				}
				System.out.println("DAO : 아이디 찾기 완료!! >> "+email);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return email;
		}
		
		//findpass
		public String findpass(String email, String phone) {
			System.out.println("DAO : 이름 >> "+email+" | 전화번호 >> "+phone);
			String pass = null;
			try {
				sql = "select pass from users where email=? and phone=?";
				con = getCon();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.setString(2, phone);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					pass = rs.getString("pass");
				} else {
					pass = "회원정보를 확인해주세요";
				}
				System.out.println("DAO : 비밀번호 찾기 완료!! >> "+pass);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return pass;
		}
}


