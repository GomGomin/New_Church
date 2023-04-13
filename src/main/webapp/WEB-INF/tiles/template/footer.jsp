<!-- 작업자 : 김남훈 -->
<!-- 작업 내용 : footer 생성 -->
<!-- 최근 수정 내역 : 디자인 변경 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS only -->
<style>
.blog-footer{
background-color: #2E2E2E;
height: 100%;
text-align: left;
vertical-align: center;

}


.blog-footer h3{
color:white;
font-family: BookkMyungjo-Bd;
font-size: 23px;
display: inline;
}

.blog-footer p{
color:white;
font-family: BookkMyungjo-Bd;
font-size: 15px;
display: inline;
}

.info{
width: 80%;
margin: 0 auto;
padding: 15px 0;
}


@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 300;
    font-style: normal;
}

@font-face {
    font-family: 'BookkMyungjo-Bd';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

.footer_content{
display: inline;
text-align: right;
float: right;
}


@media screen and (max-width: 640px){
.blog-footer {
color: #2E2E2E !important;
}
.blog-footer p{
display: none;
}
}
</style>
</head>
<body>

<footer class="blog-footer">
	<div class="info">
	<h3>계정교회</h3>
	<div class="footer_content">
	<p>주소 : 경기 양평군 양동면 양서북로 490 /</p>
	<p>전화번호 : 010-1234-1234</p>
	</div>
	</div>
</footer>

<!-- JavaScript Bundle with Popper -->
</body>
</html>