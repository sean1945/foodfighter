<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ page import="foodfighter.searchlocal.SearchlocalDao" %>
<%@ page import="foodfighter.searchlocal.SearchlocalDto" %>
<%@ page import="foodfighter.searchlocal.SearchpageDto" %>
<%@ page import="java.util.ArrayList" %>
<%
	SearchlocalDao ldao=new SearchlocalDao();
	String[] seoullist=ldao.seoul();
	String[] gglist=ldao.gg();
	String[] jejulist=ldao.jeju();
	String[] citylist=ldao.city();
	ArrayList<SearchlocalDto> restlist=ldao.localrest(request);
	SearchpageDto pagedto=ldao.chongpage(request);
	
	request.setAttribute("seoullist",seoullist);
	request.setAttribute("gglist",gglist);
	request.setAttribute("jejulist",jejulist);
	request.setAttribute("citylist",citylist);
	request.setAttribute("restlist",restlist);
	request.setAttribute("pagedto",pagedto);
%>
<title>푸트파이터 : 전국 맛집</title>
<link rel="stylesheet" href="../css/localsearch.css"/>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=g3hb7wdw62"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=g3hb7wdw62&submodules=geocoder"></script>
<script>
	window.onload=function()  // 해당 페이지 접근시 선택 지역 색바꾸기
	{
		<c:if test="${pagedto.region1 == '서울'}">
			document.getElementsByClassName("local_li")[0].classList.add("local_menu_click");
			<c:if test="${pagedto.region2 != ''}">
				document.getElementsByClassName("local_sub_content")[0].style.display="block";
				document.getElementById("${pagedto.region2}").style.background="lightsalmon";
			</c:if>
			<c:if test="${pagedto.region2 == ''}">
				document.getElementsByClassName("local_sub_content")[0].style.display="block";
				document.getElementById("seoul_all").style.background="lightsalmon";
			</c:if>
		</c:if>
		<c:if test="${pagedto.region1 == '경기'}">
			document.getElementsByClassName("local_li")[1].classList.add("local_menu_click");
			<c:if test="${pagedto.region2 != ''}">
				document.getElementsByClassName("local_sub_content")[1].style.display="block";
				document.getElementById("${pagedto.region2}").style.background="lightsalmon";
			</c:if>
			<c:if test="${pagedto.region2 == ''}">
				document.getElementsByClassName("local_sub_content")[1].style.display="block";
				document.getElementById("gg_all").style.background="lightsalmon";
			</c:if>
		</c:if>
		<c:if test="${pagedto.region1 == '제주'}">
			document.getElementsByClassName("local_li")[2].classList.add("local_menu_click");
			<c:if test="${pagedto.region2 != ''}">
				document.getElementsByClassName("local_sub_content")[2].style.display="block";
				document.getElementById("${pagedto.region2}").style.background="lightsalmon";
			</c:if>
			<c:if test="${pagedto.region2 == ''}">
				document.getElementsByClassName("local_sub_content")[2].style.display="block";
				document.getElementById("jeju_all").style.background="lightsalmon";
			</c:if>
		</c:if>
		<c:if test="${pagedto.region1 == 'city'}">
			document.getElementsByClassName("local_li")[3].classList.add("local_menu_click");	
			<c:if test="${pagedto.region2 != ''}">
				document.getElementsByClassName("local_sub_content")[3].style.display="block";
				document.getElementById("${pagedto.region2}").style.background="lightsalmon";
			</c:if>
			<c:if test="${pagedto.region2 == ''}">
				document.getElementsByClassName("local_sub_content")[3].style.display="block";
				document.getElementById("city_all").style.background="lightsalmon";
			</c:if>
		</c:if>
	}
	function local_sub_view(n) // 다른 지역 선택시 배경색 변경 및 서브리스트 변경
	{
		for(var i=0; i<4; i++)
		{		
			document.getElementsByClassName("local_sub_content")[i].style.display="none";
			document.getElementsByClassName("local_li")[i].classList.remove("local_menu_click");
		}
		document.getElementsByClassName("local_sub_content")[n].style.display="block";
		document.getElementsByClassName("local_li")[n].classList.add("local_menu_click");
	}
	function copyurl(){   //  url 공유하기
        var url=document.createElement("input");
        var text=location.href;    
        document.body.appendChild(url);
        url.value = text;
        url.select();
        document.execCommand("copy");
        document.body.removeChild(url);
        alert("url이 복사되었습니다");
    }
</script>
<div id="section1">
	<div>
		<div id="local_title">믿고보는 지역별 맛집리스트!</div>
		<ul id="local_menu">
			<a href="#" onclick="local_sub_view(0)"><li class="local_li">서울</li></a>
			<a href="#" onclick="local_sub_view(1)"><li class="local_li">경기</li></a>
			<a href="#" onclick="local_sub_view(2)"><li class="local_li">제주</li></a>
			<a href="#" onclick="local_sub_view(3)"><li class="local_li">전국</li></a>
		</ul>
	</div>
	<div class="local_sub_content">
		<ul>
			<a href="localsearch.jsp?region1=서울"><li id="seoul_all">전체</li></a>
			<c:forEach items="${seoullist}" var="seoul">
				<a href="localsearch.jsp?region1=서울&region2=${seoul}"><li id="${seoul}">${seoul}</li></a>
			</c:forEach>
		</ul>
	</div>
	<div class="local_sub_content">
		<ul>
			<a href="localsearch.jsp?region1=경기"><li id="gg_all">전체</li></a>
			<c:forEach items="${gglist}" var="gg">
				<a href="localsearch.jsp?region1=경기&region2=${gg}"><li id="${gg}">${gg}</li></a>
			</c:forEach>
		</ul>
	</div>
	<div class="local_sub_content">
		<ul>
			<a href="localsearch.jsp?region1=제주"><li id="jeju_all">전체</li></a>
			<c:forEach items="${jejulist}" var="jeju">
				<a href="localsearch.jsp?region1=제주&region2=${jeju}"><li id="${jeju}">${jeju}</li></a>
			</c:forEach>
		</ul>
	</div>
	<div class="local_sub_content">
		<ul>
			<a href="localsearch.jsp?region1=city"><li id="city_all">전체</li></a>
			<c:forEach items="${citylist}" var="city">
				<a href="localsearch.jsp?region1=city&region2=${city}"><li id="${city}">${city}</li></a>
			</c:forEach>
		</ul>
	</div>
