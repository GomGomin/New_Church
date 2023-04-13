<!--
작성자 : 강세빈
작성일 : 2023-04-06
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <!-- Spring security로 인한 csrf 토큰 -->
    <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <title>내 정보 보기</title>

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
            <form>
                <h3>회원 정보</h3>
                <div class="container">
                    <div class="row g-3 align-items-center">
                        <div class="col-3">
                            <label for="username" class="col-form-label">아이디 : </label>
                        </div>
                        <div class="col-9">
                            <div id="username" name="username">${user.username}</div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col-3">
                            <label for="name" class="col-form-label">이름 : </label>
                        </div>
                        <div class="col-9">
                            <div id="name" name="name">${user.name}</div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col-3">
                            <label for="password" class="col-form-label">비밀번호 : </label>
                        </div>
                        <div class="col-6">
                            <div id="password" name="password">****</div>
                        </div>
                        <div class="col-3">
                            <a href="/updatePw" class="button" id="updatePwBtn">수정</a>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col-3">
                            <label for="email" class="col-form-label">이메일 : </label>
                        </div>
                        <div class="col-9">
                            <div id="email" name="email">${user.email}</div>
                        </div>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col-3">
                            <label for="tel" class="col-form-label">전화번호 : </label>
                        </div>
                        <div class="col-9">
                            <div id="tel" name="tel">${user.tel}</div>
                        </div>
                    </div>
                    <div class="BtnGroup">
                        <a href="/updateUser" type="button" class="button" id="updateBtn">정보 수정</a>
                        <button type="button" class="button" id="deleteBtn">회원 탈퇴</button>
                        <a href="/" type="button" class="button">취소</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

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
                <button type="button" id="deleteUserBtn" class="btn btn-secondary">네</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
            </div>
        </div>
    </div>
</div>


<!-- 페이지 개별 적용 js -->
<script type="text/javascript" src="/resources/users/js/detailUser.js"></script>
</body>
</html>

