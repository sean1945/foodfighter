<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ page import="foodfighter.searchlocal.SearchlocalDao" %>
<% 
	SearchlocalDao ldao=new SearchlocalDao();
	String[] seoullist=ldao.seoul();
	String[] gglist=ldao.gg();
	String[] jejulist=ldao.jeju();
	String[] citylist=ldao.city();
	
	
	request.setAttribute("seoullist",seoullist);
	request.setAttribute("gglist",gglist);
	request.setAttribute("jejulist",jejulist);
	request.setAttribute("citylist",citylist);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 회원가입</title>
<style>
	#section1 {
	width: 1200px;
	height: 1200px;
	margin: auto;
	}
	
	h2{text-align:center;}
	#pwd1,#pwdchk1,#name,#birthday1,#email1,#phone,#uk,#sung,#nickname,#captcha_text{
	font-size:14px;
	padding-top:5px; 
	padding-bottom:3px; 
	display:inline-block;
	}
	
	span{
	text-align:center;
	}
	
	#userid{
	width:330px;
	height:40px; 
	padding-left:10px; 
	border:1px solid silver;
	}
	
	input[type=text],input[type=password],input[type=email]{
	width:400px; 
	height:40px; 
	padding-left:10px; 
	border:1px solid silver;
	}
	
	input[type=submit]{
	width:414px; 
	height:50px; 
	background:lightsalmon; 
	color:white; 
	border:none; 
	font-size:18px; 
	cursor:pointer; 
	font-weight:bolder;
	}
	
	input[type=button]{
	width:70px; 
	height:44px; 
	background:white; 
	border:1px solid silver; 
	font-size:14px; cursor:pointer; 
	border-left:none;padding-top:0px; 
	padding-bottom:3px; 
	font-weight:bolder;
	}
	
	input:focus {outline:none;}
	
	#sung_td{
	color:gray; 
	border:1px solid silver; 
	width:412px; height:32px; 
	text-align:center; 
	padding-top:10px;
	}
	
	#lable1,#lable2,#lable3{
	margin-left:10px;
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
	
	#frmSubmit{
	border-left:1px solid silver;
	}
	
	#reLoad{
	border-left:1px solid silver;
	}
	
	#answer{
	width:325px;
	}
	
	#soundOn{
	margin-bottom:15px;
	border-left:1px solid silver;
	}
	
	#catpcha{
	margin-bottom:10px;
	}
	
	#city{
	border:1px solid silver;
	height:40px;
	text-align:center;
	color:gray;
	}
</style>
<script>
/*
 * Captcha Image 요청
 * [주의] IE의 경우 captcha_img.jsp 호출시 매번 변하는 임의의 값(의미없는 값)을 파라미터로 전달하지 않으면
 * '새로고침'버튼을 클릭해도 captcha_img.jsp가 호출되지 않는다. 즉, 이미지가 변경되지 않는 문제가 발생한다.
 *  그러나 크롬의 경우에는 파라미터 전달 없이도 정상 호출된다.
 */
function changeCaptcha() {
	//IE에서 '새로고침'버튼을 클릭시 captcha_img.jsp가 호출되지 않는 문제를 해결하기 위해 "?rand='+ Math.random()" 추가
	<%-- //$('#catpcha').html('<img src="<%=ctx %>/1013/captcha_img.jsp?rand='+ Math.random() + '"/>'); --%>
	$('#catpcha').html('<img src="${pageContext.request.contextPath}/signup/captcha_img.jsp?rand='+ Math.random() + '"/>');
}

function winPlayer(objUrl) {
    $('#audiocatpcha').html('<bgsound src="' + objUrl + '">');
}
 
