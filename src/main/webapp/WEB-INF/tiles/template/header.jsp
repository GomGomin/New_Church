<!-- 작업자 : 김남훈 -->
<!-- 작업 내용 : 헤더 작성 -->
<!-- 최근 수정 내역 : 스타일 변경 -->


<!--
작성자 : 김도영
작업내용 : ChatGPT
최초 작성일 : 23.04.04
-->

<%@page import="com.church.controller.PickUpController"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="com.church.service.PickUpsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<!DOCTYPE html>
<html>
<head>
    <title>W3.CSS Template</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/header.css" type="text/css">


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>


<style>

/*         function w3_open() { */
/*             if (mySidebar.style.display == 'block') { */
/*                 mySidebar.style.display = 'none'; */
/*                 alert("gd"); */
/*             } else { */
/*                 mySidebar.style.display = 'block'; */
/*             } */
/*         } */

/*         // Close the sidebar with the close button */
/*         function w3_close() { */
/*             mySidebar.style.display = "none"; */
/*         } */

#STATICMENU { margin: 0pt; padding: 0pt; position: absolute; z-index: 1; right: 0px; top: 0px;}


.dropdown {
 overflow: hidden;
}


.dropdown-content {
 display: none;
 position: absolute;
 background-color: #f9f9f9;
 min-width: 160px;
 box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
 border-radius: 10px;

}

.dropdown-content a {
float: none;
color: black;
padding: 12px 16px;
text-decoration: none;
display: block;
text-align: left;
border-radius: inherit;
 
}

.dropdown-content a:hover {
  background-color: #ddd;
}

.dropdown:hover .dropdown-content {
 display: block;
}

#dropdown:hover .dropdown-content {
 display: block;
}

.w3-top button{
border: none;
background-color: inherit;
}

@media screen and (max-width: 640px){

.w3-right{
height: inherit; !important;
vertical-align: middle; !important;
font-size: 10px;
}

#myNavbar{
height: inherit; !important;
}


.w3-left{
vertical-align: middle !important;
}

.w3-left i{
font-size: 25px !important;
}

#STATICMENU{
display: none;
}
}

.sidemenu{
display: none;
}

</style>

<script>

function w3_open() {
	  if (mySidebar.style.display == 'block') {
	    mySidebar.style.display = 'none';
        $('#map').css('display', 'none'); 
	  } else {
	    mySidebar.style.display = 'block';
        $('#map').css('display', 'black'); 
	  }
	}

// Close the sidebar with the close button
function w3_close() {
    mySidebar.style.display = "none";
}

function test() {
    if($( ".sidevision" ).css( "display" ) == "none"){
        $('.sidevision').css('display', 'block'); 
    }else{
        $('.sidevision').css('display', 'none'); 
    }
}

function test2() {
    if($( ".sidevision2" ).css( "display" ) == "none"){
        $('.sidevision2').css('display', 'block'); 
    }else{
        $('.sidevision2').css('display', 'none'); 
    }
}

function test3() {
    if($( ".sidevision3" ).css( "display" ) == "none"){
        $('.sidevision3').css('display', 'block'); 
    }else{
        $('.sidevision3').css('display', 'none'); 
    }
}

function test4() {
    if($( ".sidevision4" ).css( "display" ) == "none"){
        $('.sidevision4').css('display', 'block'); 
    }else{
        $('.sidevision4').css('display', 'none'); 
    }
}
</script>
</head>
<body onload="InitializeStaticMenu()">

