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

public class GoodsDAO {
	/*
	 * DB 테이블의 모든 처리 변수 : con(DB 커넥션) | sql(DB sql 구문) | pstmt(sql구문을 연결하기위한 객체)
	 * | rs(sql 구문의 리턴 값)
	 */

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

	// insertGoods(goods)
	public void insertGoods(GoodsBean goods) {
		int num = 0;

		try {
			// 1.2. 디비연결
			con = getCon();
			// 3.sql생성 & pstmt객체
			// 상품번호 계산 (select)
			sql = "select max(g_num) from goods";
			pstmt = con.prepareStatement(sql);

			// 4.sql 실행
			rs = pstmt.executeQuery();
			System.out.println("DAO : 상품번호 생성 - " + num);
			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}
			System.out.println("DAO : 상품번호 생성 - " + num);

			// 상품등록 (insert)
			sql = "insert into goods(g_num,nick,g_name,price,content,category,"
					+ "imgs,location,nego,read_count,heart,condi,reg_date) values(?,?,?,?,?,?,?,?,?,?,?,?,now())";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, goods.getNick());
			pstmt.setString(3, goods.getG_name());
			pstmt.setInt(4, goods.getPrice());
			pstmt.setString(5, goods.getContent());
			pstmt.setString(6, goods.getCategory());
			pstmt.setString(7, goods.getImgs());
			pstmt.setString(8, goods.getLocation());
			pstmt.setString(9, goods.getNego());
			pstmt.setInt(10, goods.getRead_count());
			pstmt.setInt(11, goods.getHeart());
			pstmt.setString(12, goods.getCondi());

			pstmt.executeUpdate();

			System.out.println("DAO : 상품등록완료! ");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// insertGoods(goods)

	// getGoodsList()
	public List<GoodsBean> getGoodsList(String item) {
		List<GoodsBean> goodsList = new ArrayList<GoodsBean>();


		StringBuffer SQL = new StringBuffer();
			
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3.sql 작성  & pstmt 객체
			
			SQL.append("select * from goods");
			
			if(item.equals("all")){
			}else{ // category
				SQL.append(" where category=?");
			}
			
			pstmt = con.prepareStatement(SQL.toString()+" order by g_num desc");
				
			if(item.equals("all")){}
			else{
				pstmt.setString(1, item); // item변수에 각 카테고리 저장
			}
			
			// 4. sql 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			while (rs.next()) {
				GoodsBean gb = new GoodsBean();

				gb.setCategory(rs.getString("category"));
				gb.setContent(rs.getString("content"));
				gb.setDate(rs.getDate("reg_date"));
				gb.setG_name(rs.getString("g_name"));
				gb.setG_num(rs.getInt("g_num"));
				gb.setImgs(rs.getString("imgs"));
				gb.setHeart(rs.getInt("heart"));
				gb.setLocation(rs.getString("location"));
				gb.setNego(rs.getString("nego"));
				gb.setNick(rs.getString("nick"));
				gb.setPrice(rs.getInt("price"));
				gb.setRead_count(rs.getInt("read_count"));
				gb.setCondi(rs.getString("condi"));

				goodsList.add(gb);

			} // while

			System.out.println("DAO : 리스트 상품목록 저장완료! ");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return goodsList;
	}
	// getGoodsList()

	// getGoods(num)
	public GoodsBean getGoods(int num) {
		GoodsBean gb = null;

		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql 구문 & pstmt 객체 생성
			sql = "select * from goods where g_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			// 4. sql 실행
			rs = pstmt.executeQuery();

			// 5. 데이터 처리
			if (rs.next()) {
				gb = new GoodsBean();

				gb.setCategory(rs.getString("category"));
				gb.setContent(rs.getString("content"));
				gb.setDate(rs.getDate("reg_date"));
				gb.setG_name(rs.getString("g_name"));
				gb.setG_num(rs.getInt("g_num"));
				gb.setImgs(rs.getString("imgs"));
				gb.setHeart(rs.getInt("heart"));
				gb.setLocation(rs.getString("location"));
				gb.setNego(rs.getString("nego"));
				gb.setNick(rs.getString("nick"));
				gb.setPrice(rs.getInt("price"));
				gb.setRead_count(rs.getInt("read_count"));
				gb.setCondi(rs.getString("condi"));

			}

			System.out.println("DAO : 상품정보 저장완료! ");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return gb;
	}
	// getGoods(num)
	
	
	// updateReadCount(num)
	public void updateReadCount(int num){
		
		try {
			//1.2. 디비연결
			con = getCon();
			//3. sql 쿼리 & pstmt객체
			// 기존의 조회수를 1증가
			sql = "update goods set read_count=read_count+1 where g_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			//4. sql 실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 조회수 1증가! ");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	// updateReadCount(num)
	
	
	// modifyGoods(gb)
	public void modifyGoods(GoodsBean gb) {

		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql (update) & pstmt 객체 생성
			sql = "update goods set "
					+ "g_name=?,category=?,nego=?,price=?,content=?,condi=? "
					+ "where g_num=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, gb.getG_name());
			pstmt.setString(2, gb.getCategory());
			pstmt.setString(3, gb.getNego());
			pstmt.setInt(4, gb.getPrice());
			pstmt.setString(5, gb.getContent());
			pstmt.setString(6, gb.getCondi());
			pstmt.setInt(7, gb.getG_num());

			// 4. sql구문 실행
			pstmt.executeUpdate();

			System.out.println("DAO : 상품정보 수정완료!");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// modifyGoods(gb)

	// deleteGoods(num)
	public void deleteGoods(int num) {

		try {
			// 1.2 디비연결
			con = getCon();
			// 3 .sql 작성 & pstmt 생성
			sql = "delete from goods where g_num=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			// 4. sql 실행
			pstmt.executeUpdate();
			System.out.println("DAO : 상품 삭제 ");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// deleteGoods(num)

}
