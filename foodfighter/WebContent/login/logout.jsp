<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션을 지우고 메인페이지로 이동
	session.invalidate();
	
	response.sendRedirect("../main/main.jsp");
%>