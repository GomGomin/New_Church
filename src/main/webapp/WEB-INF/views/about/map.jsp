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
<style>

</style>
<body>
<section>
		<div id="map"></div>
		<div class="map-container">
			<div class="box">
				<div class="box-inner">
					<i class="fa-solid fa-phone-volume fa-4x" ></i>
					<div class="box-contents">
					<p>010-1234-1234</p>
					<br>
					<p>경기도 김포시 통진읍 현대아파트</p>
				</div>
			</div>
			</div>
			<div class="box">
				<div class="box-inner">
					<i class="fa-solid fa-phone-volume fa-4x" ></i>
					<div class="box-contents">
					<h2>예배 시간</h2>
					<br>
					<p>여러시 여러분 여러초</p>
					</div>
				</div>
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