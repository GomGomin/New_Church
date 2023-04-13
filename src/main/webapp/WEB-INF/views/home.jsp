<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<style>

.slider{
width : 100%;
height: 600px;
overflow: hidden;
/* min-width: 780px; */
}

img{
width :inherit;
height:100%;
position: cover;
}

.image_text{
position:absolute;
top:20%;
left:20%;
}

.image_text2{
text-align:center;
height:40%;
position:absolute;
top:18%;
left:16%;
}

.image_text3{
text-align:center;
height:40%;
position:absolute;
top:23%;
left:6%;
}

.image_text3 p{
font-size : 28px;

}

.image_text2 p{
font-size : 25px;
}

@font-face {
    font-family: 'SDSamliphopangche_Outline';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Outline.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'Yeongdo-Rg';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/Yeongdo-Rg.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

.image_text h4, p{
font-family: "SDSamliphopangche_Outline";
color: white;
font-size: 50px;
}

.image_text h2{
font-family: "Yeongdo-Rg";
font-size: 80px;
color: #d6ffff;
font-weight: bold;
display: inline;
}

.image_text h1{
font-family: "Yeongdo-Rg";
font-size: 80px;
color: white;
font-weight: bold;
display: inline;

}

@media screen and (max-width: 640px){
/* body{ */
/* width: inherit !important; */
/* height: inherit !important; */
/* } */

.slider{
height: inherit !important;
}

.bxslider img{
width: inherit !important;
height: 100% !important;
}

.bxslider p,h1,h2{
display: none;
}
/* .slider p,h1,h2{ */
/* display: none; */
/* } */
}

</style>
</head>
<body>
<!-- 슬라이더 구간 -->
<div class="slider">
<ul class="bxslider">
<!-- 메인 슬라이더 이미지 -->
	<li><div class="image_text"><h4>새로운 시작,</h4>
	<p>지역사회와 함께하는</p>
	<h2>계정</h2><h1>교회</h1>
	</div>
	<img src="/resources/img/church1.jpg" /></li>
	<li>
<!-- 	메인 슬라이더 이미지 END -->
<!-- 슬라이더 이미지 2  -->
	<div class="image_text2">
	<p>"그러므로 너희는 새로운 것이 된 것이라 그가 부르심을 받은 자로서 하나님의 성도들과 함께
	<br>
	그리스도 예수 안에서 하나 되기 위하여 자신을 갖추고 견고하게 하라."
	<p> - 에베소서 4:22-23
	</p>
	</div>
	<img src="/resources/img/church3.jpg" /></li>
	<li>
<!-- 	슬라이더 이미지2 END -->
<!-- 슬라이더 이미지 3 -->
	<div class="image_text3">
	<p>"믿음은 바라는 것들의 실상이요, 보지 못하는 것들의 증거니"
	</p>
	<p> - 히브리서 11:1
	</p>
	</div>
	<img src="/resources/img/church5.jpg" /></li>
<!-- 	슬라이더 이미지 END -->
</ul>
</div>
<!-- 슬라이더 END -->
<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
	$('.bxslider').bxSlider();
});
//]]>

	$(document).ready(function(){
	    $('.bxslider').bxSlider( {
	        mode: 'horizontal',// 가로 방향 수평 슬라이드
	        speed: 500,        // 이동 속도를 설정
	        pager: false,      // 현재 위치 페이징 표시 여부 설정
	        moveSlides: 1,     // 슬라이드 이동시 개수
	        slideWidth: 100,   // 슬라이드 너비
	        minSlides: 4,      // 최소 노출 개수
	        maxSlides: 4,      // 최대 노출 개수
	        slideMargin: 5,    // 슬라이드간의 간격
	        auto: true,        // 자동 실행 여부
	        autoHover: true,   // 마우스 호버시 정지 여부
	        controls: false    // 이전 다음 버튼 노출 여부

	    });
	});
</script>
</body>
</html>