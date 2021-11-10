package com.foodfighter.content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContentDao {
	private static Connection conn = null;
	private static PreparedStatement pstmt = null;
	
//	private final String BOARD_UPDAT_CNT = "update restaurant set cnt = cnt + 1 where idx = ?";

	public ContentDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void ConnectMysql() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://3.37.233.74:3306/foodfighter";
//		String url = "jdbc:mysql://localhost:3306/foodfighter";
		conn = DriverManager.getConnection(url, "chris", "3pe6gq8c");
	}
	
	public void CloseMysql() throws SQLException {
		pstmt.close();
		conn.close();
	}

	
	public ContentDto getRecord(HttpServletRequest request) throws Exception {
		//DB연결
		ConnectMysql();
		
		//폼에 입력값 가져오기
		request.setCharacterEncoding("utf-8");
		String idx = request.getParameter("idx");
		
		String sql_cnt = String.format("update restaurant set cnt = cnt + 1 where idx = %s", idx);
		pstmt = conn.prepareStatement(sql_cnt);
		pstmt.executeUpdate();

		//쿼리 생성
		String sql = String.format("select * from restaurant where idx = %s", idx);

		//심부름꾼 생성
		pstmt = conn.prepareStatement(sql);

		//쿼리 실행
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		ContentDto cdto = new ContentDto();
		cdto.setIdx(rs.getInt("idx"));
		cdto.setName(rs.getString("name"));
		cdto.setAddr1(rs.getString("addr1"));
		cdto.setAddr2(rs.getString("addr2"));
		cdto.setRegion1(rs.getString("region1"));
		cdto.setRegion2(rs.getString("region2"));
		cdto.setTel(rs.getString("tel"));
		cdto.setFtype(rs.getString("ftype"));
		cdto.setPrice(rs.getString("price"));
		cdto.setParking(rs.getString("parking"));
		cdto.setRuntime(rs.getString("runtime"));
		cdto.setLastorder(rs.getString("lastorder"));
		cdto.setHoliday(rs.getString("Holiday"));
		cdto.setName(rs.getString("name"));
		cdto.setName(rs.getString("name"));
		cdto.setScore(rs.getFloat("score"));
		cdto.setRegdate(rs.getString("regdate"));
		cdto.setCnt(rs.getInt("cnt"));
		
//		CloseMysql();
		
		return cdto;
	}

	
	public ArrayList<String> getRestaurantImgList(HttpServletRequest request) throws Exception {
		//DB연결
		ConnectMysql();
		
		//폼에 입력값 가져오기
		request.setCharacterEncoding("utf-8");
		String idx = request.getParameter("idx");
		
		//쿼리 생성
		String sql = String.format("select * from image where rest_idx = %s and review_idx = 0 and user_idx = 0", idx);

		//심부름꾼 생성
		pstmt = conn.prepareStatement(sql);

		//쿼리 실행
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<String> ret = new ArrayList<String>();
		
		while(rs.next()) {
			String img = rs.getString("image");
			ret.add(img);
		}
		
//		CloseMysql();
		
		return ret;
	}
	
	
	public ArrayList<MenuDto> getMenus(HttpServletRequest request) throws Exception {
		ConnectMysql();

		request.setCharacterEncoding("utf-8");
		String idx = request.getParameter("idx");
		
		String sql = String.format("select * from menu where rest_idx = %s order by idx desc", idx);

		pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();

		ArrayList<MenuDto> ret = new ArrayList<MenuDto>();
		while(rs.next()) {
			MenuDto mdto = new MenuDto();
			mdto.setIdx(rs.getInt("idx"));
			mdto.setRest_idx(rs.getInt("rest_idx"));
			mdto.setMenu(rs.getString("menu"));
			mdto.setPrice(rs.getInt("price"));
			
			ret.add(mdto);
		}

		CloseMysql();
		
		return ret;
	}
	
	
	public void updateViewCnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String idx = request.getParameter("idx");

		ConnectMysql();
		
		String sql = String.format("update restaurant set cnt = cnt + 1 where idx = %s", idx);
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();

		CloseMysql();
	
		// 이동
		String alink = String.format("detail.jsp?idx=&s", idx);
		response.sendRedirect(alink);

	}
	
}
