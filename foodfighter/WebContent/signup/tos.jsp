<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 동의약관</title>
<style>

body {
	background-color: white;
}

ul>li {
	list-style: none
}

a {
	text-decoration: none;
}

.clearfix::after {
	content: "";
	display: block;
	clear: both;
}

.clearfix{
	padding:0px;
}

#joinForm {
	width: 600px;
	margin: 0 auto;
}

ul.join_box {
	border: 1px solid #ddd;
	background-color: #fff;
	padding:0px;
}

.checkBox, .checkBox>ul {
	position: relative;
}

.checkBox>ul>li {
	float: left;
}

.checkBox>ul>li:first-child {
	width: 85%;
	padding: 15px;
	font-weight: 600;
	color: #888;
}

.checkBox>ul>li:nth-child(2) {
	position: absolute;
	top: 50%;
	right: 30px;
	margin-top: -12px;
}

.checkBox textarea {
	width: 96%;
	height: 90px;
	margin: 0 2%;
	background-color: #f7f7f7;
	color: #888;
	border: none;
}

.footBtwrap {
	margin-top: 15px;
}

.footBtwrap>li {
	width: 50%;
	height: 60px;
	float: left;
}

.footBtwrap>li>button {
	display: block;
	width: 300px;
	height: 60px;
	font-size: 20px;
	text-align: center;
	line-height: 60px;
}

.fpmgBt1 {
	background-color: #f2f2f2;
	color: #888;
	border: none;
	cursor:pointer;
}

.fpmgBt1:hover {
	opacity:0.5;
}

.fpmgBt2 {
	background-color: lightsalmon;
	color: #fff;
	border: none;
	cursor:pointer;
}

.fpmgBt2:hover {
	opacity:0.5;
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

#section1 {
	width: 1200px;
	height: 850px;
	margin: auto;
}

</style>
<script>

	function checkSelectAll()  
	{
	  // 전체 체크박스
	  const checkboxes 
	    = document.querySelectorAll('input[name="chk"]');
	  // 선택된 체크박스
	  const checked 
	    = document.querySelectorAll('input[name="chk"]:checked');
	  // select all 체크박스
	  const selectAll 
	    = document.querySelector('input[name="chkAll"]');
	  
	  if(checkboxes.length === checked.length)  
	  {
	    selectAll.checked = true;
	  }
	  else 
	  {
	    selectAll.checked = false;
	  }

	}
	
	function selectAll(selectAll)  
	{
		  const checkboxes 
		     = document.getElementsByName('chk');
		  
		  checkboxes.forEach((checkbox) => 
		  {
		    checkbox.checked = selectAll.checked
		  })
	}
	
	function checked()
	{
		var chk1=document.getElementById("chked1").checked;
		var chk2=document.getElementById("chked2").checked;
		
		if(!chk1)
		{
			alert("이용약관 동의 부분에 동의해주십시오.");
			return false;
		}
		else if(!chk2)
		{
			alert("개인정보 수집 및 이용에 대한 안내 약관에 동의해주십시오.");
			return false;
		}
	}

</script>
</head>
<body>
<div id="section1">
<div id="join_head_main" align="center">
	<span class="join_head" id="join_page">약관동의</span><span class="join_head">회원정보입력</span><span class="join_head" id="border_right">회원가입완료</span>
</div>
<form action="signup.jsp" id="joinForm">
            <ul class="join_box">
                <li class="checkBox check01">
                    <ul class="clearfix">
                        <li>이용약관, 개인정보 수집 및 이용,
                            위치정보 이용약관(선택), 프로모션 안내
                            메일 수신(선택)에 모두 동의합니다.</li>
                        <li class="checkAllBtn">
                            <input type="checkbox" name="chkAll" id="chk" class="chkAll" onclick='selectAll(this)'>
                        </li>
                    </ul>
                </li>
                <li class="checkBox check02">
                    <ul class="clearfix">
                        <li>이용약관 동의(필수)</li>
                        <li class="checkBtn">
                            <input type="checkbox" name="chk" onclick='checkSelectAll()' id="chked1" value="1"> 
                        </li>
                    </ul>
                    <textarea name="" id="">여러분을 환영합니다.
저희 푸드파이터 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 푸드파이터 서비스의 이용과 관련하여 푸드파이터 서비스를 제공하는 푸드파이터 주식회사(이하 ‘푸드파이터’)와 이를 이용하는 푸드파이터 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 푸드파이터 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
                </li>
                <li class="checkBox check03">
                    <ul class="clearfix">
                        <li>개인정보 수집 및 이용에 대한 안내(필수)</li>
                        <li class="checkBtn">
                            <input type="checkbox" name="chk" onclick='checkSelectAll()' id="chked2" value="1">
                        </li>
                    </ul>
 
                    <textarea name="" id="">여러분을 환영합니다.
저희 푸드파이터 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 푸드파이터 서비스의 이용과 관련하여 푸드파이터 서비스를 제공하는 푸드파이터 주식회사(이하 ‘푸드파이터’)와 이를 이용하는 푸드파이터 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 푸드파이터 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.       </textarea>
                </li>
                <li class="checkBox check03">
                    <ul class="clearfix">
                        <li>위치정보 이용약관 동의(선택)</li>
                        <li class="checkBtn">
                            <input type="checkbox" name="chk" onclick='checkSelectAll()'>
                        </li>
                    </ul>
 
                    <textarea name="" id="">여러분을 환영합니다.
저희 푸드파이터 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 푸드파이터 서비스의 이용과 관련하여 푸드파이터 서비스를 제공하는 푸드파이터 주식회사(이하 ‘푸드파이터’)와 이를 이용하는 푸드파이터 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 푸드파이터 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.       </textarea>
                </li>
                <li class="checkBox check04">
                    <ul class="clearfix">
                        <li>이벤트 등 프로모션 알림 메일 수신(선택)</li>
                        <li class="checkBtn">
                            <input type="checkbox" name="chk" onclick='checkSelectAll()'>
                        </li>
                    </ul>
 
                </li>
            </ul>
            <ul class="footBtwrap clearfix">
                <li><button type="button" class="fpmgBt1" onclick="location.href='../main/main.jsp' ">비동의</button></li>
                <li><button class="fpmgBt2" onclick="return checked()">동의</button></li>
            </ul>
        </form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>