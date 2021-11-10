package com.foodfighter.review;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodfighter.content.ImageDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReviewDao {
	private static Connection conn = null;
	private static PreparedStatement pstmt = null;

	public ReviewDao() {
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

	public ArrayList<ReviewDto> list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//DB연결
		ConnectMysql();
		
		//폼에 입력값 가져오기
		request.setCharacterEncoding("utf-8");
		String idx = request.getParameter("idx");
		
		//쿼리 생성
		String sql = String.format("select r.*, m.name from review r, member m where r.user_idx = m.idx and r.rest_idx = %s order by idx desc", idx);
//		System.out.println("sql = " + sql);

		//심부름꾼 생성
		pstmt = conn.prepareStatement(sql);

		ArrayList<ReviewDto> list = new ArrayList<ReviewDto>();
		
		//쿼리 실행
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ReviewDto rdto = new ReviewDto();
			int review_idx = rs.getInt("idx");
			rdto.setIdx(review_idx);
			int rest_idx = rs.getInt("rest_idx");
			rdto.setRest_idx(rest_idx);
			int user_idx = rs.getInt("user_idx");
			rdto.setUser_idx(user_idx);
			rdto.setContent(rs.getNString("content"));
			rdto.setCnt(rs.getInt("cnt"));
			rdto.setScore(rs.getFloat("score"));
			rdto.setRegdate(rs.getString("regdate"));
			rdto.setName(rs.getNString("name"));
			rdto.setImagelist(getReviewImageList(rest_idx, review_idx, user_idx));
			
			list.add(rdto);
		}
		
		CloseMysql();
		
		return list;
	}

	
	public void write_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//DB연결
		ConnectMysql();
		
		//폼에 입력값 가져오기
		String imgpath = request.getSession().getServletContext().getRealPath("/img");
		String contextpath = request.getSession().getServletContext().getRealPath("/");
//		System.out.println("path = " + tmppath);
		int size=1024*1024*10;
		MultipartRequest multi = new MultipartRequest(request, imgpath, size, "utf-8", new DefaultFileRenamePolicy());
		String idx = multi.getParameter("idx");
		String useridx = multi.getParameter("useridx");
		if (useridx.equals("")) {
			useridx = "1";
		}
		String range_val = multi.getParameter("range_val");
		String reviewcontent = multi.getParameter("reviewcontent");
	
		//쿼리 생성
