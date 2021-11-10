<%@ page session="true" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="nl.captcha.Captcha"%>
<%
response.setHeader("Pragma-directive", "no-cache");
response.setHeader("Cache-directive", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);

//Captcha.NAME = 'simpleCaptcha'
Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
String answer = request.getParameter("answer"); //사용자가 입력한 문자열
if (answer != null && !"".equals(answer)) {

	if (captcha.isCorrect(answer)) { //사용자가 입력한 문자열과 CaptCha 클래스가 생성한 문자열
		session.removeAttribute(Captcha.NAME);
		out.print("true");
	} else {
		out.print("false");
		
	}
}
%>