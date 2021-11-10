<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodfighter.gongji.GongjiDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	GongjiDao gdao = new GongjiDao();
	request.setAttribute("list", gdao.list());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FoodFighter : 관리자페이지</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap.min.css">
<script src="https://unpkg.com/boxicons@2.0.9/dist/boxicons.js"></script>
<style>
	.table th, .table td {
	border: 1px solid silver;
	padding: 15px;
	border-right: none;
	border-left: none;
	color: gray;
	}
	
	body{
	margin:0px;
	}
	
	.table th{
	background:#f2f2f2;
	}
	
	.table{
	border-collapse:collapse;
	}
	
	#member_head{
	margin:auto;
	height:100px;
	background:silver;
	margin-bottom:50px;
	}
	
	#member_head_text{
	color:white;
	font-weight:bold;
	font-size:28px;
	}
	
	#member_head_text_small{
	color:white;
	font-weight:bold;
	font-size:20px;
	}
	
	#member_head_line{
	padding-left:50px;
	padding-top:15px;
	width:270px;
	height:100px;
	border-right:1px dotted white;
	display:inline-block;
	}
	
	.member_head_menu{
	width:70px;
	height:70px;
	border-radius:10%;
	display:inline-block;
	background:white;
	position:relative;
	left:50px;
	top:-6px;
	margin-right:50px;
	text-align:center;
	font-weight:bold;
	cursor:pointer;
	padding-top:10px;
	}
	
	.table td{
	text-align:center;
	}
	
	.tomato{
	color:#A52A2A;
	cursor:pointer;
	}
	
	#tomato2{
	color:red;
	}
	
	#example{
	text-align:center;
	}
	
	#table_margin{
	width:1800px;
	margin:auto;
	margin-bottom:100px;
	}
	
	#review_content_color{
	color:black;
}

	#member_head_back{
	width:70px;
	height:70px;
	border-radius:10%;
	display:inline-block;
	background:lightsalmon;
	position:relative;
	left:50px;
	top:-6px;
	margin-right:50px;
	text-align:center;
	font-weight:bold;
	cursor:pointer;
	padding-top:10px;
	}
	
	#review_delete_color{
	color:tomato;
	text-decoration:none;
	}
</style>
<script>
$(document).ready(function() {
    $('#example').DataTable( {
    	"lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "전부"]],
        "language": {
            "decimal" : "",
            "emptyTable" : "데이터가 없습니다.",
            "info" : "_START_ - _END_ (총 _TOTAL_ 명)",
            "infoEmpty" : "0명",
            "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
            "infoPostFix" : "",
            "thousands" : ",",
            "lengthMenu" : "_MENU_ 개씩 보기",
            "loadingRecords" : "로딩중...",
            "processing" : "처리중...",
            "search" : "검색 : ",
            "zeroRecords" : "검색된 데이터가 없습니다.",
            "paginate" : 
            {
                "first" : "첫 페이지",
                "last" : "마지막 페이지",
                "next" : "다음",
                "previous" : "이전"
            },
            "aria" : 
            {
                "sortAscending" : " :  오름차순 정렬",
                "sortDescending" : " :  내림차순 정렬"
            }
        }
    } );
} );
	
	
</script>
</head>
<body>
<div id="member_head">
	<div id="member_head_line" onclick="href_main()">
	<span id="member_head_text">관리자페이지</span><br>
	<span id="member_head_text_small">Administrator</span>
	</div>
	
	<div class="member_head_menu" onclick="location='../main/main.jsp'">
	<box-icon name='home' size='lg'></box-icon>
	<div>Main</div>
	</div>
	
	<div class="member_head_menu" onclick="location='../admin/member_view.jsp'">
	<box-icon name='user' size='lg'></box-icon>
	<div>User</div>
	</div>
	
	<div class="member_head_menu" onclick="location='../admin/review_view.jsp'">
	<box-icon name='book' size='lg'></box-icon>
	<span>Review</span>
	</div>
	
	<div onclick="location='../admin/gongji_view.jsp'" id="member_head_back">
	<box-icon name='comment-dots' size="lg"></box-icon>
	<span>Gongji</span>
	</div>
</div>
<div id="table_margin">
	<table id="example" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>글 번호</th>
                <th>제목</th>
                <th>내용</th>
                <th>조회수</th>
                <th>작성일</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="gdto">
            <tr>
                <td>${gdto.id}</td>
                <td>${gdto.title}</td>
                <td>${gdto.content}</td>
                <td>${gdto.readnum}</td>
                <td>${gdto.writeday}</td>
                <td><a href="../admin/gongji_delete.jsp?id=${gdto.id}" id="review_delete_color">삭제</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>