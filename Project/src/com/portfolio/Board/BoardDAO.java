package com.portfolio.Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	/* board ���̺� ���� DB ó�� */
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	/** DB Connection Method */
	private Connection getConn() throws Exception {
		Context initCTX = new InitialContext();
		
		//DB �������� (Context.xml)
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
	
	/** Insert Board Method */
	public void insertBoard(BoardBean bb) {
		int num = 0;
		try {
			conn = getConn();
			sql = "select max(num) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			System.out.println("DAO : �� ��ȣ 1 ���� ! >> "+num);
			
			sql = "insert into board "
					+"(num,id,pw,title,content,date,readcount,re_ref,re_lev,re_seq,file) "
					+"values (?,?,?,?,?,now(),?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getId());
			pstmt.setString(3, bb.getPw());
			pstmt.setString(4, bb.getTitle());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);		//��ȸ�� �׻� 0���� �ʱ�ȭ
			pstmt.setInt(7, num);	//re_ref �亯 �� �׷� == �Ϲݱ� �۹�ȣ ����
			pstmt.setInt(8, 0);		//re_lev �亯�� �鿩���� -> �Ϲݱ� �鿩���� ����
			pstmt.setInt(9, 0);		//re_seq �亯�� ���� -> �Ϲݱ��� ���� ������ ��ġ
			pstmt.setString(10, bb.getFile());	//
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : insert board success ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Insert Board Method **/
	
	/** Get Board List Count Method */
	public int getBoardListCount(){
		int count = 0;
		try {
			conn = getConn();
			sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
			System.out.println("DAO : list count >> "+count);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return count;
	}
	/* Get Board List Count Method **/
	
	/** Get Notice List Method */
	public ArrayList getBoardList(int startRow, int pageSize){
		ArrayList list = new ArrayList();
		BoardBean bb = null;
		int i = 0;
		
		try {
			conn = getConn();
			sql = "select * from board "
					+"order by re_ref desc, re_seq asc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setTitle(rs.getString("title"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setFile(rs.getString("file"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				
				list.add(i, bb);
				i++;
			}
			System.out.println("DAO : board list >> "+list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return list;
	}
	/* Get Board List Method **/
	
	/** Update Readcount Method */
	public void updateReadcount(int num){
		try {
			conn = getConn();
			sql = "update board set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			System.out.println("DAO : "+num+" readcount + 1 ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Update Readcount Method **/
	
	/** Get Board Method (detail) */
	public BoardBean getBoard(int num){
		BoardBean bb = null;
		try {
			conn = getConn();
			sql = "select * from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setTitle(rs.getString("title"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setFile(rs.getString("file"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
			}
			System.out.println("DAO : get board >> "+bb);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return bb;
	}
	/* Get Board Method (detail) **/
	
	/** Board Password Check Method */
	public int boardPWcheck(int num, String id, String pw){
		int check = -1;
		try {
			conn = getConn();
			sql = "select id,pw from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){ //�� ����
				if(id.equals(rs.getString("id"))){	//���̵� ��ġ
					if(pw.equals(rs.getString("pw"))){	//��й�ȣ ��ġ
						check = 1;
					} else {	//��й�ȣ ����ġ
						check = 0;
					}
				} else {	//���̵� ����ġ
					check = -1;
				}
			} else{	//���� �������� ���� ��
				check = -1;
			}
			
			System.out.println("DAO : board id & password check >> "+check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return check;
	}
	/* Board Password Check Method **/
	
	/** Update Board Method */
	public void updateBoard(BoardBean bb){
		try {
			conn = getConn();
			sql = "update board set title=?,content=?,date=now() where num=?";
			pstmt = conn.prepareStatement(sql);
					
			pstmt.setString(1, bb.getTitle());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getNum());
					
			pstmt.executeUpdate();
				
			System.out.println("DAO : update board ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Update Board Method **/
	
	/** Delete Board Method */
	public void deleteBoard(int num){
		try {
			conn = getConn();
			sql = "delete from board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			System.out.println("DAO : delete board ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	/* Delete Board Method **/
	
	/** Re Insert Board Method(���) */
	public void reInsertBoard(BoardBean bb){
		int bno = 0;
		try {
			conn = getConn();
			sql = "select max(num) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bno = rs.getInt(1) + 1;
				
				//��� ���� ���ġ
				//re_ref ���� ���� �׷�, re_seq ������ ������ ū ���� ���� �� 1 ����
				sql = "update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bb.getRe_ref());
				pstmt.setInt(2, bb.getRe_seq());
				
				pstmt.executeUpdate();
				
				System.out.println("DAO : ��� ���� ���ġ !");
			}
				
			//��� �ۼ�
			sql = "insert into board"
					+"(num,id,pw,title,content,readcount,re_ref,re_lev,re_seq,date,file) "
					+ "values (?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, bb.getId());
			pstmt.setString(3, bb.getPw());
			pstmt.setString(4, bb.getTitle());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);		//��ȸ�� �׻� 0���� �ʱ�ȭ
			pstmt.setInt(7, bb.getRe_ref());	//��� ref : �Ϲݱ�(����)�� ref �� ���
			pstmt.setInt(8, bb.getRe_lev()+1);		//��� lev : �鿩���� 1����
			pstmt.setInt(9, bb.getRe_seq()+1);		//��� seq : ���� 1 ����
			pstmt.setString(10, bb.getFile());
			
			pstmt.executeUpdate();
			System.out.println("DAO : ��� �ۼ� �Ϸ� !");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/** Re Insert Board Method(���) */
}
