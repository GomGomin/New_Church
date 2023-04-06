<%--
    작성자 : 강세빈
    작성일 : 2023-04-04
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>로그인</title>

    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <!-- fontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- 페이지 개별 적용 css -->
    <link rel="stylesheet" href="/resources/users/css/login.css" type="text/css">
</head>
<body>
<script>
    <% String errorMessage = (String) request.getSession().getAttribute("errorMessage"); %>
    $(document).ready(function(){
        if (<%= errorMessage != null && !errorMessage.isEmpty() %>) {
            $('#loginError').modal('show');
            <% session.removeAttribute("errorMessage"); %>
        } else {
            $('#loginError').modal('hide');
        }
    });
</script>
<section class="login">
    <div class="login_box">
        <%-- 왼쪽 입력하는 부분 --%>
        <div class="left">
            <div class="contact">
                <form action="/login" method="post" id="loginForm">
                    <h3>로그인</h3>
                    <div class="input-container">
                        <input name="username" type="text" placeholder="아이디">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <div class="input-container">
                        <input name="password" type="password" placeholder="비밀번호">
                        <i class="fa-solid fa-key"></i>
                    </div>
                    <div>
                        <a href="/findId">아이디 찾기</a>
                        <a href="/findPw" style="float: right">비밀번호 찾기</a>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button class="submit" id="loginBtn">로그인</button>
                </form>
            </div>
        </div>
        <%-- 오른쪽 교회 그림 부분 --%>
        <div class="right">
            <div class="right-text">
                <h2>계정 교회</h2>
                <h5>교회 간단한 소개</h5>
                교회 사진이 들어갈 공간입니다.
            </div>
        </div>
    </div>
</section>

<!-- 아이디 패스워드 확인 모달 -->
<div class="modal" id="loginError" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">로그인 실패</h5>
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
</html>