//		String sql = String.format("insert into review (rest_idx, user_idx, content, score, cnt, regdate) values (%s, %s, '%s', %s, 0, now())", 
//				idx, useridx, reviewcontent, range_val);
		String sql = "insert into review (rest_idx, user_idx, content, cnt, score, regdate) values (?, ?, ?, 0, ?, now())";

		//심부름꾼 생성
		pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstmt.setInt(1, Integer.parseInt(idx));
		pstmt.setInt(2, Integer.parseInt(useridx));
		pstmt.setString(3, reviewcontent);
		pstmt.setString(4, range_val);

		//쿼리 실행
		pstmt.executeUpdate();
		
		int autoincrement = 0;
		ResultSet rs = pstmt.getGeneratedKeys(); // 쿼리 실행 후 생성된 키 값 반환
		if (rs.next()) {
			autoincrement = rs.getInt(1); // 키값 초기화
			System.out.println("autoIncrement: " + autoincrement); // 출력
		}
		
		// 업로드 한 파일을 정위치한다
		Enumeration file = multi.getFileNames(); // 여러개의 파일을 업로드할때 파일이름을 가지고 온다..
		String restaurant = getRestaurantName(idx);
		File uploadPath = new File(imgpath + "/" + restaurant);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		while(file.hasMoreElements())  // fname1, fname2, fname3
		{
			String fname = multi.getFilesystemName(file.nextElement().toString());
			if (fname != null) {
				String oldfilename = imgpath + "/" + fname;
				System.out.println(oldfilename);
				String dbname = "/img/" + restaurant + String.format("/%d_%s_%s", autoincrement, useridx, fname);
				String newfilename = contextpath + dbname;
				System.out.println(newfilename);
				File oldFile = new File(oldfilename);
			    File newFile = new File(newfilename);

			    oldFile.renameTo(newFile); // 파일명 변경
			    
			    // image 테이블에 추가
			    String sqlsub = String.format("insert into image (rest_idx, review_idx, user_idx, image) values (%s, %d, %s, '%s')", 
			    		idx, autoincrement, useridx, dbname);
			    PreparedStatement pstmt2 = conn.prepareStatement(sqlsub);
			    pstmt2.executeUpdate();				
			}
		}


		CloseMysql();
		
		String alink = String.format("detail.jsp?idx=%s", idx);
		response.sendRedirect(alink);
	}
	
	public ArrayList<ImageDto> getReviewImageList(int rest_idx, int review_idx, int user_idx) throws Exception {
		String sql = String.format("select * from image where rest_idx = %d and review_idx = %d and user_idx = %d", rest_idx, review_idx, user_idx);
//		System.out.println("sql = " + sql);
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<ImageDto> imgs = new ArrayList<ImageDto>();
		while (rs.next()) {
			ImageDto idto = new ImageDto();
			idto.setIdx(rs.getInt("idx"));
			idto.setRest_idx(rs.getInt("rest_idx"));
			idto.setReview_idx(rs.getInt("review_idx"));
			idto.setUser_idx(rs.getInt("user_idx"));
			idto.setImage(rs.getString("image"));
			
			imgs.add(idto);
		}

		return imgs;
	}
	
	public ReviewDto getReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//DB연결
		ConnectMysql();
		
		//폼에 입력값 가져오기
		request.setCharacterEncoding("utf-8");
		String rest_idx = request.getParameter("rest_idx");
		String review_idx = request.getParameter("review_idx");
		String user_idx = request.getParameter("user_idx");
		
//		String sql_cnt = String.format("update review set cnt = cnt + 1 where idx = %d", review_idx);
		String sql_cnt = "update review set cnt = cnt + 1 where idx = ?";
		pstmt = conn.prepareStatement(sql_cnt);
		pstmt.setString(1, review_idx);
		pstmt.executeUpdate();

		//쿼리 생성
//		String sql = String.format("select r.*, m.name, r2.name as restaurant from review r, member m, restaurant r2 "
//				+ "where r.user_idx = m.idx and r.rest_idx = %s and r.idx = %s and r2.idx = %s", rest_idx, review_idx, rest_idx);
		String sql = "select r.*, m.name, r2.name as restaurant from review r, member m, restaurant r2 "
				+ "where r.user_idx = m.idx and r.rest_idx = ? and r.idx = ? and r2.idx = ?";
//		System.out.println("sql = " + sql);

		//심부름꾼 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, rest_idx);
		pstmt.setString(2, review_idx);
		pstmt.setString(3, rest_idx);

		//쿼리 실행
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		ReviewDto rdto = new ReviewDto();
		int reviewidx = Integer.parseInt(review_idx);
		rdto.setIdx(reviewidx);
		int restidx = Integer.parseInt(rest_idx);
		rdto.setRest_idx(restidx);
		int useridx = Integer.parseInt(user_idx);
		rdto.setUser_idx(useridx);
		rdto.setContent(rs.getNString("content"));
		rdto.setCnt(rs.getInt("cnt"));
		rdto.setScore(rs.getFloat("score"));
		rdto.setRegdate(rs.getString("regdate"));
		rdto.setName(rs.getNString("name"));
		rdto.setImagelist(getReviewImageList(restidx, reviewidx, useridx));
		rdto.setRestaurant(rs.getString("restaurant"));	
		
		CloseMysql();
		
		return rdto;
		
	}
	
	
	public String getRestaurantName(String rest_idx) throws Exception {
		String sql = String.format("select * from restaurant where idx = %s", rest_idx);
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		String returnString = rs.getString("name");
		
		return returnString;
	}
	
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		//DB연결
		ConnectMysql();
		
		//폼에 입력값 가져오기
		String imgpath = request.getSession().getServletContext().getRealPath("/img");
		String contextpath = request.getSession().getServletContext().getRealPath("/");
