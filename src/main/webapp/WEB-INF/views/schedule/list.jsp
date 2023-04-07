<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<style>
		a { text-decoration: none; color: black; }
		a:visited { text-decoration: none; }
		a:hover { text-decoration: none; }
		a:focus { text-decoration: none; }
		a:hover, a:active { text-decoration: none; }
	</style>
</head>
<body>
<script>
	if('${msg}'=="removeOk"){
		alert("게시물이 삭제 되었습니다.")
	}
	if('${msg}'=="removeError"){
		alert("게시물 삭제에 실패하였습니다.")
	}
	if('${msg}'=="registerOk"){
		alert("게시물이 등록 되었습니다.")
	}
	if('${msg}'=="modifyOk"){
		alert("게시물이 수정 되었습니다.")
	}
</script>
<!-- 메인 -->
<div class="container">
	<!-- 검색 -->
	<div class="row">
		<div class="col-9"></div>
		<div class="col-3">
			<input class="form-control" type="search" placeholder="검색어를 입력해주세요." id="search" name="search">
		</div>
	</div>
	<!-- END 검색 -->
	<!-- 게시물 목록 -->
	<div>
		<table class="table table-hover">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${scheduleList }" var="list">
				<tr>
					<td>${list.sno }</td>
					<td><a href="/schedule/view?sno=${list.sno }&page=${sph.page}">${list.stitle }</a></td>
					<td>${list.swriter }</td>
					<td>${list.date }</td>
					<td>${list.sview}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<!-- END 게시물 목록 -->

	<!-- paging & 글작성버튼 -->
	<div class = "text-center">
		<c:if test="${sph.showPrev}">
			<a href="/schedule/list?page=${sph.beginPage-1}"class = "fs-3 text-dark">&lt;</a>
		</c:if>
		<c:forEach var="i" begin="${sph.beginPage}" end="${sph.endPage}">
			<a style="font-size: 28px" href="/schedule/list?page=${i}" class = ${i eq param.page ? "text-primary"  : "text-dark" }>${i}&nbsp;</a>
		</c:forEach>
		<c:if test="${sph.showNext}">
			<a href="/schedule/list?page=${sph.endPage+1}" class = "fs-3 text-dark">&gt;</a>
		</c:if>
	</div>

	<div class="row">
		<div class="col-11"></div>
		<div class="col">
			<button onclick="location.href='/schedule/register'" class="form-control">글작성</button>
		</div>
	</div>
	<!-- END paging & 글작성버튼 -->
</div>
<!-- END 메인 -->
</body>
</html>
