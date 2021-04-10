package com.portfolio.Notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/** �������� ������ ���� DB ��ü
 * getConn() : DB ���� �޼ҵ�
 * closeDB() : DB �ڿ� ���� �޼ҵ�
 * insertNotice() : �������� �� ���� �޼ҵ�
 * getNoticeListCount() : �������� ��ü �� ������ �������� �޼ҵ�
 * getNoticeList() : �������� ��ü ����Ʈ�� �������� �޼ҵ�
 * updateReadcount() : Ŭ���� ��ȸ���� ������Ű�� �޼ҵ�
 * getNotice() : Ŭ���� �������� �� ������ �������� �޼ҵ�
 * updateNotice() : �������� ������ �����ϴ� �޼ҵ�
 * */

public class NoticeDAO {
	/* notice ���̺� ���� DB ó�� */
	
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
	
	/** Insert Notice Method */
	public void insertNotice(NoticeBean nb) {
		int num = 0;
		try {
			conn = getConn();
			sql = "select max(num) from notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			System.out.println("DAO : �� ��ȣ 1 ���� ! >> "+num);
			
			sql = "insert into notice "
					+"(num,id,pw,title,content,date) "
					+"values (?,?,?,?,?,now())";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, nb.getId());
			pstmt.setString(3, nb.getPw());
			pstmt.setString(4, nb.getTitle());
			pstmt.setString(5, nb.getContent());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : insert notice success ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Insert Notice Method **/
	
	/** Get Notice List Count Method */
	public int getNoticeListCount(){
		int count = 0;
		try {
			conn = getConn();
			sql = "select count(*) from notice";
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
	/* Get Notice List Count Method **/
	
	/** Get Notice List Method */
	public ArrayList getNoticeList(int startRow, int pageSize){
		ArrayList list = new ArrayList();
		NoticeBean nb = null;
		int i = 0;
		
		try {
			conn = getConn();
			sql = "select * from notice order by num desc "
					+"limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				nb = new NoticeBean();
				
				nb.setNum(rs.getInt("num"));
				nb.setId(rs.getString("id"));
				nb.setPw(rs.getString("pw"));
				nb.setTitle(rs.getString("title"));
				nb.setContent(rs.getString("content"));
				nb.setDate(rs.getDate("date"));
				nb.setReadcount(rs.getInt("readcount"));
				
				list.add(i, nb);
				i++;
			}
			System.out.println("DAO : notice list >> "+list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return list;
	}
	/* Get Notice List Method **/
	
	/** Update Readcount Method */
	public void updateReadcount(int num){
		try {
			conn = getConn();
			sql = "update notice set readcount=readcount+1 where num=?";
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
	
	/** Get Notice Method (detail) */
	public NoticeBean getNotice(int num){
		NoticeBean nb = null;
		try {
			conn = getConn();
			sql = "select * from notice where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				nb = new NoticeBean();
				
				nb.setNum(rs.getInt("num"));
				nb.setId(rs.getString("id"));
				nb.setPw(rs.getString("pw"));
				nb.setTitle(rs.getString("title"));
				nb.setContent(rs.getString("content"));
				nb.setDate(rs.getDate("date"));
				nb.setReadcount(rs.getInt("readcount"));
			}
			System.out.println("DAO : get notice >> "+nb);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return nb;
	}
	/* Get Notice Method (detail) **/
	
	/** Notice Password Check Method */
	public int noticePWcheck(int num, String id, String pw){
		int check = -1;
		try {
			conn = getConn();
			sql = "select id,pw from notice where num=?";
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
			
			System.out.println("DAO : notice id & password check >> "+check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return check;
	}
	/* Notice Password Check Method **/
	
	/** Update Notice Method */
	public void updateNotice(NoticeBean nb){
		try {
			conn = getConn();
			sql = "update notice set title=?,content=?,date=now() where num=?";
			pstmt = conn.prepareStatement(sql);
					
			pstmt.setString(1, nb.getTitle());
			pstmt.setString(2, nb.getContent());
			pstmt.setInt(3, nb.getNum());
					
			pstmt.executeUpdate();
				
			System.out.println("DAO : update notice ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Update Notice Method **/
	
	/** Delete Notice Method */
	public void deleteNotice(int num){
		try {
			conn = getConn();
			sql = "delete from notice where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			System.out.println("DAO : delete notice ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	/* Delete Notice Method **/
}
