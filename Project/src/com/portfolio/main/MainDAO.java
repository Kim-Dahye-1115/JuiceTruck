package com.portfolio.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.portfolio.Board.BoardBean;
import com.portfolio.Gallery.GalleryBean;
import com.portfolio.Notice.NoticeBean;

public class MainDAO {
    /* gallery table 에 대한 DB 처리 */
	
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

	/** Notice */
	public ArrayList getNoticeList(){
		ArrayList list = new ArrayList();
		NoticeBean nb = null;
		int i = 0;
		
		try {
			conn = getConn();
			sql = "select * from notice order by num desc "
					+"limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 5);
			
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
	/* Notice **/
	
	/** Gallery */
	public ArrayList getGalleryList() {
		ArrayList list = new ArrayList();
		GalleryBean gb = null;
		int i = 0;
		
		try {
			conn = getConn();
			sql = "select * from gallery order by num desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 4);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				gb = new GalleryBean();
				
				gb.setNum(rs.getInt("num"));
				gb.setId(rs.getString("id"));
				gb.setFile(rs.getString("file"));
				gb.setTag(rs.getString("tag"));
				gb.setDate(rs.getDate("date"));
				gb.setReadcount(rs.getInt("readcount"));
				
				list.add(i, gb);
				i++;
			}
			System.out.println("DAO : gallery list >> "+list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return list;
	}
	/* Gallery **/
	
	/** Board */
	public ArrayList getBoardList(){
		ArrayList list = new ArrayList();
		BoardBean bb = null;
		int i = 0;
		
		try {
			conn = getConn();
			sql = "select * from board order by num desc "
					+"limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 5);
			
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
	/* Board **/
}
