<!--
작성자 : 김도영
최초 작성일 : 23.04.04
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 교회</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>


<style type="text/css">

@font-face {
    font-family: 'SDSamliphopangche_Outline';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Outline.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

p{
font-family: "SDSamliphopangche_Outline";
color: white;
font-size: 50px;
}




</style>

</head>
<body class="text-center">


	<div class="col-md-6 px-0">
		<h1 class="display-4 fst-italic" style="padding-right: 220px; padding-top: 20px;">주보 목록</h1>
	</div>
	<hr class="featurette-divider">

	<br>

	<hr class="featurette-divider">

	<div class="w3-container" id="menu">

<!------------------------- form ------------------------------->






		<div class="row" align="center">
		
		<c:choose>
    <c:when test="${weeklyList == null ||  weeklyList.size() < 1}">
			
			<div class="container" style="width: 100%; padding-bottom: 100px;">
				<p class="alert alert-danger"
					style="text-align: center; height: 200px; padding: 40px; padding-top: 60px; margin-top: 100px;">등록된
					주보가 없습니다.</p>

			</div>
    </c:when>
    <c:otherwise>
<c:forEach items="${weeklyList}" var="weekly">
<c:set var="wno" value="${weekly.wno}" />
			<div class="col-md-4" style="padding-bottom: 50px;">

				<!-- 이미지 -->
				<a href="/weekly/detail?wno=${weekly.wno}"><img src="/resources/weeklyImages/${WeeklyAttachList[wno]}" style="width: 300px; height: 200px;" alt="weekly image"></a> <br>
				<br>



				<!-- 이름 -->

				<h5><a href="/weekly/detail?wno=${weekly.wno}" style="text-decoration: none; color: black;">${weekly.wtitle}</a></h5>

			</div>
			
			</c:forEach>
    </c:otherwise>
</c:choose>
	
	<hr class="featurette-divider">


		<!-- paging -->
		<div align="center">
		<c:if test="${page.prev}">
			<span>[ <a href="/weekly/list?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]</span>
		</c:if>
		<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			<span> 
				<c:if test="${select != num}">
					&nbsp;<a href="/weekly/list?num=${num}${page.searchTypeKeyword}">${num}</a>&nbsp;
				</c:if> 
				<c:if test="${select == num}">
					&nbsp;<b>${num}</b>&nbsp;
				</c:if>
			</span>
		</c:forEach>
		<c:if test="${page.next}">
			<span>[ <a href="/weekly/list?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]</span>
		</c:if>
		</div>
		<!-- END paging -->

			        <sec:authorize access="isAuthenticated()">
        			<!-- 검색 -->
			<div style=" display: flex; text-align: right; margin-right: 20px; width: 100%; padding-bottom: 100px;">

				<select name="searchType" class="form-select" style="width: 150px; margin-right: 10px;">
					<option value="title" <c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
					<option value="title_wwriter" <c:if test="${page.searchType eq 'title_wwriter'}">selected</c:if>>제목 & 작성자</option>
					<option value="writer" <c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
				</select> 
								<input type="text" name="keyword" class="form-control" style="width: 200px;" value="${page.keyword}" placeholder="Search"/>
								<button type="button" class="btn btn-light border-dark" id="searchBtn" style="margin-left: 10px;">검색</button>
			
			

					<a href="/weekly/add" style="margin-left:55%;
min-width: 100px;" class="btn btn-light border-dark">주보 등록</a>
			
			
			</div>
			<!-- END 검색 -->

				</sec:authorize>
				
				
							        <sec:authorize access="isAnonymous()">
        			<!-- 검색 -->
			<div style=" display: flex; text-align: right; margin-right: 20px; width: 100%; padding-bottom: 100px;">

				<select name="searchType" class="form-select" style="width: 150px; margin-right: 10px;">
					<option value="title" <c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
					<option value="title_wwriter" <c:if test="${page.searchType eq 'title_wwriter'}">selected</c:if>>제목 & 작성자</option>
					<option value="writer" <c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
				</select> 
								<input type="text" name="keyword" class="form-control" style="width: 200px;" value="${page.keyword}" placeholder="Search"/>
								<button type="button" class="btn btn-light border-dark" id="searchBtn" style="margin-left: 10px;">검색</button>
			
			
			</div>
			<!-- END 검색 -->

				</sec:authorize>
				
				
				
		</div>

	</div>
<script>
    //오류 메시지 모달 띄우기 위한 함수
    <% String errorMessage = (String) request.getSession().getAttribute("errorMessage"); %>
    $(document).ready(function(){
        if (<%= errorMessage != null && !errorMessage.isEmpty() %>) {
            $('#error').modal('show');
            <% session.removeAttribute("errorMessage"); %>
        } else {
            $('#error').modal('hide');
        }
    });
</script>

<!------------------------- form end ------------------------------->

<!-- 오류 메시지 모달 -->
<div class="modal" id="error" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">오류 발생</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%= errorMessage %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>




</body>

<script>
/* 검색 */
document.getElementById("searchBtn").onclick = function () {
	let searchType = document.getElementsByName("searchType")[0].value;
	let keyword =  document.getElementsByName("keyword")[0].value;
	
	location.href = "/weekly/list?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
};
</script>


</html>




	         