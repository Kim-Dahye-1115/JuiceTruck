package com.admin.db;

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

public class NoticeDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql ="";
	
	
	// 디비연결
	private Connection getCon() throws Exception{
		Context initCTX = new InitialContext();
		DataSource ds
			= (DataSource) initCTX.lookup("java:comp/env/jdbc/JuiceDB");
		con = ds.getConnection();
		
		System.out.println("DAO : 디비 연결 성공! -> "+con);
		
		return con;
	}
	
	// 자원해제
	public void closeDB(){
		try {
			if(rs != null){rs.close();}
			if(pstmt != null){pstmt.close();}
			if(con != null){con.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//insertNotice(nb)
	public void insertNotice(NoticeBean nb){
		int num=0;
		
		//글번호 계산
		try {
			//1.2.디비연결
			con = getCon();
			//3.sql 작성 & pstmt 객체
			sql="select max(n_num) from notice";
			pstmt = con.prepareStatement(sql);
			//4.sql실행
			rs = pstmt.executeQuery();
			//5.데이터처리
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("DAO : 글번호 생성 : "+num);
			
			//글쓰기
			//3.sql & pstmt
			sql="insert into notice (n_num, n_title, n_content, n_date, n_read_count)"
					+ " values (?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, nb.getN_title());
			pstmt.setString(3, nb.getN_content());
			pstmt.setInt(4, 0); //조회수 0 초기화
			//4.sql실행
			pstmt.executeUpdate();
			System.out.println("DAO : 공지사항 등록 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	//insertNotice(nb)

	//getNoticeList(pv)
	public List getNoticeList(pagingVO pv, String search){
		List noticeList = new ArrayList();
		
		try {
			//1.2.디비연결
			con = getCon();
			if(search.equals("all")){
				//3.sql & pstmt
				sql="select * from notice order by n_num desc "
						+ "limit ?,?";
				pstmt = con.prepareStatement(sql);
				//?
				pstmt.setInt(1, pv.getN_startNum()-1);
				pstmt.setInt(2, pv.getN_pageSize());
			}else{
				sql ="select * from notice"
						+ " where n_title like ? or n_content like ?"
						+ " order by n_num desc"
						+ " limit ?,?";
				pstmt = con.prepareStatement(sql);
				//?
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
				pstmt.setInt(3, pv.getN_startNum()-1);
				pstmt.setInt(4, pv.getN_pageSize());
			}
			//4.sql실행
			rs=pstmt.executeQuery();
			//5.데이터처리
			while (rs.next()) {
				//게시글 bean에 저장 -> list에 저장
				NoticeBean nb = new NoticeBean();
				nb.setN_content(rs.getString("n_content"));
				nb.setN_date(rs.getDate("n_date"));
				nb.setN_num(rs.getInt("n_num"));
				nb.setN_read_count(rs.getInt("n_read_count"));
				nb.setN_title(rs.getString("n_title"));
				
				noticeList.add(nb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return noticeList;
	}
	//getNoticeList(pv)
	
	//getNoticeCount();
	public int getNoticeCount(String search){
		 int cnt = 0;
		 
		 try {
			 // 1.2. 디비연결
			getCon();
			if(search.equals("all")){
				 // 3. sql(select) 생성 & pstmt 객체 
				sql = "select count(*) from notice" ;
				pstmt = con.prepareStatement(sql);				
			}else{
				sql = "select count(*) from notice "
						+ "where n_title like ? or n_content like ?";
				pstmt = con.prepareStatement(sql);		
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
			}
			// 4. sql 실행
			rs = pstmt.executeQuery();
			
			 // 5. 데이터 처리
			if(rs.next()){
				cnt = rs.getInt(1);  // 1번 인덱스
			}
			
			System.out.println("DAO : 글 개수 조회 -> "+cnt);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	
		 return cnt;
	}
	//getNoticeCount();
	
	//updateReadCount(num)
	public void updateReadCount(int num){
		try {
			//1.2.디비연결
			con = getCon();
			//3.sql & pstmt
			sql="update notice set n_read_count=n_read_count+1 where n_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4.sql실행
			pstmt.executeUpdate();
			System.out.println("DAO : 조회수 1증가 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	//updateReadCount(num)
	
	//getNoticeContent(num)
	public NoticeBean getNoticeContent(int num){
		NoticeBean noticeContent = null;
		
		try {
			//1.2.디비연결
			con = getCon();
			//3.sql & pstmt
			sql="select * from notice where n_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4.sql실행
			rs =pstmt.executeQuery();
			//5.데이터처리
			if(rs.next()){
				noticeContent = new NoticeBean();
				noticeContent.setN_content(rs.getString("n_content"));
				noticeContent.setN_date(rs.getDate("n_date"));
				noticeContent.setN_num(num);
				noticeContent.setN_read_count(rs.getInt("n_read_count"));
				noticeContent.setN_title(rs.getString("n_title"));
				
				System.out.println("DAO : notice 글 저장 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return noticeContent;
	}
	//getNoticeContent(num)
	
	//deleteNotice(num)
	public void deleteNotice(int num){
		try {
			//1.2.디비연결
			con=getCon();
			//3.sql & pstmt
			sql="delete from notice where n_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4.sql실행
			pstmt.executeUpdate();
			System.out.println("DAO : 공지사항 글 삭제 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	//deleteNotice(num)
	
}
