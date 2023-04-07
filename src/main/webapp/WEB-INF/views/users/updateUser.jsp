<!--
작성자 : 강세빈
작성일 : 2023-04-07
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>회원 정보 수정</title>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <!-- jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- 페이지 개별 적용 css -->
    <link rel="stylesheet" href="/resources/users/css/detailUpdate.css" type="text/css">
</head>
<body>
<section class="section">
    <div class="section_box">
        <div class="contact">
            <form:form modelAttribute="UpdateUser" id="submitForm" action="./updateUser?${_csrf.parameterName}=${_csrf.token}" method="post">
                <h3>회원 정보 수정</h3>
                <div class="container">
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="username" class="col-form-label">아이디 : </label>
                        </div>
                        <div class="col-6">
                            <div id="username" name="username">${user.username}</div>
                        </div>
                        <div class="col">
                            <div id="validId" class="valid"></div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="name" class="col-form-label">이름 : </label>
                        </div>
                        <div class="col-6">
                            <form:input path="name" id="name" value="${user.name}"/>
                        </div>
                        <div class="col">
                            <div id="validName" class="valid"></div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="email" class="col-form-label">이메일 : </label>
                        </div>
                        <div class="col-6">
                            <form:input path="email" id="email" value="${user.email}"/>
                        </div>
                        <div class="col">
                            <div id="validEmail" class="valid"></div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="tel" class="col-form-label">전화번호 : </label>
                        </div>
                        <div class="col-6">
                            <form:input path="tel" id="tel" value="${user.tel}"/>
                        </div>
                        <div class="col">
                            <div id="validTel" class="valid"></div>
                        </div>
                    </div>
                    <div class="BtnGroup">
                        <button type="button" class="submit">정보 수정</button>
                        <a href="/detailUser" type="button" class="button">취소</a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</section>

<!-- 오류 모달 -->
<div class="modal" id="errorModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">모달 제목</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalContent">
                모달 본문
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- 페이지 개별 적용 js -->
<script type="text/javascript" src="/resources/users/js/updateUser.js"></script>
</body>
</html>

