<!--
작성자 : 강세빈
최초 작성일 : 23.04.07
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <!-- Spring security로 인한 csrf 토큰 -->
    <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <meta charset="UTF-8">
    <title>회원 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">

    <!-- jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- 페이지 개별 적용 css -->
    <link rel="stylesheet" href="/resources/users/css/listUsers.css" type="text/css">
</head>
<body>
<!-- 메인 -->
<div class="container">
    <!-- 유저 목록 -->
    <table class="table">
        <thead class="table-light">
        <tr>
            <th align="center">아이디</th>
            <th align="center">이름</th>
            <th align="center">이메일</th>
            <th align="center">전화번호</th>
            <th align="center">처리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listUsers }" var="user">
            <tr>
                <td><a id="listUsername" href="/detailUser?username=${user.username}">${user.username}</a></td>
                <td>${user.name }</td>
                <td>${user.email }</td>
                <td>${user.tel }</td>
                <td>
                    <a type="button" class="updateUserBtn button" href="/updateUser?username=${user.username}">수정</a>
                    <button type="button" class="deleteBtn button">삭제</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!-- END 유저 목록 -->
    <!-- paging -->
    <div align="center">
        <c:if test="${page.prev}">
            <span>[ <a href="/listUsers?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]</span>
        </c:if>
        <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
            <span>
                <c:if test="${select != num}">
                    <a href="/listUsers?num=${num}${page.searchTypeKeyword}">&nbsp;${num}&nbsp;</a>
                </c:if>
                <c:if test="${select == num}">
                    <b>&nbsp;${num}&nbsp;</b>
                </c:if>
            </span>
        </c:forEach>
        <c:if test="${page.next}">
            <span>[ <a href="/listUsers?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]</span>
        </c:if>
    </div>
    <!-- END paging -->
</div>
<!-- END 메인 -->

<!-- 오류 모달 -->
<div class="modal" id="deleteUser" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">회원 탈퇴</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalContent">
                회원을 탈퇴하시면 되돌릴 수 없습니다.<br>
                정말 탈퇴 하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" id="deleteUserBtn" class="btn btn-secondary" data-bs-dismiss="modal">네</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
            </div>
        </div>
    </div>
</div>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<!-- 페이지 개별 적용 js -->
<script type="text/javascript" src="/resources/users/js/listUsers.js"></script>

</body>
</html>