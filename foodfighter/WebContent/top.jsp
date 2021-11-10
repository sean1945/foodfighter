<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="../css/content.css">
<script type="text/javascript" src="../js/content.js"></script>
<link rel="shortcut icon" href="../img/pabicon.ico">
<style>
body {
	margin: 0px;
}

#title {
	font-size: 30px;
	font-weight: bold;
	font-family: fantasy;
}

#top {
	height: 100px;
	padding-top: 10px;
	margin: auto;
	background: white;
	text-align: center;
}

#top_navi {
	height: 50px;
	width: 100%;
	background: white;
	margin: auto;
	padding-top: 10px;
	box-shadow: 0px 0px 5px silver;
	border-right:silver;
}

#top_navi #navi_menu {
	padding: 0px;
	margin-top: 0px;
	text-align: center;
}

#top_navi #navi_search {
	width: 440px;
	height: 30px;
	padding: 0px;
	background: lightsalmon;
}

#top_navi li {
	position: relative;
	text-align: center;
	width: 150px;
	height: 30px;
	font-weight: bold;
	display: inline-block;
	list-style-type: none;
	padding-top: 5px;
	border-radius: 5px;
	margin: 4px 20px;
	justify-content: space-around;
	align-items: center;
	float:right;
	color:black;
	font-size:18px;
}

#search_text {
	border: 3px solid white;
	height: 30px;
	width: 350px;
	border-radius: 10px;
}

#btnSearch {
	width: 50px;
	height: 35px;
	font-weight: bold;
	display: inline-block;
	background: white;
	border: 2px solid white;
	border-radius: 5px;
}

#navi_menu .sub{
	position: absolute;
	visibility: hidden;
	background: #f2f2f2;
	border-width: 0px 1px 1px 1px;
	border-radius: 10px;
	margin: 0px;
	padding: 10px;
	left: -30px;
	top: 35px;
	box-shadow: 0px 1px 4px silver;
	height:auto;
	z-index:20;
}

#navi_menu .sub a{
	color:black;
	text-decoration:none;
}

#navi_menu .sub a:hover{
	background:white;
	display:inline-block;
	width:110px;
	height:25px;
	border-radius:10px;
}

.top_navi_f {
	position: fixed;
	top: 0%;
	z-index: 20;
}

.section1_f {
	padding-top: 60px;
	padding-bottom: 20px;
}

#go_top {
	position: fixed;
	right: 5%;
	top: 90%;
	left:1810px;
	visibility: hidden;
	width: 50px;
	height: 50px;
}

.top_navi li {
	display: inline-block;
	list-style-type: none;
}

#navi_manu > img{
	width:100px; 
	height:100px;
	float:left;
}

#navi_logo{
	display:inline-block;
	float:left;
	margin-bottom:5px;
	position:relative;
	top:-5px;
	cursor:pointer;
}

.decnone{
	text-decoration:none;
	color:black;
}

#li_img{
	cursor:pointer;
}

#nickname1{
	color:#ff6d33;
}

#header_search2{
	width:500px;
	position:absolute;
	left:150px;
	top:8px;
	z-index:8;
}

#search_box2{
	width:300px;
	height:40px;
	padding-left:20px;
	border:1px solid lightsalmon;
	border-radius:30px;
	outline:none;
	font-size:14px;
}

#search_sub2{
	border:none;
	background:lightsalmon;
	width:110px;
	height:45px;
	color:white;
	border-radius:30px;
	position:absolute;
	left:250px;
	top:0px;
	float:right;
	font-size:20px;
	font-weight:bold;
	cursor:pointer;
}

</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
		function move_top() // 페이지 상단 이동
		{
			document.documentElement.scrollTop=0;
		}
		document.onscroll=scroll_move;
		function scroll_move() //스크롤시 네비 고정
		{
			if(document.documentElement.scrollTop>=135)
			{	
				document.getElementById("go_top").style.visibility="visible";
				document.getElementById("top_navi").classList.add("top_navi_f");
				document.getElementById("section1").classList.add("section1_f");
			}
			else
			{
				document.getElementById("go_top").style.visibility="hidden";
				document.getElementById("top_navi").classList.remove("top_navi_f");
				document.getElementById("section1").classList.remove("section1_f");
			}
		}
		function view(n)
		{
			document.getElementsByClassName("sub")[n].style.visibility="visible";
		}
		function hide(n)
		{
			document.getElementsByClassName("sub")[n].style.visibility="hidden";				
		}
	</script>
</head>
<body>
	<div id="top_navi">
		<div id="header_search2">
				<form method="post" action="../search/search.jsp">
					<input type="text" name="q" id="search_box2" placeholder="지역, 식당 또는 음식" onfocus="this.placeholder=''" onblur="this.placeholder='지역, 식당 또는 음식'"/>
					<input type="submit" value="검색" id="search_sub2"/>
				</form>
			</div>
		<ul id="navi_menu">
			<div id="navi_logo" onclick="location='../main/main.jsp'">
			<img src="../img/logo.png">
			</div>
			<li onmouseover="view(0)" onmouseout="hide(0)" style="bottom: 10px" id="li_img">
					<img src="../img/user.png" width="40" height="40">
				<ul class="sub">
					<!-- 로그인을 하지 않았을 경우 -->
					<c:if test="${userid==null}">
						<li><a href="../login/login.jsp">로그인</a></li>
						<li><a href="../signup/tos.jsp">회원가입</a></li>
					</c:if>
					<!-- 로그인을 한 경우 -->
					<c:if test="${userid!=null && userid!='admin'}">
						<li><a href="../mypage/mypage.jsp?idx=${idx}">마이페이지</a></li>
						<li><a href="../login/logout.jsp">로그아웃</a></li>
					</c:if>
					<!-- 관리자일 경우 -->
					<c:if test="${userid !=null && userid=='admin'}">
						<li><a href="../admin/member_view.jsp">관리페이지</a></li>
						<li><a href="../login/logout.jsp">로그아웃</a></li>
					</c:if>
				</ul>
			</li>
				<c:if test="${userid != null }">
				<li>
					<span><a id="nickname1">${nickname}</a> 님</span>
				</li>
				</c:if>
			<li>
				<a href="../search/search.jsp?q=고기" class="decnone">상세검색</a>
			</li>
			<li>
				<a href="../gongji/list.jsp" class="decnone">공지사항
			</a></li>
			<li onmouseover="view(1)" onmouseout="hide(1)">지역맛집
				<ul class="sub">
					<li><a href="../localsearch/localsearch.jsp?region1=서울">서울 맛집</a></li>
					<li><a href="../localsearch/localsearch.jsp?region1=경기">경기 맛집</a></li>
					<li><a href="../localsearch/localsearch.jsp?region1=제주">제주 맛집</a></li>
					<li><a href="../localsearch/localsearch.jsp?region1=city">전국 맛집</a></li>
				</ul>
			</li>
		</ul>
		<img src="../img/unnamed.png" id="go_top" onclick="move_top()">
	</div>
	