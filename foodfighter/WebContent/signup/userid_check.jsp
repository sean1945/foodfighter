<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="food.FoodDao" %>
<%
	// 사용자가 입력한 아이디를 테이블에 검색하여 존재하는지 없는지를 전달
	FoodDao fdao=new FoodDao();
	int chk=fdao.userid_chk(request);
	out.print(chk);
%>