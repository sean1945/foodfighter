<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.foodfighter.gongji.GongjiDao" %>    
<%
    // 해당레코드 삭제한 후 list로 이동
    GongjiDao gdao=new GongjiDao();
    gdao.delete_admin(request,response);
%>