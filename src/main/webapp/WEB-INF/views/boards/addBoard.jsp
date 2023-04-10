<!-- 
작성자 : 심현민
최초 작성일 : 23.04.04
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 로그인 정보 받기 -->
<sec:authentication property="principal" var="user" />
	<!-- 메인 -->
	<div class="container">
		<!-- 게시물 등록 폼 -->
		<form:form modelAttribute="NewBoard" action="./setNewBoard?${_csrf.parameterName}=${_csrf.token}" method="post">
			<div class="mb-3">
				<label class="form-label">작성자</label> 
				<form:input type="text" class="form-control" readonly="true" value="${user.username}" path="bwriter"/>
			</div>
			<div class="mb-3">
				<label class="form-label">제목</label> 
				<form:input type="text" class="form-control" path="btitle" required="true" />
			</div>
			<div class="mb-3">
				<label class="form-label">내용</label>
				<form:textarea class="form-control" id="summernote" rows="3" path="bcontents" required="true" ></form:textarea>
			</div>
			<div class="row">
				<div class="col-10"></div>
				<div class="col">
					<button type="submit" class="form-control">등록</button>
				</div>
				<div class="col">
					<button onclick="location.href='/boards/list'" class="form-control">취소</button>
				</div>
			</div>
		</form:form>
		<!-- END 게시물 등록 폼 -->
	</div>
	<!-- END 메인 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
	$('#summernote').summernote({
	  placeholder: '입력란을 반드시 채워주세요.',
	  tabsize: 2,
	  height: 120,
	  toolbar: [
	    ['style', ['style']],
	    ['font', ['bold', 'underline', 'clear']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['table', ['table']],
	    ['insert', ['link', 'picture', 'video']],
	    ['view', ['fullscreen', 'codeview', 'help']]
	  ]
	});
</script>	
</body>
</html>