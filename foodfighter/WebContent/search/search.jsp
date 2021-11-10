<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="search.Search"%>
<%@ page import="search.SearchRestaurant"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드파이터 검색</title>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=q0npl34lwr"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=q0npl34lwr&submodules=geocoder"></script>
	<script type="text/javascript" src="../js/search.js" defer></script>
	<link rel="stylesheet" href="../css/search.css">
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		if (request.getParameter("q") == null) {
			response.sendRedirect("error.jsp");
			return;
		}
		
		String query = request.getParameter("q");
		Search search = new Search();
		
		ArrayList<SearchRestaurant> list;
		if (request.getParameter("ftype") == null) {
			list = search.search(query);
		} else {
			list = search.search(query, request.getParameter("ftype"));
		}
		String[] ftypeList = search.getFtypeList(list);
		
		String host = "http://3.37.233.74";
		//String host = "..";
		request.setAttribute("host", host);
	%>
	<div id="wrap">
		<div id="search_form">
			<form method="get" action="search.jsp">
				<input type="text" id="search" name="q" value="<%=query%>" placeholder="검색하실 내용을 적어주십시오." onfocus="this.placeholder=''" onblur="this.placeholder='검색하실 내용을 적어주십시오.'">
				<label for="search" class="hidden"><button type="submit">검색하기</button></label>
			</form>
		</div>
		<h2>'<%=query%>'에 대한 카테고리</h2>
		<div id="naver_map">
			<div id="map" style="width:100%;height:400px;"></div>
			<div id="map_info"></div>
		</div>
		<c:choose>
			<c:when test="<%=list.isEmpty()%>">
				<div id="search_failed">
					<div id="message">
						<h2>찾으시는 식당이 없습니다.</h2>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<ol id="ftype_list">
					<c:forEach var="ftype" items="<%=ftypeList%>">
						<li class="ftype">
							<a href="search.jsp?q=<%=query%>&ftype=${ftype}">
								${ftype}
							</a>
						</li>
					</c:forEach>
				</ol>
				<ol id="restaurant_list">
					<c:forEach var="rest" items="<%=list%>">
						<li class="rest" data-address="${rest.getAddress()}">
							<div class="cover_image">
								<a href="../content/detail.jsp?idx=${rest.idx}" style="color:black; text-decoration:none;"><img src="${host}${rest.getImage()}"></a>
							</div>
							<div class="desc">
								<h3 class="rest_title">
									<a href="../content/detail.jsp?idx=${rest.idx}" style="color:black; text-decoration:none;"><span class="rest_score">${rest.getScore()}</span>
								${rest.getName()}</a>
								</h3>
								<span class="rest_ftype">${rest.getFtype()}</span>
								<span class="rest_price">${rest.getPrice()}</span>
							</div>
							<div class="view_map">
								<button type="button" class="map_button">지도보기</button>
							</div>
						</li>
					</c:forEach>
				</ol>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
<%@ include file="../bottom.jsp"%>