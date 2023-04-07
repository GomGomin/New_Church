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
    <!-- Spring security로 인한 csrf 토큰 -->
    <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <meta charset="UTF-8">
    <title>교회 소식</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
</head>
<body>
<sec:authentication property="principal" var="user" />
<!-- 메인 -->
<div class="container">
    <!-- 게시물 -->
    <h3>${notice.ntitle }</h3>
    <table class="table">
        <thead class="table-light">
        <tr>
            <th>
                작성자 ${notice.nwriter } ${notice.date }
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                    <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
                    <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
                </svg>
                ${notice.nview }
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>${notice.ncontents }</td>
        </tr>
        <tr>
            <td>
                <div class="row">
                    <div class="col">
                        <button onclick="location.href='/notice/list'" class="form-control">목록</button>
                    </div>
                    <div class="col-9">
                    </div>
                    <div class="col">
                        <c:if test="${notice.nwriter==user.username }">
                            <button onclick="location.href='/notice/edit?nno=${notice.nno }'" class="form-control">수정</button>
                        </c:if>
                    </div>
                    <div class="col">
                        <c:if test="${notice.nwriter==user.username }">
                            <button onclick="removeNotice(${notice.nno })" class="form-control">삭제</button>
                        </c:if>
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
    <!-- END 게시물 -->
</div>
<!-- END 메인 -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<!-- 페이지 개별 적용 js -->
<script type="text/javascript" src="/resources/notice/js/notice.js"></script>
</body>
</html>