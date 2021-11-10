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
	request.setAttribute("chk", request.getParameter("chk"));
	request.setAttribute("pwd4", request.getParameter("pwd4"));
	request.setAttribute("pwd", request.getParameter("pwd"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 비밀번호 변경</title>
<style>

	#section1 {
	width: 1200px;
	height: 500px;
	margin: auto;
	}
	
	.table input[type=text],input[type=password],input[type=email]{
	width:400px; 
	height:40px; 
	padding-left:10px;
	border:1px solid silver;
	margin:5px;
	}
	
	.table input[type=submit]{
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
	
	#pwdfont{
	color:tomato;
	margin-top:5px;
	}
	
	body{
	margin:0px;
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
</head>
<body>
<div id="section1">
<div id="join_head_main" align="center">
	<a class="join_head" href="mypage.jsp?idx=${fdto.idx}">회원정보변경</a>
	<a class="join_head" href="pwd_change.jsp?idx=${fdto.idx}" id="join_page">비밀번호변경</a>
	<a class="join_head" href="user_delete.jsp?idx=${fdto.idx}">회원탈퇴</a>
</div>
	<div>
	<table class="table" align="center" width="600">
		<tr>
			<td align="center">
				<form method="post" action="pwd_change_ok.jsp?idx=<%=idx%>">
					<input type="text" name="pwd4" placeholder="현재 비밀번호를 입력해주세요." value="${pwd4}"><br>
					<input type="text" name="pwd" placeholder="변경하실 새 비밀번호를 입력해주세요." value="${pwd}"><br>
					<input type="text" name="pwd3" placeholder="새 비밀번호를 다시 한 번 입력해주세요."><br>
					<c:if test="${chk == 1}">
						<div id="pwdfont"> 비밀번호가 기존과 동일합니다. 다시입력해주세요.</div>
					</c:if>
					<c:if test="${chk == 2}">
						<div id="pwdfont"> 비밀번호는 필수입력입니다. </div>
					</c:if>
					<c:if test="${chk == 3}">
						<div id="pwdfont"> 새 비밀번호가 틀립니다 다시 한 번 입력해주세요. </div>
					</c:if>
					<c:if test="${chk == 4}">
						<div id="pwdfont"> 현재 비밀번호가 다릅니다. </div>
					</c:if>
					<c:if test="${chk == 5}">
						<div id="pwdfont"> 새 비밀번호를 한번더 입력해주세요. </div>
					</c:if>
					<input type="submit" value="변경하기">
				</form>
			</td>
		</tr>
	</table>
</div>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>