</div>
<div id="section2">
	<div id="map">
	</div>

	<script>
	// 지역포커스 지도 생성을 위한 스크립트
	var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 12
	}
	var map = new naver.maps.Map('map', mapOptions);
	var myaddress;// 이곳에 주소를 넣어주세요. 도로명 주소나 지번 주소만 가능
	if("${pagedto.region2}"=="")
	{
		myaddress = "${pagedto.region1}";
	}
	else
	{
		myaddress = "${pagedto.region2}";
	}
	naver.maps.Service.geocode({address: myaddress}, function(status, response) {

	    if (status !== naver.maps.Service.Status.OK) 
	    {
	        return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
	    }
	    var result = response.result;
	    var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
	    map.setCenter(myaddr); // 검색된 좌표로 지도 이동
	    
	});// geocode_end 

	// 식당 표시 마커 생성
	<c:forEach items="${restlist}" var="rest">
	    var restaurant = "${rest.addr1}";// 도로명 주소 좌표로 변경하기
		naver.maps.Service.geocode({address: restaurant}, function(status, response) {
		    if (status !== naver.maps.Service.Status.OK) 
		    {
		        return alert(restaurant + '의 검색 결과가 없거나 기타 네트워크 에러');
		    }
		    var result = response.result;
		    var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		    
		    var div_text = '<div style="width:300px; position:absolute; top:10px; left:33px; text-align:left; color:red; font-weight:bold; font-size:12px;">${rest.name}</div>';
		    var marker = new naver.maps.Marker({
		    	position: new naver.maps.LatLng(myaddr), // 식당의 위도 경도 넣기 
		        map: map,
		        title: "${rest.name}", // 식당 이름    
		    });

		}); // restaurant geocode end
	</c:forEach>
	</script>
</div>
<div id="section3">
	<button id="copy" onclick="copyurl()"><img  src="../img/copy.png">공유하기</button>
	<ul>
		<c:forEach items="${restlist}" var="ldto">
		<li><a href="../content/detail.jsp?region1=${pagedto.region1}&region2=${pagedto.region2}&page=${pagedto.page}&idx=${ldto.rest_idx}"><img src="..${ldto.image}" onerror="this.src='../img/noimg.jpg'"/></a>
			<div class="li_text">
				<h3><a href="../content/detail.jsp?region1=${pagedto.region1}&region2=${pagedto.region2}&page=${pagedto.page}&idx=${ldto.rest_idx}">${ldto.name} - <span>${ldto.resscore}</span></a></h3>
				<div class="restaurant_more">(${ldto.cnt} view)</div>
				${ldto.addr1}<p>
				카테고리 : ${ldto.ftype}<br>
				가격대 : ${ldto.rangeprice} &nbsp&nbsp&nbsp&nbsp
				<c:if test="${ldto.menu_cnt != 0}">
				메뉴 수 : ${ldto.menu_cnt}<p>
				</c:if><p>
				등록된 리뷰 : ${ldto.review_cnt}개<br>
				<div class="restaurant_more">
				<a href="../content/detail.jsp?region1=${pagedto.region1}&region2=${pagedto.region2}&page=${pagedto.page}&idx=${ldto.rest_idx}">"${ldto.name}" 더 보기></a>
				</div>
			</div>
		</li>
		</c:forEach>
	</ul>
	<div id="section3_page">
		<!-- 이전페이지  -->
		<c:if test="${pagedto.page==1}">
			<span class="paging">◀</span>
		</c:if>
		<c:if test="${pagedto.page!=1}">
			<a href="localsearch.jsp?region1=${pagedto.region1}&region2=${pagedto.region2}&page=${pagedto.page-1}">◀</a>
		</c:if>
		
		<!-- 페이지 수 출력 -->
		<c:forEach begin="${pagedto.pstart}" end="${pagedto.pend}" var="i">
			<c:set var="str" value=""/>
			<c:if test="${pagedto.page == i}">
				<c:set var="str" value="style='color:lightsalmon'"/>
			</c:if>
			<a href="localsearch.jsp?region1=${pagedto.region1}&region2=${pagedto.region2}&page=${i}" ${str}>${i}</a>
		</c:forEach>
		
		<!-- 다음페이지  -->
		<c:if test="${pagedto.page==pagedto.chong}">
			<span class="paging">▶</span>
		</c:if>
		<c:if test="${pagedto.page!=pagedto.chong}">
			<a href="localsearch.jsp?region1=${pagedto.region1}&region2=${pagedto.region2}&page=${pagedto.page+1}">▶</a>
		</c:if>
	</div>
</div>

<%@ include file="../bottom.jsp"%>
