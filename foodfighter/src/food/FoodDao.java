package food;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;


public class FoodDao {
	
	Connection conn;
	
	// 생성자
	public FoodDao()throws Exception
	{
		// DB연결
	    Class.forName("com.mysql.jdbc.Driver");
	    String url="jdbc:mysql://3.37.233.74/foodfighter";
//		String url = "jdbc:mysql://localhost:3306/foodfighter";
	    conn=DriverManager.getConnection(url,"chris","3pe6gq8c");
	}
	
	
	
	// 회원가입 등록....
	public void signup(HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		
		// 회원가입 창에있는 폼태그 값 가져오기
	    request.setCharacterEncoding("utf-8");
	    String userid=request.getParameter("userid");
	    String name=request.getParameter("name");
	    String nickname=request.getParameter("nickname");
	    String password=request.getParameter("password");
	    int gender = Integer.parseInt(request.getParameter("gender"));
	    String email=request.getParameter("email");
	    String tel=request.getParameter("tel");
	    String mylocation = request.getParameter("region1_select")+" "+request.getParameter("region2_select");
	    
	    // 쿼리 생성 부분
	    String sql="insert into member(userid,name,nickname,password,gender,email,tel,regdate,mylocation,status) values(?,?,?,?,?,?,?,now(),?,0)";
	    
	    // 심부름꾼
	    PreparedStatement pstmt=conn.prepareStatement(sql);
	    pstmt.setString(1, userid);
	    pstmt.setString(2, name);
	    pstmt.setString(3, nickname);
	    pstmt.setString(4, password);
	    pstmt.setInt(5, gender);
	    pstmt.setString(6, email);
	    pstmt.setString(7, tel);
	    pstmt.setString(8, mylocation);
	    
	    // 쿼리 실행 부분
	    pstmt.executeUpdate();
	    
	    // 문서이동
	    response.sendRedirect("signup_end.jsp");
	}
	
	
	
	// 로그인 접속
	public void login_ok(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception
	{
		
		// 아이디 비밀번호 가져오기
		request.setCharacterEncoding("utf-8");
		String userid=request.getParameter("userid");
		String password=request.getParameter("password");
		
		// 회원탈퇴신청을 취소하는 체크박스가 체크되었다면 status=0;
		if(request.getParameter("resign") != null)
		{
			String sql2="update member set status=0 where userid=? and password=?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, userid);
			pstmt2.setString(2, password);
			pstmt2.executeUpdate();
		}
		
		// 쿼리생성
		String sql="select * from member where userid=? and password=?";
		
		// 심부름꾼   
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,userid);
		pstmt.setString(2,password);
		
		// 쿼리 실행
		ResultSet rs=pstmt.executeQuery();
		
		// 변수를 만들어 값을 넘겨주고 로그인이 되면 로그인 완료된 메인페이지로 이동
		if(rs.next())
		{
			if (rs.getInt("status") == 0)
			{
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("name", rs.getString("name"));
			session.setAttribute("nickname", rs.getString("nickname"));
			session.setAttribute("idx", rs.getString("idx"));
			
			response.sendRedirect("../main/main.jsp");
			}
			else if(rs.getInt("status") == 1)
			{
				response.sendRedirect("resign.jsp");
			}
			else if(rs.getInt("status") == 2)
			{
				response.sendRedirect("login.jsp?chk=2");
			}
			else
			{
				response.sendRedirect("login.jsp");
			}
		}
		else 
		{
			// chk란 변수를 주고 login창에서 
			response.sendRedirect("../login/login.jsp?chk=1");
		}
	}
	
	
	
	// 아이디 중복
	public int userid_chk(HttpServletRequest request) throws Exception
	{
		
		// 폼태그 값 가져오기
		String userid=request.getParameter("userid");
		
		// 쿼리생성
		String sql="select count(*) as chk from member where userid=?";
		
		// 심부름꾼
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		return rs.getInt("chk");
	}
	
	
	
	// 아이디 찾기
	public void idchk_ok(HttpServletRequest request,JspWriter out) throws Exception
	{
		
		String name=request.getParameter("name");
		String email=request.getParameter("email");
     
		// 쿼리생성
		String sql="select userid from member where name=? and email=?";
		
		// 심부름꾼
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,name);
		pstmt.setString(2,email);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();

