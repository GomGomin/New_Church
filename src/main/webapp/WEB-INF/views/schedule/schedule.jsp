<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
<script src = "/resources/js/view.js"></script>
<!-- 메인 -->
<div class="container">
	<!-- 검색 -->
	<div class="col-lg-8 mx-auto p-4 py-md-5">
		<form action = "" method = "post" name = "form">
				<div>
					<h4 class="pb-3 mb-3 border-bottom">게시물 ${mode eq "new" ? "작성" : "보기"}</h4>
					<div>
						<div class="col-sm-6">
							<label for="stitle" class="form-label">제목</label>
							<input type = "text" class = "form-control" name = "stitle" id = "stitle" required>
						</div>
						<div class="col-sm-6">
							<label for="scontent" class="form-label">내용</label>
							<textarea id="scontent" name = "scontent" class="form-control"></textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<button onclick="history.back()" class="form-control">이전으로</button>
					</div>
					<div class="col-11"></div>
					<div class="col">
						<button onclick="location.href='/schedule/register'" class="form-control">글작성</button>
					</div>
				</div>
		</form>
	</div>


	<!-- END paging & 글작성버튼 -->
</div>
<!-- END 메인 -->
</body>
</html>
