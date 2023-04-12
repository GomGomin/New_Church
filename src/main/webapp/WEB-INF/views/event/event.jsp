<%--
	작성자 : 박지원
	작성일 : 2023-04-09
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
	<title>Home</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<%--<script src = "/resources/js/view.js"></script>--%>
<script>
	let msg = "${msg}";
	if(msg=="registerError"){
		alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.")
	}
	if(msg=="modifyError") {
		alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
	}
</script>
<!-- 메인 -->
<div class="container">
	<!-- 검색 -->
	<div class="col-lg-8 mx-auto p-4 py-md-5">
		<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
			<h4 class="pb-3 mb-3">행사 ${mode eq "new" ? "작성" : "보기"}</h4>
		</header>
		<div>
			<form id = "form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<c:if test="${mode ne 'new'}">
					<input type="hidden" name="eno" value="${event.eno}">
					<div class="pb-3 mb-3" id="view_only">
						<span class="fs-6">${event.ewriter}(관리자)</span>&nbsp; | &nbsp;
						<span class="fs-6">등록일 : ${event.date}</span> | &nbsp;
						<span class="fs-6">조회수 : ${event.eview}</span>
					</div>
				</c:if>
				<div class="col-sm-8 my-5">
					<input type = "text" class = "form-control" name = "etitle" id = "etitle" placeholder="제목을 입력해 주세요." value="${event.etitle}" ${mode == "new" ? "" : "readonly"}>
				</div>
				<div class="col-sm-8 my-5 except_view" style="${mode ne 'new' ? 'display: none' : ''}">
					<input type="text" class="form-control" name="efile" id="efile" placeholder="영상 링크를 입력해 주세요." value="${event.efile}">
				</div>
				<c:if test="${mode ne 'new'}">
					<div class="col-sm-8 my-5" id="screen">
						<iframe width="550" height="315" src="${event.efile}" allowfullscreen></iframe>
					</div>
				</c:if>
				<br>
				<div class="col-sm-8">
					<textarea id="econtents" name = "econtents" rows="10" cols="10" class="form-control" placeholder="본문 또는 내용을 입력해 주세요." ${mode == "new" ? "" : "readonly"}>${event.econtents}</textarea>
				</div>
				<div class="row my-5">
					<div class="col">
						<button type="button" id="listBtn" class="btn btn-secondary">목록</button>
						<sec:authentication property="principal" var="user"/>
						<sec:authorize access="hasRole('ADMIN')">
							<c:if test="${mode eq 'new'}">
								<input type="hidden" value="${user.username}" name="ewriter">
								<button type="button" id="writeBtn" class="btn btn-secondary mx-3">등록</button>
							</c:if>
							<c:if test="${mode ne 'new'}">
								<button type="button" id="modifyBtn" class="btn btn-secondary">수정</button>
								<button type="button" id="removeBtn" class="btn btn-secondary"> 삭제</button>
							</c:if>
						</sec:authorize>
					</div>
				</div>
			</form>
		</div>
		<!-- END paging & 글작성버튼 -->
	</div>
	<!-- END 메인 -->
</div>
<script>
	let formCheck = function() {
		let form = document.getElementById("form");
		if(form.etitle.value=="") {
			alert("제목을 입력해 주세요.");
			form.etitle.focus();
			return false;
		}
		if(form.econtents.value=="") {
			alert("내용을 입력해 주세요.");
			form.econtents.focus();
			return false;
		}
		return true;
	}
	$('#removeBtn').on("click", function(){
		if(!confirm("정말로 삭제하시겠습니까?")) return;
		let form = $('#form');
		form.attr("action", '/event/adminRemove${searchCondition.queryString}');
		form.attr("method", "post");
		form.submit();
	});

	$('#writeBtn').on("click", function(){
		const form = $('#form');
		form.attr('action', '/event/register');
		form.attr('method', 'post');
		if (formCheck()) {
			form.submit();
		}
	});
	$('#modifyBtn').on("click", function(){
		const form = $('#form');
		const isReadOnly = $("input[name=etitle]").attr('readonly');

		if(isReadOnly=='readonly'){
			$("input[name=etitle]").attr('readonly', false);
			$("input[name=efile]").attr('readonly', false);
			$("textarea").attr('readonly', false);
			$("#modifyBtn").html("등록");
			$("h4").html("행사 수정");
			$("#view_only").hide();
			$("#screen").hide();
			$(".except_view").show();
			return;
		}
		form.attr('action', '/event/modify${searchCondition.queryString}');
		form.attr('method', 'post');
		if (formCheck()) {
			form.submit();
		}
	});

	$('#listBtn').on("click", function(){
		location.href = `/event/list${searchCondition.queryString}`;
	});
</script>
</body>
</html>