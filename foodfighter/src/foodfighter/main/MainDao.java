package foodfighter.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class MainDao {

	Connection conn;
	public MainDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://3.37.233.74/foodfighter";
//		String url = "jdbc:mysql://localhost:3306/foodfighter";
		conn=DriverManager.getConnection(url,"chris","3pe6gq8c");
	}
	
	// 식당수 가져오기
	public int count_rest() throws Exception
	{
		String sql="select (max(idx)-min(idx)+1) as restchong from restaurant";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();	
		int restchong=rs.getInt("restchong");
		rs.close();
		pstmt.close();
		
		return restchong;
	}
	
	// 전국 식당 랜덤 추천
	public ArrayList<MainDto> random() throws Exception
	{
		int restchong=count_rest();
		Random rand=new Random();
		
		int[] relist=new int[5];
		for(int i=0; i<5; i++)
		{
			relist[i]=(rand.nextInt(restchong))+102;
			for(int j=0; j<i; j++)
			{
				if(relist[i]==relist[j])
				{
					i--;
				}
			}
		}
		String restlist=Arrays.toString(relist);
		restlist=restlist.replace("[","").replace("]", "");
		String sql="select * from restaurant where idx in ("+restlist+")";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<MainDto> list=new ArrayList<MainDto>();
		// 랜덤 식당 5개 리턴
		while(rs.next())
		{	
			MainDto mdto=new MainDto();
			int rest_idx=rs.getInt("idx");
			mdto.setRest_idx(rest_idx);
			String image=restimg(rest_idx); // 대표 이미지 한개 가져오기
			mdto.setImage(image);
			mdto.setName(rs.getString("name"));
			mdto.setAddr1(rs.getString("addr1"));
			if(rs.getString("tel").length()>=1)
			{
				mdto.setTel(rs.getString("tel"));
			}
			else
			{
				mdto.setTel("없음");
			}
			mdto.setRegion1(rs.getString("region1"));
			mdto.setRegion2(rs.getString("region2"));
			mdto.setFtype(rs.getString("ftype"));
			mdto.setRangeprice(rs.getString("price"));
			mdto.setRuntime(rs.getString("runtime"));
			if(rs.getString("breaktime").length()>=1)
			{
				mdto.setBreaktime(rs.getString("breaktime"));
			}
			else
			{
				mdto.setBreaktime("없음");
			}
			if(rs.getString("holiday").length()>=1)
			{
				mdto.setHoliday(rs.getString("holiday"));
			}
			else
			{
				mdto.setHoliday("없음");
			}
			mdto.setResscore(rs.getString("score"));

			list.add(mdto);
		}
		rs.close();
		pstmt.close();
		
		return list;
	}
	
	// 식당 아이디로 식당 사진파일명 가져오기
	public String restimg(int n) throws Exception
	{
		int rest_idx=n;
		String sql="select image from image where rest_idx=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, rest_idx);
		
		ResultSet rs=pstmt.executeQuery();
		String image="";
		if(rs.next())
		{
			image=rs.getString("image");
		}
		rs.close();
		pstmt.close();
		
		return image;
	}
	
	// 선호지역 맛집 출력	
	public ArrayList<MainDto> myloc(HttpSession session) throws Exception
	{
		String region1="서울";
		String region2="마포";
		if(session.getAttribute("userid")!= null)
	      {
	         String userid=session.getAttribute("userid").toString();
	         String sql="select mylocation from member where userid=?";
	         
	         PreparedStatement pstmt1=conn.prepareStatement(sql);
	         pstmt1.setString(1, userid);
	         
	         ResultSet rs1=pstmt1.executeQuery();
	         rs1.next();
	         
	         if(rs1.getString("mylocation") != null && !rs1.getString("mylocation").equals(""))
	         {
	            String mylocation=rs1.getString("mylocation");
	            String[] myloc=new String[2];
	            myloc=mylocation.split(" ");
	            
	            region1=myloc[0];
	            region2=myloc[1];
	         }
	         rs1.close();
	         pstmt1.close();
	      }
		String sql="select * from restaurant where addr1 like '%"+region1+"%"+region2+"%' or addr2 like '%"+region1+"%"+region2+"%' order by score desc limit 0,12";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();

		ArrayList<MainDto> list=new ArrayList<MainDto>();
		
		// 맛집 리스트 12개 리턴
		while(rs.next())
		{
			MainDto mdto=new MainDto();
			int rest_idx=rs.getInt("idx");
			mdto.setRest_idx(rest_idx);
			String image=restimg(rest_idx); // 대표 이미지 한개 가져오기
			mdto.setImage(image);
			mdto.setName(rs.getString("name"));
			mdto.setAddr1(rs.getString("addr1"));
			mdto.setFtype(rs.getString("ftype"));
			if(rs.getString("price").length()>=1)
			{
				mdto.setRangeprice(rs.getString("price"));
			}
			else
			{
				mdto.setRangeprice("가격대  x");
			}
			mdto.setResscore(rs.getString("score"));
			
			list.add(mdto);
		}
		rs.close();
		pstmt.close();
		
		return list;
	}
	
	// 선호 지역
	public String[] selectlocal(HttpSession session) throws Exception
	{		
		String[] myloc=new String[2];
		myloc[0]="서울";
		myloc[1]="마포";	
		// 로그인했을 경우
		if(session.getAttribute("userid")!=null)
	      {
	         String userid=session.getAttribute("userid").toString();
	         String sql="select mylocation from member where userid=?";
	         PreparedStatement pstmt=conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         ResultSet rs=pstmt.executeQuery();
	         rs.next();
	      
	         String mylocation=rs.getString("mylocation");
	         
	         if(rs.getString("mylocation")!=null)
	         {
	            myloc=mylocation.split(" ");
	         }
	         rs.close();
	         pstmt.close();
	      }		
		
		return myloc;
	}
	// 최고 별점 식당 정보
	public ArrayList<MainDto> bestrest() throws Exception
	{
		String sql="select * from restaurant order by score desc limit 0,8";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();

		ArrayList<MainDto> list=new ArrayList<MainDto>();
		
		// 맛집 리스트 12개 리턴
		while(rs.next())
		{
			MainDto mdto=new MainDto();
			int rest_idx=rs.getInt("idx");
			mdto.setRest_idx(rest_idx);
			String image=restimg(rest_idx); // 대표 이미지 한개 가져오기
			mdto.setImage(image);
			mdto.setName(rs.getString("name"));
			mdto.setAddr1(rs.getString("addr1"));
			mdto.setFtype(rs.getString("ftype"));
			if(rs.getString("price").length()>=1)
			{
				mdto.setRangeprice(rs.getString("price"));
			}
			else
			{
				mdto.setRangeprice("가격대  x");
			}
			mdto.setResscore(rs.getString("score"));
			
			list.add(mdto);
		}
		rs.close();
		pstmt.close();
		
		return list;
	}
	// 최근 댓글 달린 식당
	public ArrayList<MainDto> recent_review() throws Exception
	{
		String sql="select restaurant.idx,restaurant.name,addr1,ftype,restaurant.score,"
				+ "member.nickname,member.idx,review.idx,content,review.cnt,review.score,review.regdate "
				+ "from restaurant,review,member where restaurant.idx=review.rest_idx and review.user_idx=member.idx order by review.regdate desc limit 0,5";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<MainDto> list=new ArrayList<MainDto>();
		
		while(rs.next())
		{
			MainDto mdto=new MainDto();
			int rest_idx=rs.getInt("restaurant.idx");
			mdto.setRest_idx(rest_idx);
			int user_idx=rs.getInt("member.idx");
			mdto.setUser_idx(user_idx);
			int review_idx=rs.getInt("review.idx");
			mdto.setReview_idx(review_idx);
			String imglist=reviewimg(rest_idx,user_idx,review_idx); // 리뷰 이미지  가져오기 문자열로
			String image=restimg(rest_idx);
			mdto.setImage(image);
			mdto.setImglist(imglist);
			mdto.setName(rs.getString("restaurant.name"));
			mdto.setAddr1(rs.getString("addr1"));
			mdto.setFtype(rs.getString("ftype"));
			mdto.setResscore(rs.getString("restaurant.score"));
			mdto.setNickname(rs.getString("member.nickname"));
			mdto.setReview_idx(review_idx);
			mdto.setContent(rs.getString("content"));
			mdto.setCnt(rs.getInt("cnt"));
			mdto.setRevscore(rs.getString("review.score"));
			mdto.setRegdate(rs.getString("review.regdate"));
			
			list.add(mdto);
		}
		return list;
	}
	// 리뷰에 맞는 사진명 가져오기
	public String reviewimg(int rest, int user,int review) throws Exception
	{
		int rest_idx=rest;
		int user_idx=user;
		int review_idx=review;
		String sql="select * from image where rest_idx="+rest_idx+" and user_idx="+user_idx+" and review_idx="+review_idx;
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		String reviewimg="";
		while(rs.next())
		{
			if(reviewimg == "")
			{
				reviewimg=rs.getString("image");
			}
			else
			{
				reviewimg=reviewimg+","+rs.getString("image");
			}
		}
		rs.close();
		pstmt.close();
		
		return reviewimg;
	}
}
