<!-- 작업자 : 김남훈 -->
<!-- 작업 내용 : 교회 약도 페이지 -->
<!-- 최근 수정 내용 : maptest가 본체 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>오시는 길</title>
<link rel="stylesheet" href ="resources/css/map.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91966b94c8dcb08be4fe8c7e60e81bb2"></script>
</head>

<body>
<section>
	<div class="map_div">
	<h1>지도</h1>
<!-- 	지도 영역 -->
    <div id="map"></div>
<!--     지도영역 END -->
    </div>
    주소
		<div class="map-container">
			<h2>계정교회</h2><hr>
			<p>주소 : 경기도 김포시 통진읍 
			&nbsp
			&nbsp	
			&nbsp
			&nbsp
			&nbsp	
			전화번호 : 010-1234-1234</p>
		<hr>
		<br>
		<h2>예배시간</h2>
		<hr>
		<p>일요일 : 12~ 12<p>
		<hr>
		</div>
</section>

<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(30, 50), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
    var markerPosition  = new kakao.maps.LatLng(37.693155, 126.593735); 

    var marker = new kakao.maps.Marker({
        position: markerPosition
    });
    
</script>
</body>
</html>