/*
 * Captcha Audio 요청
 * [주의] IE의 경우 captcha_audio.jsp 호출시 매번 매번 변하는 임의의 값(의미없는 값)을 파라미터로 전달하지 않으면
 * '새로고침'된 이미지의 문자열을 읽지 못하고 최초 화면 로드시 로딩된 이미지의 문자열만 읽는 문제가 발생한다.
 * 이 문제의 원인도 결국 매번 변하는 파라미터 없이는 CaptChaAudio.jsp가 호출되지 않기 때문이다.
 * 그러나 크롭의 경우에는 파라미터 전달 없이도 정상 호출된다. 
 */
 
function audioCaptcha() {
	var uAgent = navigator.userAgent;
	var soundUrl = 'captcha_audio.jsp';
	if (uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1) {
	    //IE일 경우 호출
	    winPlayer(soundUrl+'?agent=msie&rand='+ Math.random());
	} else if (!!document.createElement('audio').canPlayType) {
	    //Chrome일 경우 호출
	    try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
	} else {
		window.open(soundUrl, '', 'width=1,height=1');
	}
}

var passchk = false;
function checkaudit(response) {
	var result = JSON.parse(response);
	console.log(result);
	$('#captcha').html(result);
	var resultext = $('#captcha').text();
	console.log(resultext);

  	if (resultext == 'true' ) {
		$('#answer').attr('readonly', true);
		passchk = true;
		alert('입력한 값이 일치합니다!!');
	} else {
		passchk = false;
		alert('입력하신 값이 일치하지 않습니다 새로고침을 눌러 재입력해주세요.');
		
	}
	
}

