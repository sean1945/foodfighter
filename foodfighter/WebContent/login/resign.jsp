<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 재가입</title>
<style>
#section1 {
	width: 1200px;
	height: 450px;
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
		color: black;
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
	
</style>
</head>
<body>
<div id="section1">
<div id="login_cont" align="center">
<form method="post" action="login_ok.jsp">
	<table>
		<tr>
			<td colspan="2" id="login_head">기존의 <span id="login_head_color">아이디</span>로 로그인하세요.</td>
		</tr>
		<tr>
			<td colspan="2"><input type="checkbox" name="resign" value="0"><span>재가입을 원할시 체크박스에 체크를한후 로그인을해주시길 바랍니다.</span></td>
		</tr>
		<tr>
			<td><input type="text" name="userid" placeholder="아이디를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='아이디를 입력해주세요.'"></td>
			<td rowspan="2"><input type="submit" value="로그인"></td>
		</tr>
		<tr>
			<td><input type="password" name="password" placeholder="비밀번호를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호를 입력해주세요.'"></td>
		</tr>
	</table>
</form>
</div>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>