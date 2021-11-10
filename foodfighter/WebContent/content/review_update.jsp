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
	height: auto;
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

<script>
</script>
<div id="section1">
	<!-- review 상세정보 -->
	<div id="review_update">
		<form id="frm" name="frm" method="post" action="review_update_ok.jsp" enctype="multipart/form-data">
			<input type="hidden" id="reviewidx" name="reviewidx" value="${rdto.idx}">
			<input type="hidden" id="restidx" name="restidx" value="${rdto.rest_idx}">
			<input type="hidden" id="useridx" name="useridx" value="${rdto.user_idx}">
			<table id="review_update_table" align="center">
				<tr>
					<th width="100">식당</th>
					<td>${rdto.restaurant}</td>
				</tr>
				<tr>
					<th width="100">평점</th>
					<td>
					<input type="text" name="range_val" id="range_val" size="2" value="${rdto.score}">
					<input type="range" name="slider" id="slider" min="0" max="50" value="${rdto.score * 10}" step="1" oninput='ShowSliderValue(this);'>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th width="100">리뷰</th>
					<td><textarea rows="20" cols="90" name="reviewcontent" id="reviewcontent">${rdto.content}</textarea></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>첨부 이미지</th>
					<td>
						<!-- review 이미지 -->
						<c:forEach items="${rdto.imagelist}" var="imglist">
							<img src="${host}${imglist.image}" width="150" name="${imglist.idx}">
						</c:forEach>
						
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<div id="uploadimage">
							<input type="button" onclick="img_add();" value="사진추가" class="review_btn2"> 
							<input type="button" onclick="img_del();" value="사진삭제" class="review_btn2">
							<p class="fname"><input type="file" name="fname1" id="review_btn3"></p>
						</div>
					</td>
				</tr>
				<tr>
					<th></th>
					<td><input type="submit" value="수정하기" class="review_btn1"></td>
				</tr>
			</table>
		</form>
	</div>
</div>

<%@ include file="../bottom.jsp"%>
