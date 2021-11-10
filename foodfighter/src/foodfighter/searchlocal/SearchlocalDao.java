package foodfighter.searchlocal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import foodfighter.main.MainDto;

public class SearchlocalDao {

	Connection conn;
	public SearchlocalDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://3.37.233.74/foodfighter";
//		String url = "jdbc:mysql://localhost:3306/foodfighter";
		conn=DriverManager.getConnection(url,"chris","3pe6gq8c");
	}
 
	// 서울 지역 데이터 가져오기
	public String[] seoul() throws Exception
	{		
		int count;
		// 배열 크기를 위한 데이터 갯수 구하기
		String sql="select count(distinct region2) as count from restaurant where region1 like '%서울%'";
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rs1=pstmt1.executeQuery();
		rs1.next();
		count=rs1.getInt("count");	
		String[] seoullist=new String[count];
		
		// 배열에 담을 region2데이터 구하기
		sql="select distinct region2 from restaurant where region1 like '%서울%' order by region2";
		PreparedStatement pstmt2=conn.prepareStatement(sql);
		ResultSet rs2=pstmt2.executeQuery();
		for(int i=0; i<count; i++)
		{
			rs2.next();
			seoullist[i]=rs2.getString("region2");
		}
		rs1.close();
		rs2.close();
		pstmt1.close();
		pstmt2.close();
		
		return seoullist;
	}
	// 경기 지역 데이터 가져오기
	public String[] gg() throws Exception
	{		
		int count;
		// 배열 크기를 위한 데이터 갯수 구하기
		String sql="select count(distinct region2) as count from restaurant where region1 like '%경기%'";
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rs1=pstmt1.executeQuery();
		rs1.next();
		count=rs1.getInt("count");	
		String[] gglist=new String[count];
		
		// 배열에 담을 region2데이터 구하기
		sql="select distinct region2 from restaurant where region1 like '%경기%' order by region2";
		PreparedStatement pstmt2=conn.prepareStatement(sql);
		ResultSet rs2=pstmt2.executeQuery();
		for(int i=0; i<count; i++)
		{
			rs2.next();
			gglist[i]=rs2.getString("region2");
		}
		rs1.close();
		rs2.close();
		pstmt1.close();
		pstmt2.close();
		
		return gglist;
	}
	
	// 제주 지역 데이터 가져오기
	public String[] jeju() throws Exception
	{		
		int count;
		// 배열 크기를 위한 데이터 갯수 구하기
		String sql="select count(distinct region2) as count from restaurant where region1 like '%제주%'";
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rs1=pstmt1.executeQuery();
		rs1.next();
		count=rs1.getInt("count");	
		String[] jejulist=new String[count];
		
		// 배열에 담을 region2데이터 구하기
		sql="select distinct region2 from restaurant where region1 like '%제주%' order by region2";
		PreparedStatement pstmt2=conn.prepareStatement(sql);
		ResultSet rs2=pstmt2.executeQuery();
		for(int i=0; i<count; i++)
		{
			rs2.next();
			jejulist[i]=rs2.getString("region2");
		}
		rs1.close();
		rs2.close();
		pstmt1.close();
		pstmt2.close();
		
		return jejulist;
	}
	
	// 전국 지역 데이터 가져오기
	public String[] city() throws Exception
	{		
		int count;
		// 배열 크기를 위한 데이터 갯수 구하기
		String sql="select count(distinct region1) as count from restaurant where region1 not like '%서울%' and region1 not like'%제주%' and region1 not like '%경기%'";
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rs1=pstmt1.executeQuery();
		rs1.next();
		count=rs1.getInt("count");	
		String[] citylist=new String[count];
		
		// 배열에 담을 region2데이터 구하기
		sql="select distinct region1 from restaurant where region1 not like '%서울%' and region1 not like'%제주%' and region1 not like '%경기%' order by region2";
		PreparedStatement pstmt2=conn.prepareStatement(sql);
		ResultSet rs2=pstmt2.executeQuery();
		for(int i=0; i<count; i++)
		{
			rs2.next();
			citylist[i]=rs2.getString("region1");
		}
		rs1.close();
		rs2.close();
		pstmt1.close();
		pstmt2.close();
		
		return citylist;
	}
	// 페이징 처리를 위한 pstart,pend,chong,page
	public SearchpageDto chongpage(HttpServletRequest request) throws Exception
	{
		int page;
		// 지역 기본값 지역마다 쿼리문 다르게 줘야함
		String region1="";
		String region2="";
		String sql;
		if(request.getParameter("page")==null)
		{
			page=1;
		}
		else
		{
			page=Integer.parseInt(request.getParameter("page"));
		}
		int pstart=page/10;
		if(page%10 == 0)
		{
			pstart=pstart-1;
		}
		pstart=(pstart*10)+1;
		
		if(request.getParameter("region2")!=null) // region2가 있을경우
		{
			// 서울,경기,제주 일경우
			if(!request.getParameter("region1").equals("city"))
			{
				region1=request.getParameter("region1");
				region2=request.getParameter("region2");
				sql="select ceil(count(*)/10) as chong from restaurant where region1 like '%"+region1+"%' and region2 like '%"+region2+"%'";		
			}
			// 전국일경우
			else
			{
				region1=request.getParameter("region2");
				sql="select ceil(count(*)/10) as chong from restaurant where region1 like '%"+region1+"%'";
				region1="city";
				region2=request.getParameter("region2");
			}
		}
		else // region2 가 없을경우
		{
			// region1도 없을경우
			if(request.getParameter("region1")==null)
			{
				sql="select ceil(count(*)/10) as chong from restaurant where region1 like '%서울%'";
			}
			else
			{
				// 서울,경기,제주 일경우
				if(!request.getParameter("region1").equals("city")) 
				{
					region1=request.getParameter("region1");
					sql="select ceil(count(*)/10) as chong from restaurant where region1 like '%"+region1+"%'";		
				}
				// 전국일경우
				else
				{
					sql="select ceil(count(*)/10) as chong from restaurant where region1 not like '%서울%' and region1 not like'%제주%' and region1 not like '%경기%'";
					region1="city";
				}
			}
		}
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		int chong=rs.getInt("chong");
		int pend=pstart+9;
		if(pend>chong)
		{
			pend=chong;
		}
		SearchpageDto sdto=new SearchpageDto();
		sdto.setPage(page);
		sdto.setPstart(pstart);
		sdto.setPend(pend);
		sdto.setChong(chong);
		sdto.setRegion1(region1);
		sdto.setRegion2(region2);
		
		rs.close();
		pstmt.close();
		
		return sdto;
	}
	
	// 지역 데이터를 토대로 테이블에서 식당 가져오기
	public ArrayList<SearchlocalDto> localrest(HttpServletRequest request) throws Exception
	{
		// 지역 기본값
		String region1="";
		String region2="";
		String sql;
		// 페이지 처리
		int page;
		if(request.getParameter("page")==null)
		{
			page=1;
		}
		else
		{
			page=Integer.parseInt(request.getParameter("page"));
		}
		int index=(page-1)*10;
				
		if(request.getParameter("region2")!=null) // region2가 있을경우
		{
			// 서울,경기,제주 일경우
			if(!request.getParameter("region1").equals("city"))
			{
				region1=request.getParameter("region1");
				region2=request.getParameter("region2");
				sql="select * from restaurant where region1 like '%"+region1+"%' and region2 like '%"+region2+"%' order by score desc limit ?,10";		
			}
			// 전국일경우
			else
			{
				region1=request.getParameter("region2");
				sql="select * from restaurant where region1 like '%"+region1+"%' order by score desc limit ?,10";
			}
		}
		else // region2 가 없을경우
		{
			// region1도 없을경우
			if(request.getParameter("region1")==null)
			{
				sql="select * from restaurant where region1 like '%서울%' order by score desc limit ?,10";
			}
			else
			{
				// 서울,경기,제주 일경우
				if(!request.getParameter("region1").equals("city")) 
				{
					region1=request.getParameter("region1");
					sql="select * from restaurant where region1 like '%"+region1+"%' order by score desc limit ?,10";		
				}
				// 전국일경우
				else
				{
					sql="select * from restaurant where region1 not like '%서울%' and region1 not like'%제주%' and region1 not like '%경기%' order by score desc limit ?,10";
				}
			}
		}	
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<SearchlocalDto> list=new ArrayList<SearchlocalDto>();

		while(rs.next())
		{
			SearchlocalDto sdto=new SearchlocalDto();
			int rest_idx=rs.getInt("idx");
			sdto.setRest_idx(rest_idx);
			String image=restimg(rest_idx); // 대표 이미지 한개 가져오기
			sdto.setImage(image);
			int review_cnt=count_review(rest_idx); // 리뷰 갯수 가져오기
			sdto.setReview_cnt(review_cnt);
			int menu_cnt=count_menu(rest_idx); // 메뉴 갯수 가져오기
			sdto.setMenu_cnt(menu_cnt);
			sdto.setName(rs.getString("name"));
			sdto.setAddr1(rs.getString("addr1"));
			sdto.setFtype(rs.getString("ftype"));
			sdto.setCnt(rs.getInt("cnt"));
			if(rs.getString("price").length()>=1)
			{
				sdto.setRangeprice(rs.getString("price"));
			}
			else
			{
				sdto.setRangeprice("가격대  x");
			}
			sdto.setResscore(rs.getString("score"));
			
			list.add(sdto);
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
	// 식당 리뷰 갯수 가져오기
	public int count_review(int rest_idx) throws Exception
	{
		String sql="select count(*) as review_cnt from review where rest_idx=?";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, rest_idx);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		int review_cnt=rs.getInt("review_cnt");
		rs.close();
		pstmt.close();
		
		return review_cnt;		
	}
	// 식당 메뉴 갯수 가져오기
	public int count_menu(int rest_idx) throws Exception
	{
		String sql="select count(menu) as menu_cnt from menu where rest_idx=?";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, rest_idx);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		int menu_cnt=rs.getInt("menu_cnt");
		
		rs.close();
		pstmt.close();
		
		return menu_cnt;
	}
}