<!-- Navbar (sit on top) -->
<div class="w3-top">
    <div class="w3-bar w3-white w3-card" id="myNavbar">
        <a href="/" class="w3-bar-item w3-button w3-wide logo"></a>
        <!-- Right-sided navbar links -->
        <div class="w3-left w3-hide-small w3-hide-medium">
            <div class="dropdown w3-bar-item w3-button">
                <button>교회소개</button>
                <div class="dropdown-content">
                    <a href="/vision">교회소개</a>
                    <a href="/map">오시는 길</a>
                </div>
            </div>
            <div class="dropdown w3-bar-item w3-button">
                <button>예배와 말씀</button>
                <div class="dropdown-content">
                    <a href="/weekly/list">주보 목록</a>
                    <a href="/worship/list">예배 목록</a>
                    <a href="/praise/list">찬양 목록</a>

                </div>
            </div>
            <div class="dropdown w3-bar-item w3-button">
                <button>게시판</button>
                <div class="dropdown-content">
                    <a href="/boards/list">목록</a>
                    <a href="/album/list">포토 갤러리</a>
                    <a href="/schedule/list">일정</a>
                </div>
            </div>
            <div class="dropdown w3-bar-item w3-button">
                <button>공지사항</button>
                <div class="dropdown-content">
                    <a href="/notice/list">공지사항 목록</a>
                    <a href="/event/list">행사</a>
                </div>
            </div>

            <sec:authorize access="hasRole('ROLE_USER')">
	            <div class="dropdown w3-bar-item w3-button">
				   <c:set var="username" value="${SecurityContextHolder.getContext().getAuthentication().getName()}" />
				   <spring:eval expression="@pickUpController.hasPickupHistory(username)" var="hasPickup" />
				  <c:if test="${!hasPickup}">
				    <a href="/pickup/add"><button>픽업 신청</button></a>
				  </c:if>
				  <c:if test="${hasPickup}">
				    <a href="/pickup/detail?pbwriter=${username}"><button>내 픽업 보기</button></a>
				  </c:if>
	            </div>
           </sec:authorize>
           
            <sec:authorize access="hasRole('ROLE_ADMIN')">
	            <div class="dropdown w3-bar-item w3-button">
	               <a href="/pickup/list"><button>픽업 리스트</button></a>
	            </div>
           </sec:authorize>

            <sec:authorize access="hasRole('ROLE_ADMIN')">
	            <div class="w3-bar-item w3-button">
	               <a href="/admin/main"><button>관리자 메뉴</button></a>
	            </div>
           </sec:authorize>
        </div>

        <div class="w3-left" style="height: auto;">
            <a href="javascript:void(0)" class="w3-bar-item w3-button w3-left w3-hide-large" onclick="w3_open()">
                <i class="material-icons" style="font-size: 36px">menu</i>
            </a>
        </div>

        <nav class="w3-sidebar w3-bar-block w3-white w3-card w3-animate-left" style="display:none" id="mySidebar">
            <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">닫기
                &times;</a>
            <a href="/" onclick="w3_close()" class="w3-bar-item w3-button">홈페이지</a>
            <a href="#" onclick="test()" class="w3-bar-item w3-button">교회소개</a>
            <ul class="sidevision sidemenu">
            	<li><a href="/vision" onclick="w3_close()" class="w3-bar-item w3-button">교회소개</a></li>
            	<li><a href="/map" onclick="w3_close()" class="w3-bar-item w3-button">오시는 길</a></li>
            </ul>
            <a href="#" onclick="test2()" class="w3-bar-item w3-button">예배와 말씀</a>
            <ul class="sidevision2 sidemenu">
            	<li><a href="/worship/list" onclick="w3_close()" class="w3-bar-item w3-button">예배목록</a></li>
            	<li><a href="/praise/list" onclick="w3_close()" class="w3-bar-item w3-button">찬양목록</a></li>
            </ul>
            <a href="#" onclick="test3()" class="w3-bar-item w3-button">게시판</a>
            <ul class="sidevision3 sidemenu">
            	<li><a href="/boards/list" onclick="w3_close()" class="w3-bar-item w3-button">목록</a></li>
            	<li><a href="/album/list" onclick="w3_close()" class="w3-bar-item w3-button">포토 갤러리</a></li>
            	<li><a href="/schedule/list" onclick="w3_close()" class="w3-bar-item w3-button">일정</a></li>
            </ul>
            <a href="#" onclick="test4()" class="w3-bar-item w3-button">공지사항</a>
            <ul class="sidevision4 sidemenu">
            	<li><a href="/notice/list" onclick="w3_close()" class="w3-bar-item w3-button">공지사항 목록</a></li>
            	<li><a href="/event/list" onclick="w3_close()" class="w3-bar-item w3-button">행사</a></li>
            </ul>            
            <sec:authorize access="hasRole('ROLE_USER')">
			   <c:set var="username" value="${SecurityContextHolder.getContext().getAuthentication().getName()}" />
			   <spring:eval expression="@pickUpController.hasPickupHistory(username)" var="hasPickup" />
	    	   <c:if test="${!hasPickup}">
		           <a href="/pickup/add" onclick="w3_close()" class="w3-bar-item w3-button">픽업 신청</a>
	           </c:if>
			   <c:if test="${hasPickup}">
				   <a href="/pickup/detail?pbwriter=${username}"onclick="w3_close()" class="w3-bar-item w3-button">내 픽업 보기</a>
			   </c:if>          
			</sec:authorize>
			
            <sec:authorize access="hasRole('ROLE_ADMIN')">
            	<a href="/notice/list" onclick="w3_close()" class="w3-bar-item w3-button">픽업</a>
            </sec:authorize>
        </nav>

        <!-- Right-sided navbar links -->
        <div class="w3-right">
            <sec:authorize access="isAnonymous()">
                <a href="/login" class="w3-bar-item w3-button">로그인</a>
                <a href="/joinUser" class="w3-bar-item w3-button">회원가입</a>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">

                <a href="/detailUser" class="w3-bar-item w3-button">내 정보</a>
                <form:form method="post" action="/logout" cssStyle="display: inline-block;">
                    <button type="submit" class="w3-bar-item w3-button">로그아웃</button>

                </form:form>
            </sec:authorize>
        </div>

        <!-- Hide right-floated links on small screens and replace them with a menu icon -->


    </div>
