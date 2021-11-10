<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ page import="foodfighter.main.MainDao"%>
<%@ page import="foodfighter.main.MainDto"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%
	MainDao mdao=new MainDao();
	ArrayList<MainDto> randlist=mdao.random();
	ArrayList<MainDto> mylocal=mdao.myloc(session);
	String[] myloc=mdao.selectlocal(session);
	ArrayList<MainDto> reviewlist=mdao.recent_review();
	ArrayList<MainDto> bestlist=mdao.bestrest();
	
	request.setAttribute("randlist",randlist);
	request.setAttribute("mylocal", mylocal);
	request.setAttribute("myloc", myloc);
	request.setAttribute("reviewlist",reviewlist);
	request.setAttribute("bestlist",bestlist);
	
	//String host = "http://3.37.233.74";
	String host = "..";
	request.setAttribute("host", host);
%>
<title>푸트파이터 : 대한민국 No.1 맛집사이트</title>
<link rel="stylesheet" href="../css/main.css"/>
<script>
	function img_change() // 이미지 슬라이드
	{
		slide=setInterval(function()
		{
			$("#inner").animate(
			{
				marginLeft:"-700px"
			},1000,function()
				{
					$("#inner a").eq(0).insertAfter($("#inner a").eq(4));
					$("#inner").css("marginLeft","0px");
					$(".random_sub").eq(0).insertAfter($(".random_sub").eq(4));
			}); 
		},4000);	
	}
	function stop_change() // 마우스오버시 슬라이드 중지
	{
		clearInterval(slide);
	}
	window.onload=img_change; // 이미지 슬라이드 자동
</script>
<div id="header_banner" align="center">
	<img src="../img/header.jpg">
</div>
<div id="header_search">
	<form method="post" action="../search/search.jsp">
		<input type="text" name="q" id="search_box" placeholder="지역, 식당 또는 음식" onfocus="this.placeholder=''" onblur="this.placeholder='지역, 식당 또는 음식'"/>
		<input type="submit" value="검색" id="search_sub"/>
	</form>
</div>
<div id="section1">
	<div class="sub_title">오늘은 뭘먹을까?</div>
	<div id="section1_content">
		<div id="outer_side_outer" onmouseover="stop_change()" onmouseout="img_change()">
			<div id="outer_side_inner">
				<c:forEach items="${randlist}" var="rand">
					<ul class="random_sub">
						<a href="../content/detail.jsp?idx=${rand.rest_idx}">
						<li><h3>${rand.name}- <span>${rand.resscore}</span></h3></li>
						<li>카테고리 : ${rand.ftype}</li>
						<br>
						<li>가격대 : ${rand.rangeprice}</li>
						<br>
						<li>영업시간 : ${rand.runtime}</li>
						<br>
						<li>휴무일 : ${rand.holiday}</li>
						<br>
						<li>Breaktime : ${rand.breaktime}</li>
						<br>
						<li>tel. ${rand.tel}</li>
						<br>
						<li>주소 : ${rand.addr1}</li>
						</a>
					</ul>
				</c:forEach>
			</div>
		</div>
		<div id="outer" onmouseover="stop_change()" onmouseout="img_change()">
			<div id="inner">
				<c:forEach items="${randlist}" var="rand">
				<c:if test="${rand.image == 'noimg'}">
					<a href="../content/detail.jsp?idx=${rand.rest_idx}"><img src="../img/noimg.jpg"></a>
				</c:if>
				<c:if test="${rand.image != 'noimg'}">
					<a href="../content/detail.jsp?idx=${rand.rest_idx}"><img src="${host}${rand.image}" onerror="this.src='../img/noimg.jpg'"></a>
				</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<div class="line"></div>
<div id="section2">
	<div class="sub_title">지역별 맛집</div>
	<ul>
		<li>
			<a href="../localsearch/localsearch.jsp?region1=서울"> 
			<img src="../img/local/seoul.jpg">
			</a>
		</li>
		<li>
			<a href="../localsearch/localsearch.jsp?region1=제주"> 
			<img src="../img/local/jeju.jpg">
			</a>
		</li>
		<li>
			<a href="../localsearch/localsearch.jsp?region1=경기"> 
			<img src="../img/local/gg.jpg">
			</a>
		</li>
		<li>
			<a href="../localsearch/localsearch.jsp?region1=city"> 
			<img src="../img/local/city.jpg">
			</a>
		</li>
	</ul>
</div>
<div class="line"></div>
<div id="section3">
	<div class="sub_title">최고 별점 맛집 Top.8</div>
	<div id="section3_content">
		<ul>
			<c:set var="i" value="1" />
			<c:forEach items="${bestlist}" var="best" >
				<li><a href="../content/detail.jsp?idx=${best.rest_idx}"> <img src="${host}${best.image}"></a>
					<div class="li_text">
						<a href="../content/detail.jsp?idx=${best.rest_idx}"><h3>${i}.
							${best.name} - <span>${best.resscore}</span>
						</h3></a>
						카테고리 : ${best.ftype}<br> 
						가격대 : ${best.rangeprice}<br>
						${best.addr1}
					</div>
				</li>
				<c:set var="i" value="${i+1}" />
			</c:forEach>
		</ul>
	</div>
</div>
<div class="line"></div>
<div id="section3">
	<div class="sub_title">선호 지역 맛집</div>
	<div class="sub_title_loc">( "${myloc[0]}, ${myloc[1]}" 맛집 )</div>
	<div id="section3_content">
		<ul>
			<c:set var="i" value="1" />
			<c:forEach items="${mylocal}" var="myloc" >
				<li><a href="../content/detail.jsp?idx=${myloc.rest_idx}"> <img src="${host}${myloc.image}"></a>
					<div class="li_text">
						<a href="../content/detail.jsp?idx=${myloc.rest_idx}"><h3>${i}.
							${myloc.name} - <span>${myloc.resscore}</span>
						</h3></a>
						카테고리 : ${myloc.ftype}<br> 
						가격대 : ${myloc.rangeprice}<br>
						${myloc.addr1}
					</div>
				</li>
				<c:set var="i" value="${i+1}" />
			</c:forEach>
		</ul>
	</div>
</div>
<div class="line"></div>
<div id="section4">
	<div class="sub_title">최근 등록된 리뷰</div>	
	<c:forEach items="${reviewlist}" var="review">
		<a href="../content/detail.jsp?idx=${review.rest_idx}"><img src="${host}${review.image}" onerror="this.src='${host}/img/noimg.jpg'"/></a>
		<div class="li_text">
			<h3><a href="../content/review_detail.jsp?rest_idx=${review.rest_idx}&review_idx=${review.review_idx}&user_idx=${review.user_idx}">작성자 : ${review.nickname} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 식당상호명 : ${review.name}<br>
			식당평점 : <span>${review.resscore} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> 내가준 점수 : <span>${review.revscore}</span></a></h3>
			(조회수 : ${review.cnt}, 작성일 : ${review.regdate})<br><br>
			카테고리 : ${review.ftype}<br><br>
			식당주소 : ${review.addr1}<br><br>
			<span class="review_content">${review.content}</span>
			<div class="review_more"><a href="../content/detail.jsp?idx=${review.rest_idx}">"${review.name}" 더 보기></a></div>
		</div>
		<div class="review_img_list">
		<c:if test="${review.imglist!=''}" >
		<c:forEach var="img" items="${fn:split(review.imglist,',')}">
			<img src="${host}${img}">
		</c:forEach>
		</c:if>
		</div>
	</c:forEach>
</div>
<%@ include file="../bottom.jsp"%>
