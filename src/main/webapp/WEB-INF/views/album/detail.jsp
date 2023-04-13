<!--
작성자 : 김도영
최초 작성일 : 23.04.04
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<head>
<title>계정 교회</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<style>
</style>	
</head>


<body class="text-center">
<c:set var="username" value="${SecurityContextHolder.getContext().getAuthentication().getName()}" />
<div class="w3-container w3-black" style="text-align: left; margin-top: 10px; padding: 20px;">
  <h2>${albums.atitle}</h2>
</div>
<div style=" text-align: left; padding-left: 10px; margin-top: 10px;">

작성자 : ${albums.awriter} | 등록일 : ${albums.date} | 조회수 : ${albums.aview}
</div>

	<hr class="featurette-divider">
<!------------------------- form ------------------------------->

<c:forEach items="${attachPaths}" var="attachPaths">

				<img src="/resources/images/${attachPaths}" style="width: 1200px; height: 800px;" alt="album image"><br><br>
				
</c:forEach>	

	<hr class="featurette-divider">
<div style="padding-right: 50px; margin-bottom: 200px;">

            <sec:authorize access="hasRole('ROLE_ADMIN')">
<button type="button" class="btn btn-danger btn-sm" onclick="remove('${albums.ano}')" style="margin-left: 10px; float: right;">
	삭제
</button>
<button type="button" class="btn btn-success btn-sm" onclick="location.href='/album/modify?ano=${albums.ano}'" data-toggle="modal" data-target="#modal-success" style="margin-left: 10px; float: right;">
	수정
</button>
</sec:authorize>
<c:if test="${albums.awriter == username}">	
<button type="button" class="btn btn-danger btn-sm" onclick="remove('${albums.ano}')" style="margin-left: 10px; float: right;">
	삭제
</button>
<button type="button" class="btn btn-success btn-sm" onclick="location.href='/album/modify?ano=${albums.ano}'" data-toggle="modal" data-target="#modal-success" style="margin-left: 10px; float: right;">
	수정
</button>
				  </c:if>

<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='/album/list'" style="margin-left: 10px; float: right;">
	목록
</button>   

</div>

<!------------------------- form end ------------------------------->

</body>


<script type="text/javascript">

		function remove(ano) {
			
			$.ajax({
				type:"POST",
				url:"/album/delete",
				data:{
					ano : ano
				},
				beforeSend : function(xhr)
		        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success:function(result) {
					alert("해당 앨범이 삭제되었습니다.");
					window.location.replace("/album/list");
				},
				error:function(request,status,error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
				
			})
			

		}
		

</script>

</html>