<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드파이터 검색</title>
	<link rel="stylesheet" href="../css/search.css">
</head>
<body>

<%@ include file="../top.jsp"%>

<%@ page import="search.Search"%>
<%@ page import="search.SearchRestaurant"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div id="wrap">
		<div id="search_failed">
			<div id="message">
				<h2>이런! 검색에 실패했어요.</h2>
				<p>식당을 찾으시려면 검색어를 입력해 주세요!</p>
			</div>
			<form method="get" action="search.jsp">
				<input type="text" id="search" name="q" placeholder="검색하실 내용을 적어주십시오." onfocus="this.placeholder=''" onblur="this.placeholder='검색하실 내용을 적어주십시오.'">
				<label class="hidden" for="search"><button type="submit">검색하기</button></label>
			</form>
		</div>
	</div>
	
<%@ include file="../bottom.jsp"%>