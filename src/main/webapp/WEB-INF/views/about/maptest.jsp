<!-- 작업자 : 김남훈 -->
<!-- 작업내용 : 교회약도 예배시간 -->
<!-- 최근 수정 내역 : map이 잘 안되서 이걸로 옮김 예배시간 추가해야됨 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>오시는 길</title>
<!-- <link rel="stylesheet" href ="resources/css/map.css" type="text/css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91966b94c8dcb08be4fe8c7e60e81bb2"></script>
<style>
#map{
width: 80%;
height: 400px;
margin: 0 auto;
board:1px solid light grey;
border-radius: 10px;
box-shadow: 1px 1px 2px 4px grey;
margin-top: 20px;
}

@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

.map_title{
text-align: center;
margin-top: 20px;
}


.map_title h1{
font-family: "NanumSquareNeo-Variable";
font-weight: bold;
text-decoration: underline overline;
text-underline-position : under;
text-decoration-color : #0288d1;
}

.map-container {
margin : 0 auto;
margin-top : 30px;
width: 80%;
}

.map-container h2{
font-family: "TAEBAEKmilkyway";
color: #0288d1;
font-weight: bold;
}

.map-container p{
color: #808080;
font-family : "TAEBAEKmilkyway";
font-size: 20px;
font-weight: bold;
}

table{
	margin: 0 auto;
    border-collapse: collapse;
    width: 80%;
    height: 300px;
    text-align: center;
}

th, td{
    width: 40%;
    border: 1px solid rgb(235, 235, 235);
}

th{
    background-color: rgb(216, 216, 216);
    height: 50px;
    font-family: S-CoreDream-3Light;
    font-size: 30px;
    font-weight: 400;
}

td{
    background-color: rgb(242, 249, 253);
    font-family: S-CoreDream-3Light;
    font-size: 30px;
    font-weight: 900;
    color: rgb(73, 99, 170);
    
}

tr h1{
display: inline;
background-color: rgb(242, 249, 253);
font-family: S-CoreDream-3Light;
font-size: 30px;
font-weight: 900;
}

.wednesday{
color: rgb(253, 200, 53);
}

.weekday{
color: rgb(253, 53, 53);
}
@font-face {
     font-family: 'S-CoreDream-3Light';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}
</style>
</head>
<body>

	<div class="map_title">
	<h1>약도</h1>
<!-- 	지도 영역 -->
    <div id="map"></div>
<!--     지도 영역 END -->
    </div>
<!--     주소와 시간 글 -->
	<div class="map-container">
		<h2>계정교회</h2><hr>
		<p>주소 : 경기도 양평군 양동면 양서북로 490 <p>	
		<p>전화번호 : 010-1234-1234</p>
		<hr>
		<br>
		<h2>예배시간</h2>
		<hr>
		    <table>
	            <thead>
	                <tr>
	                    <th>예배</th>
	                    <th>시간</th>
	                </tr>
	            </thead>
	
	            <tbody>
	                <tr>
	                    <td>수요 예배</td>
	                    <td><h1 class="wednesday">수요일</h1> 18시 30분</td>
	                </tr>
	                <tr>
	                    <td>주말 예배</td>
	                    <td><h1 class="weekday">주일</h1>11시 30분</td>
	                </tr>
	            </tbody>
		    </table>
	</div>
<!-- 	주소와 시간 글 END -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91966b94c8dcb08be4fe8c7e60e81bb2"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.4546, 127.7707), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'zoom_changed', function() {        
    
    // 지도의 현재 레벨을 얻어옵니다
    var level = map.getLevel();
    
    
});

var markerPosition  = new kakao.maps.LatLng(37.4546, 127.7707); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

</script>
</body>
</html>