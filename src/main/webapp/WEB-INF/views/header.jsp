<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href = "/resources/css/header.css" type="text/css">
<style>

</style>

<script>

function w3_open() {
	  if (mySidebar.style.display == 'block') {
	    mySidebar.style.display = 'none';
	    alert("gd");
	  } else {
	    mySidebar.style.display = 'block';
	  }
	}

// Close the sidebar with the close button
function w3_close() {
    mySidebar.style.display = "none";
}

</script>
</head>
<body>

<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-card" id="myNavbar">
    <a href="#home" class="w3-bar-item w3-button w3-wide">LOGO</a>
    <!-- Right-sided navbar links -->
    <div class="w3-left w3-hide-small w3-hide-medium">
      <a href="#team" class="w3-bar-item w3-button">교회 소개 </a>
      <a href="#work" class="w3-bar-item w3-button">예배와 말씀</a>
      <a href="#pricing" class="w3-bar-item w3-button">게시판 </a>
      <a href="#contact" class="w3-bar-item w3-button">공지사항</a>
    </div>
    
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-left w3-hide-large" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
    
    <nav class="w3-sidebar w3-bar-block w3-white w3-card w3-animate-left" style="display:none" id="mySidebar">
	  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">닫기 &times;</a>
	  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">교회 소개</a>
	  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">예배와 말씀</a>
	  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">게시판</a>
	  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">공지사항</a>
	</nav>
    
    <!-- Right-sided navbar links -->
    <div class="w3-right">
      <a href="#team" class="w3-bar-item w3-button">로그인 </a>
      <a href="#work" class="w3-bar-item w3-button">회원가입</a>
    </div>
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

  </div>
</div>
