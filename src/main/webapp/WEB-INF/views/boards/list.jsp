<!-- 
작성자 : 심현민
최초 작성일 : 23.04.05
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<style>
body{font-family: 'Noto Sans KR', sans-serif}
</style>
<body>
<!-- 로그인 정보 받기 -->
<sec:authentication property="principal" var="user" />
	<!-- 메인 -->
	<br><h1>자유게시판</h1><br>
	<!-- 게시물 목록 -->
	<table class="table">
		<thead class="table-light">
			<tr>
				<th class="col">번호</th>
				<th class="col-9">제목</th>
				<th class="col">작성일</th>
				<th class="col">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="board">
			<tr>
				<td>${board.bno }</td>
				<sec:authorize access="isAuthenticated()">
					<td><a href="/boards/detail?bno=${board.bno }&username=${user.username}">${board.btitle }</a></td>
				</sec:authorize>
				<sec:authorize access="isAnonymous()" >
					<td><a href="/boards/detail?bno=${board.bno }&username=${user }">${board.btitle }</a></td>
				</sec:authorize>
				<td>${fn:split(board.date,' ')[0] }</td>
				<td>${board.bview }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- END 게시물 목록 -->
	<!-- paging -->
	<div align="center">
	<c:if test="${page.prev}">
		<span>[ <a href="/boards/list?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]</span>
	</c:if>
	<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
		<span> 
			<c:if test="${select != num}">
				&nbsp;<a href="/boards/list?num=${num}${page.searchTypeKeyword}">${num}</a>&nbsp;
			</c:if> 
			<c:if test="${select == num}">
				&nbsp;<b>${num}</b>&nbsp;
			</c:if>
		</span>
	</c:forEach>
	<c:if test="${page.next}">
		<span>[ <a href="/boards/list?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]</span>
	</c:if>
	</div>
	<!-- END paging -->
	<br>
	<div class="row">
		<!-- 검색 -->
		<div class="col-2">
			<select name="searchType" class="form-select">
				<option value="title" <c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
				<option value="content" <c:if test="${page.searchType eq 'content'}">selected</c:if>>내용</option>
				<option value="title_content" <c:if test="${page.searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
				<option value="writer" <c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
			</select> 
		</div>
		<div class="col-2">
			<input type="text" name="keyword" class="form-control" value="${page.keyword}" placeholder="검색어를 입력해주세요."/>
		</div>
		<div class="col">
			<button type="button" class="form-control" id="searchBtn">검색</button>
		</div>
		<!-- END 검색 -->
		<!-- 글작성버튼 -->
		<div class="col-5"></div>
		<div class="col-2">
		<sec:authorize access="isAuthenticated()" >
			<button onclick="location.href='/boards/setNewBoard'" class="form-control">글작성</button>
		</sec:authorize>
		</div>
		<!-- END 글작성버튼 -->
	</div><br>
	<!-- END 메인 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
/* 검색 */
document.getElementById("searchBtn").onclick = function () {
	let searchType = document.getElementsByName("searchType")[0].value;
	let keyword =  document.getElementsByName("keyword")[0].value;
	
	location.href = "/boards/list?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
};
</script>
</body>
</html>