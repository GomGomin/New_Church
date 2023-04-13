<!--
작성자 : 심현민
최초 작성일 : 23.04.05
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>교회 소식</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">

    <!-- 페이지 개별 적용 css -->
    <link rel="stylesheet" href="/resources/notice/css/listNotice.css" type="text/css">
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


</head>
<body>
<sec:authentication property="principal" var="user" />
<div class="container">
    <!-- 메인 -->
    <br><h1>공지사항</h1><br>
    <!-- 게시물 목록 -->
    <table class="table">
        <thead class="table-light">
        <tr>
            <th align="center">번호</th>
            <th align="center">제목</th>
            <th align="center">작성일</th>
            <th align="center">조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list }" var="notice">
            <tr>
                <td>${notice.nno }</td>
                <sec:authorize access="isAnonymous()">
                    <td><a id="listTitle" href="/notice/detail?nno=${notice.nno }&username=${user}">${notice.ntitle }</a></td>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                <td><a id="listTitle" href="/notice/detail?nno=${notice.nno }&username=${user.username}">${notice.ntitle }</a></td>
                </sec:authorize>
                <td>${notice.date }</td>
                <td>${notice.nview }</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!-- END 게시물 목록 -->
    <!-- paging -->
    <div align="center">
        <c:if test="${page.prev}">
            <span>[ <a href="/notice/list?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]</span>
        </c:if>
        <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
            <span>
                <c:if test="${select != num}">
                    <a href="/notice/list?num=${num}${page.searchTypeKeyword}">&nbsp;${num}&nbsp;</a>
                </c:if>
                <c:if test="${select == num}">
                    <b>&nbsp;${num}&nbsp;</b>
                </c:if>
            </span>
        </c:forEach>
        <c:if test="${page.next}">
            <span>[ <a href="/notice/list?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]</span>
        </c:if>
    </div>
    <!-- END paging -->
    <!-- 검색 -->
    <div class="row">
        <div class="col">
            <select name="searchType" class="form-control">
                <option value="title" <c:if test="${page.searchType eq 'title'}">selected</c:if>>제목</option>
                <option value="content" <c:if test="${page.searchType eq 'content'}">selected</c:if>>내용</option>
                <option value="title_content" <c:if test="${page.searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
                <option value="writer" <c:if test="${page.searchType eq 'writer'}">selected</c:if>>작성자</option>
            </select>
        </div>
        <div class="col-3">
            <input type="text" name="keyword" class="form-control" value="${page.keyword}" placeholder="검색어를 입력해주세요."/>
        </div>
        <div class="col">
            <button type="button" class="form-control" id="searchBtn">검색</button>
        </div>
        <!-- END 검색 -->
        <!-- 글작성버튼 -->
        <div class="col-5"></div>
        <div class="col">
            <sec:authorize access="hasRole('ADMIN')">
                <button onclick="location.href='/notice/setNewNotice'" class="form-control">작성</button>
            </sec:authorize>
        </div>
    </div>
    <!-- END 글작성버튼 -->
</div>
<!-- END 메인 -->

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
    /* 검색 */
    document.getElementById("searchBtn").onclick = function () {
        let searchType = document.getElementsByName("searchType")[0].value;
        let keyword =  document.getElementsByName("keyword")[0].value;

        location.href = "/notice/list?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
    };
</script>
</body>
</html>