//		System.out.println("path = " + tmppath);
		int size=1024*1024*10;
		MultipartRequest multi = new MultipartRequest(request, imgpath, size, "utf-8", new DefaultFileRenamePolicy());
		String reviewidx = multi.getParameter("reviewidx");
		String useridx = multi.getParameter("useridx");
		String restidx = multi.getParameter("restidx");
		String range_val = multi.getParameter("range_val");
		String reviewcontent = multi.getParameter("reviewcontent");
	
		//쿼리 생성
//		String sql = String.format("update review set content = '%s', score = %s where idx = %s", 
//				reviewcontent, range_val, reviewidx);
		String sql = "update review set content = ?, score = ? where idx = ?";

		//심부름꾼 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, reviewcontent);
		pstmt.setString(2, range_val);
		pstmt.setString(3, reviewidx);

		//쿼리 실행
		pstmt.executeUpdate();
		
		// 업로드 한 파일을 정위치한다
		Enumeration file = multi.getFileNames(); // 여러개의 파일을 업로드할때 파일이름을 가지고 온다..
		String restaurant = getRestaurantName(restidx);
		File uploadPath = new File(imgpath + "/" + restaurant);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		while(file.hasMoreElements())  // fname1, fname2, fname3
		{
			String fname = multi.getFilesystemName(file.nextElement().toString());
			if (fname != null) {
				String oldfilename = imgpath + "/" + fname;
				System.out.println(oldfilename);
				String dbname = "/img/" + restaurant + String.format("/%s_%s_%s", reviewidx, useridx, fname);
				String newfilename = contextpath + dbname;
				System.out.println(newfilename);
				File oldFile = new File(oldfilename);
			    File newFile = new File(newfilename);

			    oldFile.renameTo(newFile); // 파일명 변경
			    
			    // image 테이블에 추가
//			    String sqlsub = String.format("insert into image (rest_idx, review_idx, user_idx, image) values (%s, %s, %s, '%s')", 
//			    		restidx, reviewidx, useridx, dbname);
			    String sqlsub = "insert into image (rest_idx, review_idx, user_idx, image) values (?, ?, ?, ?)"; 
			    
			    PreparedStatement pstmt2 = conn.prepareStatement(sqlsub);
				pstmt2.setString(1, restidx);
				pstmt2.setString(2, reviewidx);
				pstmt2.setString(3, useridx);
				pstmt2.setString(4, dbname);

				pstmt2.executeUpdate();				
			}
		}


		CloseMysql();
		
		String alink = String.format("detail.jsp?idx=%s", restidx);
		response.sendRedirect(alink);

	}

	public ArrayList<ReviewDto> getReview_admin() throws Exception
	{
		//DB연결
		ConnectMysql();
		
		String sql = "select r1.*, r2.name, m.userid from review r1, restaurant r2, member m where r1.rest_idx = r2.idx and r1.user_idx = m.idx order by r1.regdate desc";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<ReviewDto> list = new ArrayList<ReviewDto>();
		
		while(rs.next())
		{
			ReviewDto rdto = new ReviewDto();
			rdto.setIdx(rs.getInt("idx"));
			rdto.setRest_idx(rs.getInt("rest_idx"));
			rdto.setUser_idx(rs.getInt("user_idx"));
			rdto.setContent(rs.getNString("content"));
			rdto.setCnt(rs.getInt("cnt"));
			rdto.setScore(rs.getFloat("score"));
			rdto.setRegdate(rs.getString("regdate"));
			rdto.setName(rs.getNString("name"));
			rdto.setUserid(rs.getString("userid"));
			
			list.add(rdto);
		}
		return list;
		
	}

	
	public void review_delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		//DB연결
		ConnectMysql();
		
		String idx = request.getParameter("idx");
		
		String sql = "delete from review where idx=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, idx);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("review_view.jsp");
	}

	
}
