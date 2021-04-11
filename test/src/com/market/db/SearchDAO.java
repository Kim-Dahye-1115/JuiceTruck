//검색 DAO
package com.market.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.member.db.MemberBean;

public class SearchDAO {

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
	//search(s)
	public Vector search(String search){
		//검색결과
		Vector searchResult = new Vector();
		
		//상품검색결과
		List goodsList = new ArrayList();
		//판매자검색결과
		List usersList = new ArrayList();
		
		try {
			//상점검색
			//1.2.디비연결
			con = getCon();
			
			//상품검색
			//3.sql & pstmt
			sql="select * from goods"
					+ " where g_name like ? or category like ? or nick like ?"
					+ " order by reg_date desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			pstmt.setString(3, "%"+search+"%");
			
			//4.sql실행
			rs=pstmt.executeQuery();
			//5.데이터처리
			while(rs.next()){
				GoodsBean gb = new GoodsBean();//12개
				gb.setG_num(rs.getInt("g_num"));
				gb.setNick(rs.getString("nick"));
				gb.setG_name(rs.getString("g_name"));
				gb.setPrice(rs.getInt("price"));
				gb.setContent(rs.getString("content"));
				gb.setCategory(rs.getString("category"));
				gb.setImgs(rs.getString("imgs"));
				gb.setLocation(rs.getString("location"));
				gb.setNego(rs.getString("nego"));
				gb.setRead_count(rs.getInt("read_count"));
				gb.setHeart(rs.getInt("heart"));
				gb.setDate(rs.getDate("reg_date"));
				gb.setCondi(rs.getString("condi"));
				
				goodsList.add(gb);
			}
			
			searchResult.add(usersList);
			searchResult.add(goodsList);
			System.out.println("DAO : 검색결과 저장 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
		return searchResult;
		
	}
	//search(s)

	
}
