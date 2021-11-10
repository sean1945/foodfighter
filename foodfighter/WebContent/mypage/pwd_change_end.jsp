<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 변경완료</title>
<style>
	#section1 {
	width: 600px;
	height: 400px;
	margin: auto;
	}
	
	#font1{
	padding-top:100px;
	font-weight:bold;
	font-size:28px;
	margin-bottom:30px;
	}
	
	#font_color{
	color:lightsalmon;
	}
	
	.fpmgBt1 {
	background-color: silver;
	color: #888;
	border: none;
	cursor:pointer;
	width:150px;
	height:50px;
	font-size:22px;
	color:white;
}

.fpmgBt1:hover {
	opacity:0.5;
}

.fpmgBt2 {
	background-color: lightsalmon;
	color: #fff;
	border: none;
	cursor:pointer;
	width:150px;
	height:50px;
	font-size:22px;
}

.fpmgBt2:hover {
	opacity:0.5;
}
</style>
</head>
<body>
<div id="section1" align="center">
  <div id="font1"> 
  	<span id="font_color">비밀번호</span> 가 변경되었습니다! <br>
  	로그인 하시겠습니까?
  </div>
  <div>
	  <button type="button" class="fpmgBt1" onclick="location.href='../main/main.jsp' ">아니오</button><button type="button" class="fpmgBt2" onclick="location.href='../login/login.jsp' ">예</button>
  </div>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>