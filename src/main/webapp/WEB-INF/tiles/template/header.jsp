<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href = "/resources/css/header.css" type="text/css">

<style>




.dropdown {
  overflow: hidden;
}


.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  border-radius: 10px;

}

.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
  border-radius: inherit;
  
}

.dropdown-content a:hover {
  background-color: #ddd;
}

.dropdown:hover .dropdown-content {
  display: block;
}

#dropdown:hover .dropdown-content {
  display: block;
}

.w3-top button{
border: none;
background-color: inherit;
}

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
     	  <div class="dropdown w3-bar-item w3-button">
           	<button>교회소개</button>
   	    	<div class="dropdown-content">
		      <a href="#">Link 1</a>
		      <a href="#">Link 2</a>
		      <a href="#">Link 3</a>
  			</div>
  		  </div>
     	  <div class="dropdown w3-bar-item w3-button">
           	<button>예배와 말씀</button>
   	    	<div class="dropdown-content">
		      <a href="#">Link 1</a>
		      <a href="#">Link 2</a>
		      <a href="#">Link 3</a>
  			</div>
  		  </div>
       	  <div class="dropdown w3-bar-item w3-button">
           	<button>게시판</button>
   	    	<div class="dropdown-content">
		      <a href="#">Link 1</a>
		      <a href="#">Link 2</a>
		      <a href="#">Link 3</a>
  			</div>
  		  </div>
      	  <div class="dropdown w3-bar-item w3-button">
           	<button>공지사항</button>
   	    	<div class="dropdown-content">
		      <a href="#">Link 1</a>
		      <a href="#">Link 2</a>
		      <a href="#">Link 3</a>
  			</div>
  		  </div>
 		  <div class="dropdown w3-bar-item w3-button" sec:authorize="hasAnyAuthority('ROLE_ADMIN')">
           	<button>픽업</button>
   	    	<div class="dropdown-content">
		      <a href="#">Link 1</a>
		      <a href="#">Link 2</a>
		      <a href="#">Link 3</a>
  			</div>
  		  </div>
    </div>
    
    <div class="w3-left" style="height: auto;">
    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-left w3-hide-large" onclick="w3_open()">
	<i class="material-icons" style="font-size: 36px">menu</i>
    </a>
    </div>
    
    <nav class="w3-sidebar w3-bar-block w3-white w3-card w3-animate-left" style="display:none" id="mySidebar">
	  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">닫기 &times;</a>
	  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">교회 소개</a>
	  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">예배와 말씀</a>
	  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">게시판</a>
	  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">공지사항</a>
 	  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button" sec:authorize="hasAnyAuthority('ROLE_ADMIN')">픽업</a>
	</nav>
    
    <!-- Right-sided navbar links -->
    <div class="w3-right">
	<sec:authorize access="isAnonymous()">
      <a href="#team" class="w3-bar-item w3-button">로그인 </a>
      <a href="#work" class="w3-bar-item w3-button">회원가입</a>
    </sec:authorize>
   	<sec:authorize access="isAuthenticated()">
      <a href="#team" class="w3-bar-item w3-button">로그아웃 </a>
    </sec:authorize>
    </div>
    
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

  </div>
</div>
