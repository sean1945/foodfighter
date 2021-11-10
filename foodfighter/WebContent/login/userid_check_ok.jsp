<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="food.FoodDao" %>
<%
	FoodDao fdao=new FoodDao();
	fdao.idchk_ok(request,out);
%>