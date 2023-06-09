<%--
	작성자 : 박지원
	작성일 : 2023-04-09
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<meta name="viewport" content="width=device-width, initial-scale=1">
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
	let msg = '${msg}';
	if(msg=="listError"){
		alert("게시물을 목록을 가져올 수 없습니다. 다시 시도해주세요.")
	}
	if(msg=="removeError" || msg == "viewError"){
		alert("게시물 존재하지 않습니다.")
	}
	if(msg=="removeOk"){
		alert("게시물이 삭제 되었습니다.")
	}
	if(msg=="registerOk"){
		alert("게시물이 등록 되었습니다.")
	}
	if(msg =="modifyOk"){
		alert("게시물이 수정 되었습니다.")
	}
</script>
<!-- 메인 -->
<div class="container">
	<!-- 게시물 목록 -->
	<div>
		<br><h1>찬양 목록</h1><br>
		<table class="table table-hover">
			<tr>
				<th class="col-md">번호</th>
				<th class="col-md-5">찬양제목</th>
				<th class="col-md-4">작성일</th>
				<th class="col-md">추천수</th>
				<th class="col-md">조회수</th>
			</tr>
			<c:forEach items="${praiseList }" var="list">
				<tr>
					<td>${list.pno }</td>
					<td><a href="/praise/view${sph.sc.getQueryString()}&pno=${list.pno }">${list.ptitle }</a></td>
					<td>${list.date }</td>
					<td>${list.plike}</td>
					<td>${list.pview}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<!-- END 게시물 목록 -->
	<!-- paging -->
	<div class = "text-center mb-5">
		<c:if test="${sph.showPrev}">
			<a href="/praise/list${sph.sc.getQueryString(sph.beginPage-1)}"class = "fs-3 text-dark">&lt;</a>
		</c:if>
		<c:forEach var="i" begin="${sph.beginPage}" end="${sph.endPage}">
			<a style="font-size: 20px" href="/praise/list${sph.sc.getQueryString(i)}" class = ${i eq sph.sc.page ? "text-primary"  : "text-dark" }>${i}&nbsp;</a>
		</c:forEach>
		<c:if test="${sph.showNext}">
			<a href="/praise/list${sph.sc.getQueryString(sph.endPage+1)}" class = "fs-3 text-dark">&gt;</a>
		</c:if>
	</div>
	<!-- END paging -->
	<!-- 검색 -->
	<form action="/praise/list">
		<div class="row g-3">
			<div class="col-md-2">
				<select name="option" class="form-select">
					<option value="all" ${sph.sc.option eq "all" || sph.sc.option eq '' ? "selected" : ""}>제목+내용</option>
					<option value="title" ${sph.sc.option eq "title" ? "selected" : ""}>제목</option>
				</select>
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control" placeholder="검색어를 입력해주세요." value="${sph.sc.keyword}" id="keyword" name="keyword">
			</div>
			<div class="col-md">
				<input type="submit" class="form-control" value="검색">
			</div>
			<!-- END 검색 -->
			<!-- 글작성버튼 -->
			<div class="col-md-5"></div>
			<div class="col-md">
				<sec:authorize access="hasRole('ADMIN')">
					<input type="submit" formaction="/praise/register" class="form-control" value="작성">
				</sec:authorize>
			</div>
			<!-- END 글작성버튼 -->
		</div>
	</form>
</div>
<!-- END 메인 -->
</body>
</html>