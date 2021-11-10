<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.foodfighter.review.ReviewDao" %>
<%
ReviewDao rdao = new ReviewDao();
rdao.update_ok(request, response);
 %>