</div>











<!-- Chat GPT -->

<img data-bs-toggle="offcanvas" aria-expanded="false"  data-bs-target="#offcanvasRight" aria-controls="offcanvasRight" id="STATICMENU" style="width: 180px; height: 150px;" src="/resources/img/GPT.png">


<div class="offcanvas offcanvas-end text-center" tabindex="-1"  data-bs-scroll="true" data-bs-backdrop="false" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" style="z-index: 10000;">
  <div class="offcanvas-header">
    <h3 class="offcanvas-title" id="offcanvasRightLabel">Church AI[CHAT GPT]</h3>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
  <img style="width: 110px; height: 80px;" src="/resources/img/GPT2.jpg">
  <br><br>
    <div id="body">
    <br>
      <input type="text" id="search" class="form-control" placeholder="무엇이든 물어보세요!"><br>
            <b style="float: left; padding-left: 40px;">예시1) 하나님은 왜 선악과를 만드셨나요?</b><br>
            <b style="float: left; padding-left: 40px;">예시2) 성경에서 요셉이 누구인가요?</b><br>
            <b style="float: left; padding-left: 40px;">예시3) 성경에서 노아의 방주가 뭔가요?</b><br>                <br>
                <button type="button" onclick="javascript:chat()" id="chatBtn" class="btn btn-primary">Search!</button>
                  <br><br>
          </div>

                    <img style="width: 100px; height: 120px; display: none;" id="loading" src="/resources/img/Loading.gif">


  </div>
</div>

<script type="text/javascript">


var stmnLEFT = -30; // 오른쪽 여백
var stmnGAP1 = 30; // 위쪽 여백
var stmnGAP2 = 250; // 스크롤시 브라우저 위쪽과 떨어지는 거리
var stmnBASE = 60; // 스크롤 시작위치
var stmnActivateSpeed = 10; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 20; //스크롤 속도 (클수록 느림)var stmnTimer;

function RefreshStaticMenu() {
var stmnStartPoint, stmnEndPoint;
stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10);
stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2;
if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1;
if (stmnStartPoint != stmnEndPoint) {
stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 );
document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px';
stmnRefreshTimer = stmnScrollSpeed;
}
stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed);
}
function InitializeStaticMenu() {
document.getElementById('STATICMENU').style.right = stmnLEFT + 'px'; //처음에 오른쪽에 위치. left로 바꿔도.
document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px';
RefreshStaticMenu();
}

$('.toastsDefaultBottomRight').click(function() {
    $(document).Toasts('create', {
      title: 'Toast Title',
      position: 'bottomRight',
      body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
    })
  });

function chat() {
	prompt = $("#search").val();
	$.ajax({
		type:"POST",
		url:"/album/answer",
		data:{
			prompt : prompt
		},
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            $("#loading").show();
            var input = document.getElementById("search");
            input.value = null;
            $("#chatBtn").attr("class", "btn btn-secondary");
            $("#chatBtn").attr("disabled", true);

        },
		success:function(result) {
// 			var str = "";
// 				str+="";
// 				str = str.replaceAll("\"", "");
            $("#loading").hide();
            $("#chatBtn").attr("class", "btn btn-primary");
            $("#chatBtn").attr("disabled", false);
				var body = document.getElementById("body");

				var bold = document.createElement("b");
				var div = document.createElement("div");
				bold.textContent = '질문 : ';
				div.textContent = prompt;
				div.setAttribute("class", "alert alert-success");
				bold.setAttribute("class", "bold");

				div.prepend(bold);
				body.append(div);


				var bold2 = document.createElement("b");
				var div2 = document.createElement("div");
				bold2.textContent = '응답 : ';
				div2.textContent = result;
				div2.setAttribute("class", "alert alert-info");
				bold2.setAttribute("class", "bold");

				div2.prepend(bold2);
				body.append(div2);



		},
		error:function(request,status,error) {
			alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}

	})


}




</script>

<!-- Chat GPT -->
