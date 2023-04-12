<!-- 작업자 : 김남훈 -->
<!-- 작업내용 : 타일즈 베이스 레이아웃 -->
<!-- 최근 수정 내역 : 슬라이더 추가 -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>

<head>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<script>
$(window).scroll(function(){
	if ($(this).scrollTop() > 150){
		$('.btn_gotop').show();
	} else{
		$('.btn_gotop').hide();
	}
});
$('.btn_gotop').click(function(){
	$('html, body').animate({scrollTop:0},400);
	return false;
});
</script>
<style>

*{
margin: 0;
padding: 0;
}

body{
display: block;
margin: 0 auto;
width: 100%;
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
min-width: 780px;
}

.footer{
width: 100%;
min-width: 780px;
margin: 0;
height: 70px;
position : relative;
transform : translateY(-100%);
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
height: auto;
min-height: 100%;
padding-bottom: 200px;
}
</style>
<title><tiles:insertAttribute name="title" /></title>  
</head>
<body>
<div class="wrapper">
<div class="header">
<tiles:insertAttribute name="header" />
</div>
<section>
<tiles:insertAttribute name="main_slide" />  
</section>
<section style="margin-bottom: 15px;">
<tiles:insertAttribute name="image" />
</section>
<div class="content">
<tiles:insertAttribute name="content" />  
</div>
</div>
<footer class="footer">
<tiles:insertAttribute name="footer" />  
</footer>

<a href="#" class="btn_gotop" id="click">
  <span class="glyphicon glyphicon-chevron-up">
  &#9650;
  </span>
</a>

</body>
</html>