<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 아이디 찾기</title>
<style>

	h2 {
		text-align: center;
	}
	
	input[type=text], input[type=password], input[type=email] {
		width: 400px;
		height: 40px;
		padding-left: 10px;
		border: 1px solid silver;
	}
	
	input[type=button] {
		width: 414px;
		height: 50px;
		background: lightsalmon;
		color: white;
		border: none;
		font-size: 20px;
		cursor: pointer;
		font-weight: bold;
	}
	
</style>
</head>
<script>
function view_id()
{
	var name=document.idchk.name.value;
	var email=document.idchk.email.value;
	var us=new XMLHttpRequest();
	us.open("get","userid_check_ok.jsp?name="+name+"&email="+email);
	us.send();
	us.onreadystatechange=function()
	{
		if(us.readyState==4)
			{
				if(us.responseText==0)
				{
					alert("이름 또는 이메일이 틀립니다.")
				}
				else
				{
					alert("당신의 아이디는"+us.responseText+" 입니다.")
				}
			}
	}
}
</script>
<body>
	<h2>아이디 찾기</h2>
<form method="post" action="userid_check_ok.jsp" name="idchk">
	<table align="center">
		<tr>
			<td><input type="text" name="name" placeholder="이름을 입력해주세요."></td>
		</tr>
		<tr>
			<td><input type="email" name="email" placeholder="이메일을 입력해주세요."></td>
		</tr>
		<tr>
			<td><input type="button" value="확인" onclick="view_id()"></td>
		</tr>
		<tr>
			<td id="view_text"><span id="view_userid"></span></td>
		</tr>
	</table>
</form>
</body>
</html>
