<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>  
<%@page import="com.foodfighter.gongji.GongjiDao" %>
<%@page import="com.foodfighter.gongji.GongjiDto" %>
<%
    GongjiDao gdao=new GongjiDao();
    GongjiDto gdto=gdao.content(request);
    
    request.setAttribute("gdto", gdto);
%>  
<style>
   #section {
     width:1400px;
     height:600px;
     margin:auto;
   }
   
   .content_text {
	position:relative;
	top:-380px;
	left:-600px;
	color:white;
	font-size:150px;
	text-shadow:4px 4px 0px gray;
	}
	
	.content {
	width: 2100;
	height: 400px;
	margin-bottom: 50px;
	position:relative;
	}
	
	.table{
	border-collapse:collapse;
	}
	
	.table th, .table td {
	border: 1px solid silver;
	padding: 15px;
	border-right: none;
	border-left: none;
	color: gray;
	text-align:center;
	}
	
	.table th{
	background:#f2f2f2;
	}
	
	.table a {
	text-decoration: none;
	cursor: pointer;
	color: tomato;
	}

	.table a:hover {
	opacity: 0.4;
	color:tomato;
	}
	
</style>
<div class="content" align="center">
	<img src="../img/backimg.jpg" width="2000" height="400" id="img1">
	<div class="content_text"> Content </div>
</div>
  <div id="section">
    <table width="1200" align="center" class="table">
      <caption> <h3> 공지사항</h3></caption>
      <tr>
        <th width="100"> 제목 </th>
        <td colspan="3"> ${gdto.title} </td>
      </tr>
      <tr height="200">
        <th> 내용 </th>
        <td colspan="3"> ${gdto.content} </td>
      </tr>
      <tr>
        <th> 조회수 </th>
        <td> ${gdto.readnum} </td>
        <td> 작성일 </td>
        <td> ${gdto.writeday} </td>
      </tr>
      <tr>
        <td colspan="4" align="center">
           <a href="list.jsp" style="color:black;"> 목록가기 </a>
          <c:if test="${userid == 'admin'}">
           <a href="delete.jsp?id=${gdto.id}"> 삭제 </a>
          </c:if>
        </td>
      </tr>
    </table>
  
  </div>
  
<%@ include file="../bottom.jsp"%>