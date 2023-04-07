<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Album Add</title>
</head>
<body>

			<form:form modelAttribute="albums" action="/album/add?${_csrf.parameterName}=${_csrf.token}" class="form-horizontal" method="post">


				
			<form:input path="awriter" type="hidden" value="admin" />	

    <hr class="w3-opacity">
      <div class="w3-section">
        <label>제목</label>
 			<form:input path="atitle" type="text" class="w3-input w3-border" />
      </div>
      <div class="w3-section">
        <label>첨부파일</label>
			<form:input path="acontents" type="text" class="w3-input w3-border" />
      </div>
      <button type="submit" class="w3-button w3-black w3-margin-bottom"><i class="fa fa-paper-plane w3-margin-right"></i>Add</button>

  
  
  
  
  </form:form>
  
</body>
</html>