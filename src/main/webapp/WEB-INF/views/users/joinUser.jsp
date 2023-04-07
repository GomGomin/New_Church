<%--
    작성자 : 강세빈
    작성일 : 2023-04-04
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>회원 가입</title>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <!-- jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- 페이지 개별 적용 css -->
    <link rel="stylesheet" href="/resources/users/css/joinUser.css" type="text/css">

</head>
<body>
<section class="join">
    <div class="join_box">
        <%-- 왼쪽 교회 그림 부분 --%>
        <div class="left">
            <div class="left-text">
                <h2>계정 교회</h2>
                <h5>교회 간단한 소개</h5>
                교회 사진이 들어갈 공간입니다.
            </div>
        </div>
        <%-- 오른쪽 입력하는 부분 --%>
        <div class="right">
            <div class="contact">
                <form:form modelAttribute="JoinUser" id="submitForm" action="./joinUser?${_csrf.parameterName}=${_csrf.token}" method="post">
                    <h3>회원가입</h3>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="username" class="col-form-label">아이디 : </label>
                        </div>
                        <div class="col-6">
                            <form:input path="username" id="username" placeholder="아이디"/>
                        </div>
                        <div class="col">
                            <div id="validId" class="valid"></div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="password" class="col-form-label">비밀번호 : </label>
                        </div>
                        <div class="col-6">
                            <form:input path="password" id="password" type="password" placeholder="비밀번호"/>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="ChkPassword" class="col-form-label">비밀번호 확인: </label>
                        </div>
                        <div class="col-6">
                            <input id="ChkPassword" type="password" placeholder="비밀번호 확인"/>
                        </div>
                        <div class="col">
                            <div id="validPassword" class="valid"></div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="name" class="col-form-label">이름: </label>
                        </div>
                        <div class="col-6">
                            <form:input path="name" id="name" placeholder="이름"/>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="email" class="col-form-label">이메일: </label>
                        </div>
                        <div class="col-6">
                            <form:input path="email" id="email" placeholder="이메일"/>
                        </div>
                        <div class="col">
                            <div id="validEmail" class="valid"></div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col">
                            <label for="tel" class="col-form-label">전화번호: </label>
                        </div>
                        <div class="col-6">
                            <form:input path="tel" id="tel" placeholder="전화번호 (010-0000-0000)"/>
                        </div>
                        <div class="col">
                            <div id="validTel" class="valid"></div>
                        </div>
                    </div>
                    <div class="buttonGroup">
                        <button type="button" class="submit">회원 가입</button>
                        <a href="/main" type="button" class="button">취소</a>
                    </div>
                    <input type="hidden" name="validate" id="validate" value="false">
                </form:form>
            </div>
        </div>
    </div>
</section>

<!-- 아이디 입력 오류 모달 -->
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
<script type="text/javascript" src="/resources/users/js/joinUser.js"></script>
</body>
</html>
