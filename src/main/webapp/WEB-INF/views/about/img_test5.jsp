<!-- 작업자 :김남훈 -->
<!-- 작업내용 : 각 페이지 이미지 -->
<!-- 최근 수정 내용 : 이미지 더 찾아서 적용해봐야함  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.image{
width : 100%;
height: 300px;

background-image: url("/resources/img/vw-bus-g4ce60a9a6_1920.jpg");
background-size: auto;
background-repeat: no-repeat;
background-position: 20% 65%;
animation: fadein 3s;
}

@keyframes fadein {
/* 효과를 동작시간 동안 0 ~ 1까지 */
	from {
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}

</style>
<body>
<div class="image">
</div>
</body>
</html>