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
ContentDao cdao = new ContentDao();
ContentDto cdto = cdao.getRecord(request);
ArrayList<String> imglist = cdao.getRestaurantImgList(request);
ArrayList<MenuDto> mdto = cdao.getMenus(request);
ReviewDao rdao = new ReviewDao();
ArrayList<ReviewDto> reviewlist = rdao.list(request, response);

request.setAttribute("cdto", cdto);
request.setAttribute("imglist", imglist);
request.setAttribute("mdto", mdto);
request.setAttribute("reviewlist", reviewlist);

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
<div id="content_head" align="center">
	<!-- 레스토랑 이미지 -->
	<div id="content_imgbox">
		<c:forEach items="${imglist}" var="imglist">
			<img src="${host}${imglist}">
		</c:forEach>
	</div>
</div>
<div id="content">
	<!-- 레스토랑 상세정보 -->
	<div id="content_detail">
		<div id="content_rating">
			<h1>${cdto.name}</h1>
			<strong class="rate-point"><span>★${cdto.score}</span></strong>
			<span> / <fmt:formatNumber value="${cdto.cnt}"/></span>
			<button id="modal-open"><span id="addr_rectangle">리뷰쓰기</span></button>
		</div>
		<div>
			<table>
				<!-- <caption>레스토랑 상세정보</caption> -->
				<tr>
					<th>주소</th>
					<td><span id="addr_rectangle">도로명</span>${cdto.addr1}<br><span id="addr_rectangle">지번</span>${cdto.addr2}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${cdto.tel}</td>
				</tr>
				<tr>
					<th>음식종류</th>
					<td>${cdto.ftype}</td>
				</tr>
				<tr>
					<th>가격대</th>
					<td>${cdto.price}</td>
				</tr>
				<tr>
					<th>주차여부</th>
					<td>${cdto.parking}</td>
				</tr>
				<tr>
					<th>영업시간</th>
					<td>${cdto.runtime}</td>
				</tr>
				<tr>
					<th>마지막 주문</th>
					<td>${cdto.lastorder}</td>
				</tr>
				<tr>
					<th>휴뮤일</th>
					<td>${cdto.holiday}</td>
				</tr>
				<tr>
					<th>쉬는시간</th>
					<td>${cdto.breaktime}</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td>${cdto.homepage}</td>
				</tr>
				<tr>
					<th>메뉴</th>
					<td>
						<c:forEach items="${mdto}" var="mdto">
							<div id="menulist">
								<span>${mdto.menu}</span><span><fmt:formatNumber value="${mdto.price}" />원</span>
							</div>
						</c:forEach>
					</td>
				</tr>
			</table>
			<p align="right">등록일 : ${cdto.regdate}</p>
		</div>		
	
	</div>
	<!-- 리뷰 목록 -->
	<div id="content_review">
		<table>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<c:forEach items="${reviewlist}" var="reviewlist">
			<tr>
				<td colspan="2">조회수 : <fmt:formatNumber value="${reviewlist.cnt}"/> / 등록일 : ${reviewlist.regdate}</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="user_center">
					<div id="user_img" onclick="location='review_detail.jsp?rest_idx=${cdto.idx}&review_idx=${reviewlist.idx}&user_idx=${reviewlist.user_idx}'"><img src="../img/pro.png" width="50" height="50"></div>
					<a href="review_detail.jsp?rest_idx=${cdto.idx}&review_idx=${reviewlist.idx}&user_idx=${reviewlist.user_idx}">${reviewlist.name}</a><br>
					 <a>${reviewlist.score}</a>
				</td>
				<td style="padding-left:10px;">${reviewlist.content}</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
 					<c:forEach items="${reviewlist.imagelist}" var="reviewimglist">
					<img alt="" src="${host}${reviewimglist.image}" width="100" height="100">
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<!-- 리뷰 쓰기 -->
	<div class="container">		<!-- 컨테이너 -->
		<div class="popup-wrap" id="popup">			<!-- 모달을 감쌀 박스 -->
			<div class="popup">				<!-- 실질적 모달팝업 -->
				<div class="popup-head">	<!-- 로고 영역 --> 
					<span class="head-title">리뷰 작성</span>
				</div>
				<div class="popup-body">					<!-- 컨텐츠 영역 -->
					<div class="body-content">
 						<div class="body-titlebox">
							<h2>${cdto.name}</h2>
						</div>
						<div class="body-contentbox">
							<form name="frm" id="frm" method="post" action="review_ok.jsp" enctype="multipart/form-data">
							<!-- <form name="frm" id="frm" method="post" action="review_ok.jsp"> -->
								<input type="hidden" name="idx" value="${cdto.idx}">
								<input type="hidden" name="useridx" value="${idx}">
								point : <input type="text" name="range_val" id="range_val" size="2" value="5.0">
								<input type="range" name="slider" id="slider" min="0" max="50" value="50" step="1" oninput='ShowSliderValue(this);'><br><br>
								<textarea rows="20" cols="60" name="reviewcontent"></textarea><br><br>
								<div id="uploadimage">
									<input type="button" onclick="img_add();" value="사진추가" class="pop-img-btn">
									<input type="button" onclick="img_del();" value="사진삭제" class="pop-img-btn">
									<p class="fname"><input type="file" name="fname1"></p>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="popup-foot">	<!-- 푸터 버튼 영역 --> 
					<!-- <span class="pop-btn confirm" id="confirm">확인</span><span class="pop-btn close" id="close">취소</span> -->
					<span class="pop-btn" id="confirm">리뷰 등록</span><span class="pop-btn" id="close">취소</span>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../bottom.jsp"%>
