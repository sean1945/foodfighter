<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>    
<style>
   #section {
     width:1000px;
     height:600px;
     margin:auto;
     text-align:center;
   }
   input[type=text] {
     width:400px;
     height:40px;
     border:1px solid silver;
     font-size:17px;
   }
   input[type=submit]
   {
     width:406px;
     height:42px;
     border:1px solid lightsalmon;
     font-size:17px;
     background:lightsalmon;
     color:white;
   }
   textarea {
     width:400px;
     height:200px;
     border:1px solid silver;
   }
   #tt {
    font-size:20px;
    color:black;
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
	
</style>
<div class="content" align="center">
	<img src="../img/backimg.jpg" width="2000" height="400" id="img1">
	<div class="content_text"> Write </div>
</div>
  <div id="section">
   <div id="tt"> 공지사항 글쓰기</div> <p>
   <form method="post" action="write_ok.jsp">
     <input type="text" name="title" placeholder="제 목"> <p>
     <textarea cols="40" rows="6" name="content" placeholder="내용 작성"></textarea><p>
     <input type="submit" value="공지사항 저장">
   </form>
  
  </div>
  
<%@ include file="../bottom.jsp"%>