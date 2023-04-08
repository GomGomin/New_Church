<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<%@ page session="false" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<head>
</head>
<body>
<div class="box">
	<div class="box-inner">
		<i class="fa-solid fa-phone-volume fa-4x" ></i>
		<div class="box-contents">
		<h2>도영씨게시판</h2>0
		<br>
		<p>여러시 여러분 여러초</p>
		</div>
	</div>
</div>
<div class="box">
	<div class="box-inner">
		<i class="fa-solid fa-phone-volume fa-4x" ></i>
		<div class="box-contents">
		<h2>현민씨게시글</h2>
		<br>
		<p>여러시 여러분 여러초</p>
		</div>
	</div>
</div>
<script>
console.log($('span').text());
</script>
</body>
</html>