//화면 호출시 가장 먼저 호출되는 부분
$(document).ready(function() {
	
	changeCaptcha(); //Captcha Image 요청

	//'새로고침'버튼의 Click 이벤트 발생시 'changeCaptcha()'호출
	$('#reLoad').click(function() {
		changeCaptcha();
		$('#answer').attr('readonly', false);
		$('#answer').val('');
		$('#captcha').val('wrong');
	});
	
	//'음성듣기'버튼의 Click 이벤트 발생시 'audioCaptcha()'호출
	$('#soundOn').click(function() {
		audioCaptcha();
	});

	//'확인' 버튼 클릭시
	$('#frmSubmit').click(function() {
		if (!$('#answer').val()) {
			alert('이미지에 보이는 숫자 또는 스피커를 통해 들리는 숫자를 입력해 주세요.');
			$('#captcha').val('wrong');
		} else {
			$.ajax({
				url : 'captcha_submit.jsp',
				type : 'POST',
				dataType : 'text',
				data : 'answer=' + $('#answer').val(),
				async : false,
				success : function(response) {
					//alert(response);
					//$('#reLoad').click();
					//$('#answer').val('');
					checkaudit(response);
				}
			});
		}
	});
	
});

	function captcha_text()
	{
		document.getElementById("captcha_text").innerText="";
	}
	
	// 아이디 중복체크 확인 여부.
	function check()
	{
		var chk=new XMLHttpRequest();
		var userid=document.mem.userid.value;
		chk.open("get","userid_check.jsp?userid="+userid);
		chk.send();
		
		chk.onreadystatechange=function()
		{
			if(chk.readyState==4) // 완료된 상태
				{
					if(chk.responseText==1 || userid == "")
						{
							document.getElementById("uk").innerText="사용 불가능한 아이디입니다.";
							document.getElementById("uk").style.color="tomato";
							document.getElementById("idhidden").value="0";
							
						}
					else
						{
							document.getElementById("uk").innerText="사용 가능한 아이디입니다.";
							document.getElementById("uk").style.color="black";
							document.getElementById("idhidden").value="1";

						}
				}
		}
	}
	
	// 회원가입시 유효성검사 체크부분
	function requireds1()
	{
		// 인증번호 유효성체크
		if(passchk == false)
		{
			document.getElementById("captcha_text").innerText="인증번호를 입력하고 확인버튼을 눌러주세요.";
        	document.getElementById("captcha_text").style.color="tomato";
        	return false;
		}
		else if(document.mem.answer.value.length < 6)
		{
			document.getElementById("captcha_text").innerText="인증번호를 6자리를 입력해주세요.";
        	document.getElementById("captcha_text").style.color="tomato";
        	return false;
		}
		else
		{
			document.getElementById("captcha_text").innerText="";
		}
		
		

		// 아이디 유효성체크
        var p1 = document.getElementById('password').value;
        var p2 = document.getElementById('pwdchk').value;
        
		if(document.mem.userid.value=="" || document.getElementById("idhidden").value == 0)
		{
			document.getElementById("uk").innerText="아이디를 입력후 중복확인을 눌러주세요.";
        	document.getElementById("uk").style.color="tomato";
        	document.getElementById("userid").focus();
        	return false;
		}
      
		
		
		// 비밀번호 유효성체크
        if(p1.length < 1) 
        {
        	document.getElementById("pwd1").innerText="비밀번호는 1글자 이상이어야 합니다.";
        	document.getElementById("pwd1").style.color="tomato";
        	document.getElementById("password").focus();
        	return false;
        	
        }
        else
        {
        	document.getElementById("pwd1").innerText="사용가능한 비밀번호입니다.";
        	document.getElementById("pwd1").style.color="black";
        }
        if(p1 != p2 || p1=="") 
        {
        	document.getElementById("pwdchk1").innerText="비밀번호가 일치하지 않습니다.";
        	document.getElementById("pwdchk1").style.color="tomato";
        	document.getElementById("pwdchk").focus();
        	return false
        } 
        else
        {
        	document.getElementById("pwdchk1").innerText="비밀번호가 일치합니다.";
        	document.getElementById("pwdchk1").style.color="black";
        }
		
        
        
    	 // 이름 유효성체크
		if(document.mem.name.value=="")
		{
			document.getElementById("name").innerText="이름은 필수입력 입니다.";
        	document.getElementById("name").style.color="tomato";
        	document.getElementById("name2").focus();
        	return false;
		}
		else
		{
			document.getElementById("name").innerText="";
		}
		
    	 
		
		// 닉네임 유효성체크
		if(document.mem.nickname.value=="")
		{
			document.getElementById("nickname").innerText="닉네임은 필수입력 입니다.";
        	document.getElementById("nickname").style.color="tomato";
        	document.getElementById("nickname2").focus();
        	return false;
		}
		else
		{
			document.getElementById("nickname").innerText="";
		}
		

		
		// 이메일 유효성체크
		var email = document.getElementById("email").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		
		if(document.mem.email.value == "")
		{
			document.getElementById("email1").innerText="이메일을 입력해주세요.";
        	document.getElementById("email1").style.color="tomato";
        	document.getElementById("email").focus();
        	return false;
		}
		else if(exptext.test(email)==false)
		{

			document.getElementById("email1").innerText="이메일 형식이 올바르지 않습니다.";
			document.getElementById("email1").style.color="tomato";
			document.addjoin.email.focus();
			return false;

		}
		else
		{
			document.getElementById("email1").innerText="";
		}

		
		
		// 휴대폰번호 유효성체크
		$(document).on("keyup", ".phoneNumber", function() { 
			
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
			
		});

		if(document.mem.tel.value=="")
		{
			document.getElementById("phone").innerText="휴대폰번호를 입력해주세요.";
        	document.getElementById("phone").style.color="tomato";
        	document.getElementById("tel").focus();
        	return false;
		}
		else if(document.mem.tel.value.length < 13)
		{
			document.getElementById("phone").innerText="전화번호를 다시 입력해주세요.";
        	document.getElementById("phone").style.color="tomato";
        	document.getElementById("tel").focus();
        	return false;
		}
		else
		{
			document.getElementById("phone").innerText="";
		}
		
		
		
		// 성별 유효성체크
		var sungcheck = $('input[name=gender]').is(':checked');
		if(sungcheck == false)
		{
			document.getElementById("sung").innerText="성별을 체크해주세요.";
        	document.getElementById("sung").style.color="tomato";
        	return false;
		}
		else
		{
			document.getElementById("sung").innerText="";
		}
		
		
		
				
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
	<span class="join_head">약관동의</span><span class="join_head" id="join_page">회원정보입력</span><span class="join_head" id="border_right">회원가입완료</span>
</div>
<form method="post" action="signup_ok.jsp" name="mem">
	<table align="center">
		<tr>
			<td><input type="text" name="userid" id="userid" placeholder="아이디를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='아이디를 입력해주세요.'" maxlength="50"><input type="button" onclick="check()" value="중복확인">
				<br><span id="uk"></span>
			</td>
		</tr>
		<tr>
			<td><input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호를 입력해주세요.'" maxlength="20">
			<br> <span id="pwd1"></span> 
			</td>
		</tr>
		<tr>
			<td><input type="password" name="pwdchk" id="pwdchk" placeholder="비밀번호를 한번더 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호를 한번더 입력해주세요.'" maxlength="20">
			<br> <span id="pwdchk1"></span>
			</td>
			
		</tr>
		<tr>
			<td><input type="text" name="name" id="name2" placeholder="이름을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='이름을 입력해주세요.'" maxlength="20">
			<br> <span id="name"></span>
			</td>
		</tr>
		<tr>
			<td><input type="text" name="nickname" id="nickname2" placeholder="닉네임을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='닉네임을 입력해주세요.'" maxlength="20">
			<br> <span id="nickname"></span>
			</td>
		</tr>
		<tr>
			<td><input type="email" name="email" id="email" placeholder="이메일을 입력해주세요. / 예) food@foodsite.com" onfocus="this.placeholder=''" onblur="this.placeholder='이메일을 입력해주세요. / 예) food@foodsite.com'" maxlength="50">
			<br> <span id="email1"></span>
			</td>
		</tr>
		<tr>
			<td><input type="text" name="tel" id="tel" class="phoneNumber" placeholder="휴대폰번호를 입력해주세요. / 예) 010-0000-0000" onfocus="this.placeholder=''" onblur="this.placeholder='휴대폰번호를 입력해주세요. / 예) 010-0000-0000'" maxlength="13">
			<br> <span id="phone"></span>
			</td>
		</tr>
		<tr>
			<td>
			<div id="sung_td">
			<input type="radio" name="gender" id="label1" value="0"><label for="label1">선택안함</label>
			<input type="radio" name="gender" id="label2" value="1"><label for="label2">남자</label>
			<input type="radio" name="gender" id="label3" value="2"><label for="label3">여자</label>
			</div>
			<span id="sung"></span>
			</td>
		</tr>
		<tr>
			<td id="city">
				<span>지역 : </span>
				<select id="region1_select" name="region1_select" onchange="region1_change(this)">
					<option>선택안함</option>
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="제주">제주</option>
					<option value="그 외">그 외</option>
				</select>
				<select id="region2_select" name="region2_select">
					<option>선택안함</option>
				</select>
				<br><span id="region"></span>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
			    <div id="section" align="center">
			        <div id="catpcha">Wait...</div>
			        <div id="audiocatpcha" style="display: none;"></div>
			        
			        <input id="reLoad" type="button" value="새로고침" />
			        <input id="soundOn" type="button" value="음성듣기" />
			        <br />
			        <input type="text" id="answer" name="answer" value="" placeholder="인증번호를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='인증번호를 입력해주세요.'" maxlength="6"/>
			        <input type="hidden" id="captcha" name="captcha" value="wrong" />
			        <input type="button" id="frmSubmit" value="확인" onclick="captcha_text()"/><br>
			        <span id="captcha_text"></span>
			    </div>
			</td>
		</tr>
		<tr>
			<td colspan="8"><input type="submit" value="회원가입" onclick="return requireds1()"></td>
		</tr>
	</table>
<input type="hidden" id="idhidden" value="0">
</form>
</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>