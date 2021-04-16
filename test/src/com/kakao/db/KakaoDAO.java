package com.kakao.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class KakaoDAO {
	// DB - f_member 테이블의 모든 처리 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";		
		
		// 디비연결 - 커넥션풀 
		private Connection getCon() throws Exception {
			Context initCTX = new InitialContext();
			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/kakaoDB");		
			con = ds.getConnection();
			
			System.out.println("DAO : 디비 연결 성공! -> " + con);
			
			return con;
		}
		
		// 자원해제 
		public void closeDB(){
			try {
				if(rs != null){ rs.close(); }
				if(pstmt != null){ pstmt.close(); }
				if(con != null){ con.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		//////////////////////////////////// DB연결 쿼리
		
		
		
}
