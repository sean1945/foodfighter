<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="food.FoodDao" %>
<%@ page import="food.FoodDto" %>
<%
	FoodDao fdao=new FoodDao();
	FoodDto fdto = fdao.mypage(request,session);
	
	request.setAttribute("fdto", fdto);
	String idx = request.getParameter("idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 회원탈퇴</title>
<style>
	
	#section1 {
	width: 1200px;
	height: 600px;
	margin: auto;
	}
	
	input[type=button]{
	width:414px;
	height:50px;
	background:lightsalmon;
	color:white;
	border:none;
	font-size:18px;
	cursor:pointer;
	font-weight:bolder;
	margin-top:10px;
	}
	
	body{
	margin:0px;
	}
	
	#user_delete{
	border-bottom:1px solid silver;
	width:800px;
	margin:auto;
	padding-left:200px;
	}
	
	#user_delete_head{
	font-size:20px;
	font-weight:bold;
	}
	
	.user_delete_menu{
	font-weight:bold;
	}
	
	#user_delete li{
	margin-bottom:50px;
	}
	
	.join_main {
	text-align: center;
	font-weight: bold;
	font-size: 26px;
	margin-top: 30px;
	margin-bottom: 30px;
	}

	.join_head {
	width: 200px;
	height: 40px;
	background: #f2f2f2;
	display: inline-block;
	color: gray;
	font-size: 18px;
	padding-top: 10px;
	font-weight:bold;	
	text-decoration:none;
	}
	
	.join_head:hover{
	opacity:0.5;
	}

	#join_page{
	background:lightsalmon;
	color:white;
	border:none;
	}

	#join_head_main {
	margin-bottom: 50px;
	margin-top:50px;
	}
	
</style>
<script>
	function member_out()
	{
		if(confirm("정말 탈퇴하시겠습니까?"))
		{
			location="user_delete_ok.jsp";
		}
	}
</script>
</head>
<body>
<div id="section1">
<div id="join_head_main" align="center">
	<a class="join_head" href="mypage.jsp?idx=${fdto.idx}">회원정보변경</a>
	<a class="join_head" href="pwd_change.jsp?idx=${fdto.idx}">비밀번호변경</a>
	<a class="join_head" href="user_delete.jsp?idx=${fdto.idx}" id="join_page">회원탈퇴</a>
</div>
<div id="user_delete">
	<span id="user_delete_head">회원 탈퇴 신청 시 아래 사항을 반드시 확인해주세요.</span>
	<ol>
		<li>
			<span class="user_delete_menu">재 가입시 기존 정보 유지</span><br>
			<span>회원탈퇴를 신청하시면 해당 정보는 30일동안 유지되며<br>
					기간안에 재가입할때 기존 아이디 비밀번호로 로그인하여<br>
					재가입 해주시길 바랍니다. 
			</span>
		</li>
		<li>
			<span class="user_delete_menu">회원정보 및 게시물 삭제</span><br>
			<span>회원탈퇴 후 30일이 지난후 아래에 해당하는 개인정보가 삭제됩니다.<br>
					개인정보 : 이메일 계정, 비밀번호, 휴대폰번호, 생일, 성별 정보 삭제
			</span>
		</li>
	</ol>
</div>
<div align="center">
	<input type="button" onclick="javascript:member_out()" value="탈퇴하기">
</div>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>