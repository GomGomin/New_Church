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
<section style="margin-bottom: 15px;">
<%@ include file = "../about/img_test.jsp" %>
</section>
<div id="map"></div>
<p><em>지도를 확대 또는 축소 해주세요!</em></p> 
<p id="result"></p>
<div class="map-container">
			<h2>찾아오시는 길</h2><hr>
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91966b94c8dcb08be4fe8c7e60e81bb2"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'zoom_changed', function() {        
    
    // 지도의 현재 레벨을 얻어옵니다
    var level = map.getLevel();
    
    var message = '현재 지도 레벨은 ' + level + ' 입니다';
    var resultDiv = document.getElementById('result');  
    resultDiv.innerHTML = message;
    
});
</script>
</body>
</html>