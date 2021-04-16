package com.market.db;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HeartDAO {
	
	// 필요한 레퍼런스 준비
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 디비연결 - 커넥션풀
	private Connection getCon() throws Exception {
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/JuiceDB");
		con = ds.getConnection();

		System.out.println("DAO : DB 디비 연결 성공! -> " + con);

		return con;
	}

	// 자원해제
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		System.out.println("DAO : DB 자원해제 !");
	}
	
	// 찜목록에 동일한 상품이 있을 경우 먼저 담겼던 상품정보 삭제
	// checkGoods(hb)
	public int checkGoods(HeartBean hb){
		int check = -1;
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql ="select * from heart "
					+ "where h_email=? and h_g_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, hb.getH_email());
			pstmt.setInt(2, hb.getH_g_num());
			
			// sql 실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				
				// 찜목록에 동일한 상품 존재 => 리스트에서 삭제
				check = 1;
				
				// sql & pstmt
				
				// 수정한 부분 - update -> delete로 변경
				sql = "delete from heart "
						+ "where h_email=? and h_g_num=?";
				// 수정한 부분 - update -> delete로 변경
				
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, hb.getH_email());
				pstmt.setInt(2, hb.getH_g_num());
				
				// sql 실행
				pstmt.executeUpdate();
				
				System.out.println("DAO : 동일상품 삭제완료!");
				
			}
			
			System.out.println("DAO : 찜목록 중복상품 삭제 완료!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return check;
	}
	// checkGoods(hb)
	
	// heartAdd(hb)
	public void heartAdd(HeartBean hb){
		int h_num = 0;
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "select max(h_num) from heart";
			pstmt = con.prepareStatement(sql);
			
			// sql 실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				h_num = rs.getInt(1)+1;
			}
			
			System.out.println("DAO : 찜목록 번호 "+h_num);
			
			// insert
			sql = "insert into heart values(?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, h_num);
			pstmt.setString(2, hb.getH_email());
			pstmt.setString(3, hb.getH_s_img());
			pstmt.setString(4, hb.getH_s_nick());
			pstmt.setInt(5, hb.getH_g_num());
			pstmt.setString(6, hb.getH_g_img());
			pstmt.setString(7, hb.getH_g_name());
			pstmt.setInt(8, hb.getH_g_price());
			pstmt.setString(9, hb.getH_g_location());
			
			// sql실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 찜목록 저장완료!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// heartAdd(hb)
	
	// getHeaertList(email)
	public List getHeartList(String email){
		
		List heartList = new ArrayList();
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "select * from heart where h_email=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, email);
			
			// sql 실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			while(rs.next()){
				HeartBean hb = new HeartBean();
				
				hb.setH_date(rs.getDate("h_date"));
				hb.setH_email(rs.getString("h_email"));
				hb.setH_g_img(rs.getString("h_g_img"));
				hb.setH_g_location(rs.getString("h_g_location"));
				hb.setH_g_name(rs.getString("h_g_name"));
				hb.setH_g_num(rs.getInt("h_g_num"));
				hb.setH_g_price(rs.getInt("h_g_price"));
				hb.setH_num(rs.getInt("h_num"));
				hb.setH_s_img(rs.getString("h_s_img"));
				hb.setH_s_nick(rs.getString("h_s_nick"));
				
				heartList.add(hb);

				System.out.println("DAO : 찜목록 저장 - "+heartList);
			
			}
			
			System.out.println("DAO : 찜목록 저장완료! ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return heartList;
	}
	// getHeartList(email)
	
	// getHeart(h_g_num)
	public HeartBean getHeart(String email, int h_g_num){
		HeartBean hb = null;
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "select * from heart where h_email=? and h_g_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, email);
			pstmt.setInt(2, h_g_num);
			
			// sql실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				hb = new HeartBean();
				
				hb.setH_date(rs.getDate("h_date"));
				hb.setH_email(rs.getString("h_email"));
				hb.setH_g_img(rs.getString("h_g_img"));
				hb.setH_g_location(rs.getString("h_g_location"));
				hb.setH_g_name(rs.getString("h_g_name"));
				hb.setH_g_num(rs.getInt("h_g_num"));
				hb.setH_g_price(rs.getInt("h_g_price"));
				hb.setH_num(rs.getInt("h_num"));
				hb.setH_s_img(rs.getString("h_s_img"));
				hb.setH_s_nick(rs.getString("h_s_nick"));	
			}
			
			System.out.println("DAO : 찜한 상품 저장 완료!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return hb;
	}
	// getHeart(h_g_num)
	
	// heartDelete(h_num)
	public void heartDelete(int h_num){
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "delete from heart where h_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, h_num);
			
			// sql 실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 찜목록 삭제 완료!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// heartDelete(h_num)
	
	// 좋아요 수를 1증가하는 메서드
	// updateHeart(num)
	public void updateHeartAdd(int num){
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "update goods set heart=heart+1 where g_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			// sql 실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 좋아요 1 증가");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// updateHeart(num)
	
	// 좋아요 수를 1감소하는 메서드
	// updateHeart(num)
		public void updateHeartMul(int num){
			try {
				// DB연결
				con = getCon();
				
				// sql & pstmt
				sql = "update goods set heart=heart-1 where g_num=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				// sql 실행
				pstmt.executeUpdate();
				
				System.out.println("DAO : 좋아요 1 감소");
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
		}
		// updateHeart(num)
}
