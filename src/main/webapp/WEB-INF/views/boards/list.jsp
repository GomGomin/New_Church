<!-- 
작성자 : 심현민
최초 작성일 : 23.04.05
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
	<!-- 메인 -->
	<div class="container">
		<!-- 게시물 목록 -->
		<table class="table">
			<thead class="table-light">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="board">
				<tr>
					<td>${board.bno }</td>
					<td><a href="/boards/detail?bno=${board.bno }&username=abc">${board.btitle }</a></td><!-- ${user.username} -->
					<td>${board.date }</td>
					<td>${board.bview }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- END 게시물 목록 -->
		<!-- paging -->
		<c:if test="${page.prev}">
			<span>[ <a href="/boards/list?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]</span>
		</c:if>
		<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			<span> 
				<c:if test="${select != num}">
					<a href="/boards/list?num=${num}${page.searchTypeKeyword}">${num}</a>
				</c:if> 
				<c:if test="${select == num}">
					<b>${num}</b>
				</c:if>
			</span>
		</c:forEach>
		<c:if test="${page.next}">
			<span>[ <a href="/boards/list?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]</span>
		</c:if>
		<!-- END paging -->
		<!-- 검색 -->
		<div>
			<select name="searchType">
				<option value="title" <c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
				<option value="content" <c:if test="${page.searchType eq 'content'}">selected</c:if>>내용</option>
				<option value="title_content" <c:if test="${page.searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
				<option value="writer" <c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
			</select> 
			<input type="text" name="keyword" value="${page.keyword}" placeholder="검색어를 입력해주세요."/>
			<button type="button" id="searchBtn">검색</button>
		</div>
		<!-- END 검색 -->
		<!-- 글작성버튼 -->
		<div class="row">
			<div class="col-11"></div>
			<div class="col">
				<button onclick="location.href='/boards/setNewBoard'" class="form-control">글작성</button>
			</div>
		</div>
		<!-- END 글작성버튼 -->
	</div>
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