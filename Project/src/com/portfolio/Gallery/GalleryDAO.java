package com.portfolio.Gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GalleryDAO {
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
	
	/** Insert Gallery Method */
	public void insertGallery (GalleryBean gb){
		int num = 0;
		try {
			conn = getConn();
			sql = "select max(num) from gallery";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			System.out.println("DAO : 갤러리 번호 1 증가 ! >> "+num);
			
			sql = "insert into gallery(num,id,file,tag,date) "
					+"values(?,?,?,?,now())";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, gb.getId());
			pstmt.setString(3, gb.getFile());
			pstmt.setString(4, gb.getTag());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : gallery insert success ! ");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	/* Insert Gallery Method **/
	
	/** Get Gallery List Count Method */
	public int getGalleryListCount() {
		int count = 0 ;
		try {
			conn = getConn();
			sql = "select count(*) from gallery";
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
	/* Get Gallery List Count Method **/
	
	/** Get Gallery List Method */
	public ArrayList getGalleryList(int startRow, int pageSize) {
		ArrayList list = new ArrayList();
		GalleryBean gb = null;
		int i = 0;
		
		try {
			conn = getConn();
			sql = "select * from gallery order by num desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
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
	/* Get Gallery List Method **/
	
	/** Update Readcount Method */
	public void updateReadcount(int num){
		try {
			conn = getConn();
			sql = "update gallery set readcount=readcount+1 where num=?";
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
	
	/** Get Gallery Method (detail) */
	public GalleryBean getGallery(int num){
		GalleryBean gb = null;
		try {
			conn = getConn();
			sql = "select * from gallery where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				gb = new GalleryBean();
				
				gb.setNum(rs.getInt("num"));
				gb.setId(rs.getString("id"));
				gb.setFile(rs.getString("file"));
				gb.setTag(rs.getString("tag"));
				gb.setDate(rs.getDate("date"));
				gb.setReadcount(rs.getInt("readcount"));
			}
			System.out.println("DAO : get gallery >> "+gb);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return gb;
	}
	/* Get Gallery Method (detail) **/
	
	/** Gallery ID Check */
	public int galleryIDcheck(int num, String id){
		int check = -1;
		try {
			conn = getConn();
			sql = "select id from gallery where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){	//이미지 존재
				if(id.equals(rs.getString("id"))){	//아이디 일치
					check = 1;
				} else{	//아이디 불일치
					check = 0;
				}
			} else{	//이미지 존재 하지 않을 때
				check = -1;
			}
			System.out.println("DAO : gallery id check >> "+check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return check;
	}
	/* Gallery ID Check **/
	
	/** Delete Gallery Method */
	public void deleteGallery(int num){
		try{
			conn = getConn();
			sql = "delete from gallery where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			System.out.println("DAO : delete gallery !");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Delete Gallery Method **/
	
	/** Update Gallery Tag Method */
	public void updateGalleryTag(int num, String tag){
		try {
			conn = getConn();
			sql = "update gallery set tag=?,date=now() where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tag);
			pstmt.setInt(2, num);
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : gallery update to tag !");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	/* Update Gallery Tag Method **/
}
