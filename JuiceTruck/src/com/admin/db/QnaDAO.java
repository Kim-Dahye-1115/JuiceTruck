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

public class QnaDAO {

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
		System.out.println("DAO : 자원해제 !");
	}
	
	//insertQna()
	public void insertQna(QnaBean qb){
		int num = 0;
		String nick="a";
		
		try {
			//글번호 계산
			//1.2.디비연결
			con = getCon();
			//3.sql & pstmt
			sql = "select max(q_num) from qna";
			pstmt = con.prepareStatement(sql);
			//4.sql 실행
			rs = pstmt.executeQuery();
			//5.데이터처리
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("DAO : 글번호 생성 : "+num);

			
			//nick 조회
			//3.4.sql&pstmt
			sql = "select nick from users where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qb.getEmail());
			
			//4.sql실행
			rs = pstmt.executeQuery();
			//5.데이터처리
			if(rs.next()){
				nick = rs.getString("nick");
			}
			
			
			//글등록
			//3.sql & pstmt
			sql="insert into qna (q_num, email, q_subject, q_content, files, q_date, q_category, q_re_ref, nick) values (?,?,?,?,?,now(),?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, qb.getEmail());
			pstmt.setString(3, qb.getQ_subject());
			pstmt.setString(4, qb.getQ_content());
			pstmt.setString(5, qb.getFiles());
			pstmt.setString(6, qb.getQ_category());
			pstmt.setInt(7, num);
			pstmt.setString(8, nick);
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 문의 등록 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	//insertQna()
	
	//getQnaList(email , pv)
	public List getQnaList(String email, pagingVO pv){
		List qnaList = new ArrayList();
		
		try {
			//1.2.디비연결
			con = getCon();
			
			//3.sql & pstmt
			if(email.equals("juicetruck.ad@gmail.com")){	//관리자 일때
				sql = "select * from qna order by q_re_ref desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pv.getN_startNum()-1);
				pstmt.setInt(2, pv.getN_pageSize());
			} else{	//일반회원 일때
				sql = "select * from qna where q_re_ref in "
						+ "(select q_re_ref from qna where email=?) "
						+ "order by q_re_ref desc, q_num asc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.setInt(2, pv.getN_startNum()-1);
				pstmt.setInt(3, pv.getN_pageSize());
			}
			
			//4.sql실행
			rs = pstmt.executeQuery();
			//5.데이터처리
			while(rs.next()){
				//글 정보 QnaBean에 저장
				QnaBean qb = new QnaBean();
				qb.setEmail(rs.getString("email"));
				qb.setFiles(rs.getString("files"));
				qb.setQ_category(rs.getString("q_category"));
				qb.setQ_content(rs.getString("q_content"));
				qb.setQ_date(rs.getDate("q_date"));
				qb.setQ_num(rs.getInt("q_num"));
				qb.setQ_subject(rs.getString("q_subject"));
				qb.setQ_re_ref(rs.getInt("q_re_ref"));
				qb.setNick((rs.getString("nick")));
				
				qnaList.add(qb);
			}
			
			System.out.println("DAO : 문의 리스트 저장완료 qnaList >>> "+qnaList);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return qnaList;
	}
	//getQnaList(email)
	
	//getQnaCount(email)
		public int getQnaCount(String email){
			 int cnt = 0;
			 
			 try {
				 // 1.2. 디비연결
				getCon();
				 // 3. sql(select) 생성 & pstmt 객체 
				if(email.equals("juicetruck.ad@gmail.com")){	//관리자 일때
					sql = "select count(*) from qna";
					pstmt = con.prepareStatement(sql);
				} else{	//일반회원 일때
					sql = "select count(*) from qna where q_re_ref "
							+ "in (select q_re_ref from qna where email=?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, email);
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
		//getQnaCount(email)
		
	//getQnaContent(num)
	public QnaBean getQnaContent(int num){
		QnaBean qnaContent = null;
			
			try {
				//1.2.디비연결
				con = getCon();
				//3.sql & pstmt
				sql="select * from qna where q_num=?"; //있을떄
				//sql="select * from qna q join juice.users u on (q.email = u.email) where q_num=?";  nick 없을떄
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				//4.sql실행
				rs = pstmt.executeQuery();
				if(rs.next()){
					//bean객체에 저장
					qnaContent = new QnaBean();
					qnaContent.setEmail(rs.getString("email"));
					qnaContent.setFiles(rs.getString("files"));
					qnaContent.setQ_category(rs.getString("q_category"));
					qnaContent.setQ_content(rs.getString("q_content"));
					qnaContent.setQ_date(rs.getDate("q_date"));
					qnaContent.setQ_num(rs.getInt("q_num"));
					qnaContent.setQ_subject(rs.getString("q_subject"));
					qnaContent.setQ_re_ref(rs.getInt("q_re_ref"));
					qnaContent.setNick(rs.getString("nick"));
				}
				System.out.println(qnaContent);
				System.out.println("DAO : Content 저장 완료");
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
		
		return  qnaContent;
		
	}
	//getQnaContent(num)
	
	
	//adminReplyInsertQna(qb)
	public void adminReplyInsertQna(QnaBean qb){
		int q_num = 0;
		String nick=null;
		
		System.out.println("DAO : QnA Bean >> "+qb);
		
		try {
			//글번호 계산
			//1.2.디비연결
			con = getCon();
			//3.sql & pstmt
			sql = "select max(q_num) from qna";
			pstmt = con.prepareStatement(sql);
			//4.sql 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				q_num = rs.getInt(1)+1;
			}
			System.out.println("DAO : 글번호 생성 : "+q_num);
			
			
			//nick 조회
			//3.4.sql&pstmt
			sql = "select nick from users where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qb.getEmail());
			
			//4.sql실행
			rs = pstmt.executeQuery();
			//5.데이터처리
			if(rs.next()){
				nick=rs.getString("nick");
			}
			
			
			//글등록
			//3.sql & pstmt
			sql = "insert into qna (q_num, email, q_subject, q_content, files, q_date, q_category, q_re_ref, nick) values (?,?,?,?,?,now(),?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, q_num);
			pstmt.setString(2, qb.getEmail());
			pstmt.setString(3, qb.getQ_subject());
			pstmt.setString(4, qb.getQ_content());
			pstmt.setString(5, qb.getFiles());
			pstmt.setString(6, qb.getQ_category());
			pstmt.setInt(7, qb.getQ_num());
			pstmt.setString(8, nick);
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : (관리자)답변 등록 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	//adminReplyInsertQna(qb)
}