		if(rs.next())
		{
			out.print(rs.getString("userid"));
		}
		else
		{
			out.print("0");
		}
	}
	
	
	
	// 비밀번호 찾기
	public void pwdchk_ok(HttpServletRequest request,JspWriter out) throws Exception
	{
		
		String userid=request.getParameter("userid");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
     
		// 쿼리생성
		String sql="select password from member where userid=? and name=? and email=?";
		
		// 심부름꾼
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,userid);
		pstmt.setString(2,name);
		pstmt.setString(3,email);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();

		if(rs.next())
		{
			out.print(rs.getString("password"));
		}
		else
		{
			out.print("0");
		}
	}
	
	
	
	// 회원 정보 수정 불러오기
	public FoodDto mypage(HttpServletRequest request,HttpSession session) throws Exception
	{
		String idx = request.getParameter("idx");
		
		String sql = "select * from member where idx=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, idx);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// rs -> Dto
		FoodDto fdto = new FoodDto();
		fdto.setIdx(rs.getInt("idx"));
		fdto.setUserid(rs.getString("userid"));
		fdto.setName(rs.getString("name"));
		fdto.setNickname(rs.getString("nickname"));
		fdto.setGender(rs.getInt("gender"));
		fdto.setEmail(rs.getString("email"));
		fdto.setTel(rs.getString("tel"));
		fdto.setRegdate(rs.getString("regdate"));
		if(rs.getString("mylocation")!=null)
		{
			fdto.setMylocation(rs.getString("mylocation"));
		}
		
		return fdto;
	}
	
	
	
	// 회원 정보 수정하기
	public void update_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
	    request.setCharacterEncoding("utf-8");
	    String idx=request.getParameter("idx");
	    String userid=request.getParameter("userid");
	    String password=request.getParameter("password");
	    String name=request.getParameter("name");
	    String nickname=request.getParameter("nickname");
	    String email=request.getParameter("email");
	    String tel=request.getParameter("tel");
	    int gender = Integer.parseInt(request.getParameter("gender"));
	    String mylocation = "";
	    // 쿼리 생성 부분
	    String sql="update member set name=?, nickname=?, email=?, tel=?, gender=?, mylocation=? where idx=?";
	    
	    if(request.getParameter("myloc_radio").equals("1"))
	    {
	    	String region1=request.getParameter("region1_select");
	    	String region2=request.getParameter("region2_select");
	    	mylocation=region1+" "+region2;
	    }
	    else
	    {
	    	mylocation=request.getParameter("mylocation");
	    }
	    
	    // 심부름꾼
	    PreparedStatement pstmt=conn.prepareStatement(sql);
	    pstmt.setString(1, name);
	    pstmt.setString(2, nickname);
	    pstmt.setString(3, email);
	    pstmt.setString(4, tel);
	    pstmt.setInt(5, gender);
	    pstmt.setString(6, mylocation);
	    pstmt.setString(7, idx);
	    
	    // 쿼리 실행 부분
	    pstmt.executeUpdate();
	    
	    session.invalidate();
	    
	    // 문서이동
	    response.sendRedirect("../mypage/mypage_end.jsp");
	}
	
	
	
	// 회원 비밀번호 변경
	public void pwd_change(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception
	{
		String idx=request.getParameter("idx");
		String pwd=request.getParameter("pwd");
		String pwd3=request.getParameter("pwd3");
		String pwd4=request.getParameter("pwd4");
		
		String sql2="select password from member where idx=?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, idx);
		
		ResultSet rs2 = pstmt2.executeQuery();
		rs2.next();
		String pwd2 = rs2.getString("password");
		
		if (pwd2.equals(pwd4))
			{
			if (pwd2.equals(pwd))
			{
				response.sendRedirect("pwd_change.jsp?chk=1&idx="+idx+"&pwd4="+pwd4+"&pwd="+pwd);
			}
			else if (pwd == "")
			{
				response.sendRedirect("pwd_change.jsp?chk=2&idx="+idx+"&pwd4="+pwd4+"&pwd="+pwd);
			}
			else if (pwd3 == "")
			{
				response.sendRedirect("pwd_change.jsp?chk=5&idx="+idx+"&pwd4="+pwd4+"&pwd="+pwd);
			}
			else if (pwd3.equals(pwd))
			{
				String sql = "update member set password=? where idx=?";
				
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, pwd);
				pstmt.setString(2, idx);
				
				pstmt.executeUpdate();
				
				pstmt.close();
				conn.close();
				
				session.invalidate();
				response.sendRedirect("pwd_change_end.jsp");
				
			}
			else
			{
				response.sendRedirect("pwd_change.jsp?chk=3&idx="+idx+"&pwd4="+pwd4+"&pwd="+pwd);
			}
		}
		else 
		{
			response.sendRedirect("pwd_change.jsp?chk=4&idx="+idx+"&pwd4="+pwd4+"&pwd="+pwd);
		}
	}
	
	
	
	// 유저 삭제
	public void user_delete_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		String sql = "update member set status=1 where userid=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("userid").toString());
		
		pstmt.executeUpdate();
		
		session.invalidate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("../main/main.jsp");
	}
	
	
	
	// 관리자계정 회원 레코드 불러오기
	public ArrayList<FoodDto> getmember() throws Exception
	{
		String sql="select * from member order by name asc";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		ArrayList<FoodDto> list = new ArrayList<FoodDto>();
		
		while(rs.next())
		{
			FoodDto fdto = new FoodDto();
			fdto.setIdx(rs.getInt("idx"));
			fdto.setUserid(rs.getString("userid"));
			fdto.setName(rs.getString("name"));
			fdto.setNickname(rs.getString("nickname"));
			fdto.setTel(rs.getString("tel"));
			fdto.setEmail(rs.getString("email"));
			fdto.setRegdate(rs.getString("regdate"));
			fdto.setStatus(rs.getInt("status"));
			
			list.add(fdto);
		}
		return list;
	}
	
	public void member_chg(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String sql="update member set status=2 where idx=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("idx"));
		
		pstmt.executeUpdate();
		
		response.sendRedirect("../admin/member_view.jsp");
	}
}
























