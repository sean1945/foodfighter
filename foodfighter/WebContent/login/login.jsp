<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<% 
	request.setAttribute("chk", request.getParameter("chk"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 로그인</title>
<style>
	#section1 {
	width: 1200px;
	height: 500px;
	margin: auto;
	}
	
	h2 {
	text-align: center;
	}

	#fail {
	color: tomato;
	font-size: 18px;
	}

	#login_cont {
	width: 1000px;
	height: 600px;
	margin: auto;
	}

		#login_cont2 {
	background: #f5f5f5;
	text-align: center;
	}

	#login_cont2>a {
	text-decoration: none;
	padding: 5px;
	}

	#login_head {
	font-size: 20px;
	text-align: center;
	padding-bottom: 30px;
	font-weight: bold;
	}

	#login_head_color {
	color: #ff7400;
	}

	#login_fail {
	padding-bottom: 5px;
	font-weight: bold;
	}

	input[type=text], input[type=password] {
	width: 400px;
	height: 40px;
	padding-left: 10px;
	border: 1px solid silver;
	}

	input[type=submit] {
	width: 100px;
	height: 100px;
	background: lightsalmon;
	color: white;
	border: none;
	font-size: 20px;
	cursor: pointer;
	font-weight: bold;
	}

	th, td {
	padding: 5px;
	}

	table {
	margin-top: 130px;
	}
	
	.cont2{
	font-weight:bold;
	font-size:18px;
	color:gray;
	}
	
</style>
<script>
	// 아이디찾기 창을 작은창으로 오픈하는 자바스크립트
	function idopen()
	{
	window.open("userid_check.jsp","new","width=500,height=500,top=100,left=100");
	}
	
	// 비밀번호찾기 창을 작은창으로 오픈하는 자바스크립트
	function pwdopen()
	{
	window.open("userpwd_check.jsp","new","width=500,height=500,top=100,left=100");
	}
</script>
<link rel="shortcut icon" href="http://3.37.233.74:8080/foodfighter/img/pabicon.ico">
</head>
<body>
<div id="section1">
<div id="login_cont" align="center">
<form method="post" action="login_ok.jsp">
	<table>
		<tr>
			<td colspan="2" id="login_head">가입하신 <span id="login_head_color">아이디</span>로 로그인하세요.</td>
		</tr>
		<tr>
			<td><input type="text" name="userid" placeholder="아이디를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='아이디를 입력해주세요.'" autofocus tabindex="1"></td>
			<td rowspan="2"><input type="submit" value="로그인" autofocus tabindex="3"></td>
		</tr>
		<tr>
			<td><input type="password" name="password" placeholder="비밀번호를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호를 입력해주세요.'" autofocus tabindex="2"></td>
		</tr>
		<c:if test="${chk == 1}">
			<tr>
				<td id="fail" colspan="2"> <div id="login_fail">아이디 또는 비밀번호가 잘못되었습니다.</div> </td>
			</tr>
		</c:if>
		<c:if test="${chk == 2}">
			<tr>
				<td id="fail" colspan="2"> <div id="login_fail">탈되완료된 회원입니다 재가입을 해주세요.</div> </td>
			</tr>
		</c:if>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" id="login_cont2">
			<a href="javascript:;" onclick="idopen()" class="cont2">아이디 찾기</a> <a class="cont2">|</a>
			<a href="javascript:;" onclick="pwdopen()" class="cont2">비밀번호 찾기</a> <a class="cont2">|</a> 
			<a href="../signup/tos.jsp" class="cont2">회원 가입</a>
			</td>
		</tr>
	</table>
</form>
</div>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>