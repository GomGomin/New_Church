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
	if(msg =="modifyOk"){
		alert("게시물이 수정 되었습니다.")
	}
</script>
<!-- 메인 -->
	<div class="container">
		<!-- 검색 -->
		<div class="col-lg-8 mx-auto p-4 py-md-5">
			<header class="d-flex align-items-center pb-3 mb-5 border-bottom">
				<h4 class="pb-3 mb-3">일정 ${mode eq "new" ? "작성" : "보기"}</h4>
			</header>
			<div>
				<form id = "form">
					<c:if test="${mode ne 'new'}">
						<div class="pb-3 mb-3">
							<span class="fs-6">${schedule.swriter}(관리자)</span>&nbsp; | &nbsp;
							<span class="fs-6">등록일 : ${schedule.date}</span> | &nbsp;
							<span class="fs-6">조회수 : ${schedule.sview}</span>
						</div>
					</c:if>
						<div class="col-sm-8 my-5">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<c:if test="${mode ne 'new'}">
								<input type="hidden" name="sno" value="${schedule.sno}">
							</c:if>
							<input type = "text" class = "form-control" name = "stitle" id = "stitle" placeholder="제목을 입력해 주세요." value="${schedule.stitle}" ${mode == "new" ? "" : "readonly"}>
						</div>
						<div class="col-sm-8">
							<textarea id="scontents" name = "scontents" rows="10" cols="20" class="form-control" placeholder="일정 내용을 입력해 주세요." ${mode == "new" ? "" : "readonly"}>${schedule.scontents}</textarea>
						</div>
						<div class="row my-5">
							<div class="col">
								<button type="button" id="listBtn" class="btn btn-secondary">목록</button>
								<%--<sec:authentication property="principal" var="user"/>--%>
								<%--<sec:authorize access="hasRole('ADMIN')">--%>
									<c:if test="${mode eq 'new'}">
										<button type="button" id="writeBtn" class="btn btn-secondary mx-3">등록</button>
									</c:if>
									<c:if test="${mode ne 'new'}">
										<button type="button" id="modifyBtn" class="btn btn-secondary">수정</button>
										<button type="button" id="removeBtn" class="btn btn-secondary"> 삭제</button>
									</c:if>
								<%--</sec:authorize>--%>
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
		if(form.stitle.value=="") {
			alert("제목을 입력해 주세요.");
			form.stitle.focus();
			return false;
		}
		if(form.scontents.value=="") {
			alert("내용을 입력해 주세요.");
			form.scontents.focus();
			return false;
		}
		return true;
	}
	$('#removeBtn').on("click", function(){
		if(!confirm("정말로 삭제하시겠습니까?")) return;
		let form = $('#form');
		form.attr("action", '/schedule/adminRemove?page=${page}');
		form.attr("method", "post");
		form.submit();
	});

	$('#writeBtn').on("click", function(){
		const form = $('#form');
		form.attr('action', '/schedule/register');
		form.attr('method', 'post');
		if (formCheck()) {
			form.submit();
		}
	});

	$('#listBtn').on("click", function(){
		location.href = `/schedule/list?page=${page}`;
	});
</script>
</body>
</html>
