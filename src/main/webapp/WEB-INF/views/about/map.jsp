<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>오시는 길</title>
<link rel="stylesheet" href ="resources/css/map.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<section>
		<div id="map"></div>
		<div class="map-container">
			<div class="address">
			<p>경기도 김포시 통진읍 현대아파트</p>
			</div>
			<div class="tel">
				<i class="fa-solid fa-phone-volume fa-4x" ></i>
				<p></p>
				<p>010-1234-1234</p>
			</div>
		</div>
</section>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91966b94c8dcb08be4fe8c7e60e81bb2"></script>
<script>
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	var map = new kakao.maps.Map(container, options);
</script>
</body>
</html>