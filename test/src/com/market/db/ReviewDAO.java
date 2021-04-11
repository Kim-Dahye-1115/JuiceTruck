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

import com.admin.action.pagingVO;

public class ReviewDAO {
	
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
	
	// insertReview(rb)
	public void insertReview(ReviewBean rb){
		int num = 0;
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "select max(re_num) from review";
			pstmt = con.prepareStatement(sql);
			
			// sql 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("DAO : 리뷰번호 생성 - "+num);
			
			// 상품등록
			sql ="insert into review(re_num,s_nick,w_nick,file,re_content,re_date,re_star) "
					+ "values(?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, rb.getS_nick());
			pstmt.setString(3, rb.getW_nick());
			pstmt.setString(4, rb.getFile());
			pstmt.setString(5, rb.getRe_content());
			pstmt.setInt(6, rb.getRe_star());
			
			// sql실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 리뷰저장 완료");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// insertReview(rb)
	
	// getReview(num)
	public ReviewBean getReview(int num){
		ReviewBean rb = null;
		System.out.println(num);
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "select * from review where re_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			// sql 실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				rb = new ReviewBean();
				
				rb.setRe_num(rs.getInt("re_num"));
				rb.setS_nick(rs.getString("s_nick"));
				rb.setW_nick(rs.getString("w_nick"));
				rb.setFile(rs.getString("file"));
				rb.setRe_content(rs.getString("re_content"));
				rb.setRe_date(rs.getDate("re_date"));
				rb.setRe_star(rs.getInt("re_star"));
			}
			
			System.out.println("DAO : 리뷰정보 저장 완료"+rb);
			
		} catch (Exception e) {
			System.out.println("DAO : 리뷰정보 저장 실패!!!!");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return rb;
	}
	// getReview(num)
	
	// getReviewCount()
		public int getReviewCount(String s_nick, String w_nick){
			int cnt = 0;
			
			try {
				// 1,2. 디비연결
				con = getCon();
				// 3. sql 구문(select) & pstmt 객체
				if(s_nick == null){
					sql = "select count(*) from review where w_nick=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, w_nick);
					
					System.out.println("DAO : s_nick 없음.");
				}else{
					sql = "select count(*) from review where s_nick=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, s_nick);
					
					System.out.println("DAO : s_nick 있음.");
				}
				// 4. sql 실행
				rs = pstmt.executeQuery();
				// 5. 데이터 처리
				if(rs.next()){
					//rs.getInt("count(*)");
					cnt = rs.getInt(1);
				}
				
				System.out.println("DAO : 리뷰 개수 조회 -> "+cnt);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return cnt;
		}
		// getBoardCount()
	
	// getReviewList()
		public List<ReviewBean> getReviewList(String s_nick, String w_nick, pagingVO pv){
			List<ReviewBean> reviewList = new ArrayList<ReviewBean>();
			
			try {
				// 1.2. 디비연결
				con = getCon();
				// 3. sql 작성 & pstmt생성 (select)
				// limit 시작행-1, 개수
				//System.out.println("DAO : s_nick "+s_nick);
				
				// if문 추가변경
				if(s_nick != null){
					sql="select * from review where s_nick=? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, s_nick);
					pstmt.setInt(2, pv.getN_startNum()-1);
					pstmt.setInt(3, pv.getN_pageSize());
				
					System.out.println("s_nick 있음!");
				}else if(s_nick == null){
					sql="select * from review where w_nick=? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, w_nick);
					pstmt.setInt(2, pv.getN_startNum()-1);
					pstmt.setInt(3, pv.getN_pageSize());
					
					System.out.println("s_nick 없음!");
				}				
				// if문 추가변경 - 이 밑에는 그대로
				
				// 4. sql 실행
				rs = pstmt.executeQuery();
				
				// 5. 데이터 처리 
				while(rs.next()){
					ReviewBean rb = new ReviewBean();
					
					rb.setFile(rs.getString("file"));
					rb.setRe_content(rs.getString("re_content"));
					rb.setRe_date(rs.getDate("re_date"));
					rb.setRe_num(rs.getInt("re_num"));
					rb.setRe_star(rs.getInt("re_star"));
					rb.setS_nick(rs.getString("s_nick"));
					rb.setW_nick(rs.getString("w_nick"));
					
					reviewList.add(rb);
					
					System.out.println("DAO : reviewList - "+reviewList);
					
				}// while
				
				System.out.println("DAO : 리뷰목록 저장완료! ");
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return reviewList;
		}
	// getReviewList()
	
	// updateReview(rb)
	public void updateReview(ReviewBean rb){
		
		try {
			
			// 디비연결
			con = getCon();
			
			if(rb.getFile() == null){
				sql = "update review set s_nick=?, w_nick=?, "
						+ "re_content=?, re_star=? "
						+ "where re_num=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, rb.getS_nick());
				pstmt.setString(2, rb.getW_nick());
				pstmt.setString(4, rb.getRe_content());
				pstmt.setInt(5, rb.getRe_star());
				pstmt.setInt(6, rb.getRe_num());
			}else{
				// sql & pstmt
				sql = "update review set s_nick=?, w_nick=?, "
						+ "file=?, re_content=?, re_star=? "
						+ "where re_num=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, rb.getS_nick());
				pstmt.setString(2, rb.getW_nick());
				pstmt.setString(3, rb.getFile());
				pstmt.setString(4, rb.getRe_content());
				pstmt.setInt(5, rb.getRe_star());
				pstmt.setInt(6, rb.getRe_num());
			}
			
			// sql 실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 리뷰 수정 완료!");
			
		} catch (Exception e) {
			System.out.println("DAO : 리뷰 수정 실패!");
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// updateReview(rb)
	
	// deleteReview(re_num)
	public void deleteReview(int re_num){
		
		try {
			// DB연결
			con = getCon();
			
			// sql & pstmt
			sql = "delete from review where re_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, re_num);
			
			// sql 실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 리뷰 삭제 완료");
			
		} catch (Exception e) {
			System.out.println("DAO : 리뷰 삭제 실패!!");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	// deleteReview(re_num)
	
}
