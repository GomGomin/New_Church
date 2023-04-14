<!-- 작업자 : 김남훈 -->
<!-- 작업내용 : 타일즈 베이스 레이아웃 -->
<!-- 최근 수정 내역 : 슬라이더 추가 -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>

<style>

*{
margin: 0;
padding: 0;
}

body, html{
width: 100%;
height: 100%;
}

.header{
width: 100%;
height: 90px;
}

/* .container{ */
/* width:80%; */
/* height:auto; */
/* display: flex; */
/* justify-content: center; */
/* text-align: center; */
/* margin: 0 auto; */
/* overflow: hidden; */
/* min-width: 780px; */
/* flex-direction: column; */
/* } */


.content{
width: 80%;
margin: 0 auto;
margin-bottom: 30px;
flex:1;
}

.footer{
width: 100%;
margin-bottom: 0;
height: 70px;
}

.btn_gotop {
	display:none;
	position:fixed;
	bottom:30px;
	right:30px;
	z-index:999;
	border:1px solid #ccc;
	outline:none;
	background-color:white;
	color:#333;
	cursor:pointer;
	padding:15px 20px;
	border-radius:100%;
}

.wrapper{
overflow-y: auto;
overflow-x: auto;
display:flex;
flex-direction: column;
height: 100%;
}

.image{
display: block;
}

@media screen and (max-width: 640px){

body{
overflow: scroll !important;
width: 100%;
height: 100vh !important;
}

.slide{
display: black;
}


}


</style>
<title><tiles:insertAttribute name="title" /></title>  
</head>
<body>
<div class="wrapper">
<!-- 헤더 -->
	<div class="header">
	<tiles:insertAttribute name="header" />
	</div>
<!-- 	헤더 END -->
<!-- 	슬라이더 -->
	<section class="slide">
	<tiles:insertAttribute name="main_slide" />  
	</section>
<!-- 	슬라이더 END -->
<!-- 	페이지 이미지 -->
	<section class="image"style="margin-bottom: 15px;">
	<tiles:insertAttribute name="image" />
	</section>
<!-- 	페이지 내용 -->
	<div class="content">
	<tiles:insertAttribute name="content" />  
	</div>
<!-- 	페이지 내용 END -->
<!-- 푸터 -->
	<footer class="footer">
	<tiles:insertAttribute name="footer" />  
	</footer>
<!-- 	푸터 END -->
</div>

<!-- <a href="#" class="btn_gotop" id="insert_btn"> -->
<!--   <span class="glyphicon glyphicon-chevron-up"> -->
<!--   &#9650; -->
<!--   </span> -->
<!-- </a> -->

<input type="button" class="btn_gotop" value="삽입" id = "insert_btn">

<script>
$(window).scroll(function(){
	if ($(this).scrollTop() > 10){
		console.log("gd");
		$('.btn_gotop').show();
	} else{
		$('.btn_gotop').hide();
		console.log($(this).scrollTop());
	}
});

$('.btn_gotop').click(function(){
	$('html, body').animate({scrollTop:0},400);
	return false;
});

$("#insert_btn").click(function(){
    if(confirm("정말 등록하시겠습니까 ?") == true){
        alert("등록되었습니다");
    }
    else{
        return ;
    }
});
</script>
</body>
</html>