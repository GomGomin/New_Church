<%--
  Created by IntelliJ IDEA.
  User: qz678
  Date: 2023-04-13
  Time: AM 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>

<!-- fontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
      crossorigin="anonymous" referrerpolicy="no-referrer"/>

<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- 페이지 개별 적용 css -->
<link rel="stylesheet" href="/resources/admin/css/adminMain.css" type="text/css">

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner users">
                    <h3>${countUsers}</h3>
                    <p>회원 수</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-users"></i>
                </div>
                <a href="/listUsers" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>${countWorships}</h3>
                    <p>예배 수</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-place-of-worship"></i>
                </div>
                <a href="/worship/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>${countPraises}</h3>
                    <p>찬양 수</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-hands-praying"></i>
                </div>
                <a href="/praise/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>${countBoards}</h3>
                    <p>자유 게시판</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-rectangle-list"></i>
                </div>
                <a href="/boards/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>${countAlbums}</h3>
                    <p>포토 게시판</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-images"></i>
                </div>
                <a href="/album/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>${countSchedules}</h3>
                    <p>일정</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <a href="/schedule/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner notice">
                    <h3>${countNotices}</h3>
                    <p>공지사항</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-bell"></i>
                </div>
                <a href="/notice/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>${countEvents}</h3>
                    <p>행사</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-cake-candles"></i>
                </div>
                <a href="/event/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-primary">
                <div class="inner">
                    <h3>${countPickUp}</h3>
                    <p>픽업 게시판</p>
                </div>
                <div class="icon">
                    <i class="fa-solid fa-van-shuttle"></i>
                </div>
                <a href="/pickup/list" class="small-box-footer">목록 보기 <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
</div>

<!-- 페이지 개별 적용 js -->
<script type="text/javascript" src="/resources/admin/js/adminMain.js"></script>