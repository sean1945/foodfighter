<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="food.FoodDao" %>
<%@ page import="food.FoodDto" %>
<%@ page import="foodfighter.searchlocal.SearchlocalDao" %>
<%
	FoodDao fdao=new FoodDao();
	FoodDto fdto = fdao.mypage(request,session);
	SearchlocalDao ldao=new SearchlocalDao();
	String[] seoullist=ldao.seoul();
	String[] gglist=ldao.gg();
	String[] jejulist=ldao.jeju();
	String[] citylist=ldao.city();

	request.setAttribute("fdto", fdto);
	request.setAttribute("seoullist",seoullist);
	request.setAttribute("gglist",gglist);
	request.setAttribute("jejulist",jejulist);
	request.setAttribute("citylist",citylist);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 내정보 보기</title>
<style>
	#section1 {
	width: 1200px;
	height: 570px;
	margin: auto;
	}
	
	h2 {
		text-align: center;
		font-size: 24px;
		margin-top: 50px;
	}
	
	#pwd1, #pwdchk1, #name, #birthday1, #email1, #phone, #uk, #sung {
		font-size: 14px;
		padding-top: 5px;
	}
	
	span {
		text-align: center;
	}
	
	input[type=text], input[type=password], input[type=email] {
		width: 400px;
		height: 40px;
		padding-left: 10px;
		border: 1px solid silver;
	}
	
	input[type=submit] {
		width: 414px;
		height: 50px;
		background: lightsalmon;
		color: white;
		border: none;
		font-size: 18px;
		cursor: pointer;
		font-weight: bolder;
	}
	
	input[type=button] {
		width: 414px;
		height: 50px;
		background: #ff7400;
		color: white;
		border: none;
		font-size: 18px;
		cursor: pointer;
		font-weight: bolder;
	}
	
	input:focus {
		outline: none;
	}
	
	#sung_td {
		color: gray;
		border: 1px solid silver;
		width: 412px;
		height: 32px;
		text-align: center;
		padding-top: 10px;
	}
	.city{
		border:1px solid silver;
		height:32px;
		width:412px;
		text-align:center;
		color:gray;
		padding-top: 10px;
	}
	#city_tr{
		display:none;
	}
	body {
		margin: 0px;
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
<script src="Https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	window.onload = function()
	{
		// radio
		document.mem.gender[${fdto.gender}].checked="true";
	}
	
	// 지역 변경 yes or no
	function view_locselect()
	{
		document.getElementById("city_tr").style.display="table-row";
	}
	function hide_locselect()
	{
		document.getElementById("city_tr").style.display="none";
	}
	
	// 셀렉트박스1 선택시 셀렉트박스2 옵션 변경
	function region1_change(n) 
	{  
		var target = document.getElementById("region2_select");
		var list=[];
		if(n.value == "서울")
		{	
			<c:forEach items="${seoullist}" var="seoul">
				list.push('${seoul}');
			</c:forEach>
		}
		else if(n.value == "제주") 
		{	
			<c:forEach items="${jejulist}" var="jeju">
				list.push('${jeju}');
			</c:forEach>
		}
		else if(n.value == "경기") 
		{	
			<c:forEach items="${gglist}" var="gg">
				list.push('${gg}');
			</c:forEach>
		}
		else if(n.value == "그 외")
		{	
			<c:forEach items="${citylist}" var="city">
				list.push('${city}');
			</c:forEach>
		}
	
		target.options.length = 0;
		for (i in list) 
		{
			var opt = document.createElement("option");
			opt.value = list[i];
			opt.innerHTML = list[i];
			target.appendChild(opt);
		}	
	}
</script>
</head>
<body>
<div id="section1">
<div id="join_head_main" align="center">
	<a class="join_head" href="mypage.jsp?idx=${fdto.idx}" id="join_page">회원정보변경</a>
	<a class="join_head" href="pwd_change.jsp?idx=${fdto.idx}">비밀번호변경</a>
	<a class="join_head" href="user_delete.jsp?idx=${fdto.idx}">회원탈퇴</a>
</div>
<form method="post" action="update_ok.jsp?idx=${fdto.idx}" name="mem">
	<table align="center">
		<tr>
			<td>&nbsp;</td>
			<td><strong> 수정할 내용을 입력해주세요.</strong></td>
		</tr>
		<tr>
			<td width="70">이름</td>
			<td><input type="text" name="name" placeholder="이름을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='이름을 입력해주세요.'" value="${fdto.name}">
			</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="nickname" placeholder="닉네임을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='닉네임을 입력해주세요.'" value="${fdto.nickname}">
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email" name="email" id="email"placeholder="이메일을 입력해주세요. / 예) food@foodsite.com" onfocus="this.placeholder=''" onblur="this.placeholder='이메일을 입력해주세요. / 예) food@foodsite.com'" value="${fdto.email}">
			</td>
		</tr>
		<tr>
			<td>휴대폰</td>
			<td><input type="text" name="tel" placeholder="휴대폰번호를 입력해주세요. / 예) 010-0000-0000" onfocus="this.placeholder=''" onblur="this.placeholder='휴대폰번호를 입력해주세요. / 예) 010-0000-0000'" value="${fdto.tel}">
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
			<div id="sung_td">
			<input type="radio" name="gender" value="0">선택안함
			<input type="radio" name="gender" value="1">남자
			<input type="radio" name="gender" value="2">여자
			</div>
			<span id="sung"></span>
			</td>
		</tr>
		<tr>
			<td>
			선호지역
			</td>
			<td>
			<div class="city">
			<input type="hidden" name="mylocation" value="${fdto.mylocation}">
				<c:if test="${fdto.mylocation != null}">
					${fdto.mylocation}
				</c:if>
				<c:if test="${fdto.mylocation == null}">
					없음
				</c:if>
				<input type="radio" name="myloc_radio" value="0" onclick="hide_locselect()" checked="checked">유지
				<input type="radio" name="myloc_radio" value="1" onclick="view_locselect()">변경
			</div>
			</td>
		</tr>
		<tr id="city_tr">
			<td>
				&nbsp
			</td>
			<td>
			<div class="city">
				<span>변경 지역</span>
				<select id="region1_select" name="region1_select" onchange="region1_change(this)">
					<option>-선택-</option>
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="제주">제주</option>
					<option value="그 외">그 외</option>
				</select>
				<select id="region2_select" name="region2_select">
					<option>-선택-</option>
				</select>
			</div>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="회원 정보 수정하기"></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>