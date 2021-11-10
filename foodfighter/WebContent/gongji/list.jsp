<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@page import="com.foodfighter.gongji.GongjiDao" %> 
<%@page import="java.util.ArrayList" %>
<%@page import="com.foodfighter.gongji.GongjiDto" %>   
<%
   GongjiDao gdao=new GongjiDao();
   ArrayList<GongjiDto> list=gdao.list();
   request.setAttribute("list", list);
%>
<style>
   #section {
     width:1000px;
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

	.table a {
	text-decoration: none;
	cursor: pointer;
	color: tomato;
	}

	.table a:hover {
	opacity: 0.4;
	color:tomato;
	}

	.table th {
	border-top: 2px solid silver;
	border-bottom: 2px solid silver;
	background:#f2f2f2;
	}
	
</style>
<div class="content" align="center">
	<img src="../img/backimg.jpg" width="2000" height="400" id="img1">
	<div class="content_text"> Notice </div>
</div>
  <div id="section">
   <table width="700" align="center" class="table">
   <caption> <h3> 공지사항</h3></caption>
     <tr>
       <th> 작성자 </th>
       <th> 제 목 </th>
       <th> 조회수 </th>
       <th> 작성일 </th>
     </tr>
    <c:forEach items="${list}" var="gdto" >
     <tr>
       <td> 관리자 </td>
       <td> <a href="readnum.jsp?id=${gdto.id}"> ${gdto.title} </a> </td>
       <td> ${gdto.readnum} </td>
       <td> ${gdto.writeday} </td>
     </tr>
    </c:forEach> 
   <c:if test="${userid == 'admin'}">
    <tr>
      <td colspan="4" align="center"> <a href="write.jsp"> 글쓰기 </a> </td>
    </tr>
   </c:if>
   </table>  
  </div>
  
<%@ include file="../bottom.jsp"%>















