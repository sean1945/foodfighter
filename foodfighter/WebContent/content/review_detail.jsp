<%@page import="com.foodfighter.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.foodfighter.content.ContentDao" %>
<%@ page import="com.foodfighter.content.ContentDto" %>
<%@ page import="com.foodfighter.content.MenuDto" %>
<%@ page import="com.foodfighter.review.ReviewDto" %>
<%
ReviewDao rdao = new ReviewDao();
ReviewDto rdto = rdao.getReview(request, response);
request.setAttribute("rdto", rdto);

//String host = "http://3.37.233.74";
String host = "..";
request.setAttribute("host", host);
%>
<style>
#section1 {
	width: 1200px;
	height: 200px;
	margin: auto;
}

#section2 {
	padding: 20px 80px;
	width: 1200px;
	height: 800px;
	margin: auto;
}

#section3 {
	width: 1200px;
	height: 800px;
	margin: auto;
}
</style>

<div id="content">
	<!-- review 이미지 -->
	<div id="content_imgbox">
		<c:forEach items="${rdto.imagelist}" var="imglist">
			<img src="${host}${imglist.image}">
		</c:forEach>
	</div>
</div>
	<!-- review 상세정보 -->
	<div id="review_detail">
		<table id="review_table">
			<tr>
				<th width="100">식당</th>
				<td>${rdto.restaurant}</td>
			</tr>
			<tr>
				<th width="100">작성자</th>
				<td>${rdto.name}</td>
			</tr>
			<tr>
				<th width="100">평점</th>
				<td>${rdto.score}</td>
			</tr>
			<tr>
				<th width="100">리뷰</th>
				<td>${rdto.content}</td>
			</tr>
			<c:if test="${idx == rdto.user_idx}">
			<tr>
				<td colspan="2"><input type="button" id="updatereview" class="review_btn1" value="수정하기" 
				onclick="javascript:location.href='review_update.jsp?rest_idx=${rdto.rest_idx}&review_idx=${rdto.idx}&user_idx=${rdto.user_idx}'"></td>
			</tr>
			</c:if>
		</table>
	</div>

<%@ include file="../bottom.jsp"%>
