<!-- 
작성자 : 심현민
최초 작성일 : 23.04.05
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
</head>
<body>
<!-- 로그인 정보 받기 -->
<sec:authentication property="principal" var="user" />
<br>
	<!-- 댓글 수정 Modal -->
	<div class="modal fade" id="modal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5">댓글 수정</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" id="replyRcontents" value="">
					<input type="hidden" class="form-control" id="replyRno" value="">
				</div>
				<div class="modal-footer">
					<button type="button" onclick="editReply()" class="btn btn-secondary">수정</button>
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END 댓글 수정 Modal -->
	<!-- 메인 -->
	<div class="container">
		<!-- 게시물 -->
		<h3>${board.btitle }</h3>
		<table class="table">
			<thead class="table-light">
				<tr>
					<th>작성자 <b>${board.bwriter }</b>&nbsp;&nbsp; 
						${fn:split(board.date,' ')[0] }&nbsp;&nbsp; 
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
						    <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
						    <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
						</svg> ${board.bview }&nbsp;&nbsp; 
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-dots" viewBox="0 0 16 16">
						    <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
						    <path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
						</svg> ${cnt }
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${board.bcontents }</td>
				</tr>
				<tr>
					<td>
						<div class="row">
							<div class="col">
								<button onclick="location.href='/boards/list'" class="form-control">목록</button>
							</div>
							<div class="col-9">
							</div>
							<div class="col">
							<sec:authorize access="isAuthenticated()">
								<c:if test="${board.bwriter==user.username }">
									<button onclick="location.href='/boards/edit?bno=${board.bno }'" class="form-control">수정</button>
								</c:if>
							</sec:authorize>
							</div>
							<div class="col">
							<sec:authorize access="isAuthenticated()">
								<c:if test="${board.bwriter==user.username }">
									<button onclick="removeBoard(${board.bno })" class="form-control">삭제</button>
								</c:if>
							</sec:authorize>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- END 게시물 -->
		<!-- 댓글 등록 -->
		<sec:authorize access="isAuthenticated()">
		<div class="row">
			<div class="col-10">
				<input type="hidden" id="bno" name="bno" value="${board.bno }" />
				<input type="hidden" id="rwriter" name="rwriter" value="${user.username}" />
				<input type="text" class="form-control" placeholder="댓글을 입력해주세요." id="rcontents" name="rcontents"/>
			</div>
			<div class="col-2">
				<button onclick="replyNewFunction()" class="form-control">등록</button>
			</div>
		</div>
		</sec:authorize>
		<!-- END 댓글 등록 -->
		<!-- 현재시각 -->
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" /><!-- 형식 변경 > String -->
		<fmt:parseDate value="${now}" var="now" pattern="yyyy-MM-dd"/><!-- String > Date -->
		<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="now" /><!-- Date > Number -->
		<!-- END 현재시각 -->
		<!-- 댓글 목록 -->
		<c:forEach items="${replyList }" var="reply">
			<br>
			<div class='border rounded p-4'>
				<div class="row">
					<div class="col-10" style="word-break:break-all">
						<!-- 댓글 등록 시간 -->
						<fmt:parseDate value="${reply.date}" pattern="yyyy-MM-dd" var="date" /><!-- String > Date -->
						<fmt:parseNumber value="${date.time / (1000*60*60*24)}" integerOnly="true" var="date" /><!-- Date > Number -->
						<fmt:parseNumber var="week" integerOnly="true" value="${(now-date)/7 }"/>
						<!-- END 댓글 등록 시간 -->
						<c:if test="${now-date!=0 }"><!-- 하루 이상 -->
							<c:if test="${now-date>=7 }"><!-- 일주 이상 -->
								<b>${reply.rwriter }</b> ${week }주 전<br>
							</c:if>
							<c:if test="${now-date<7 }"><!-- 일주 미만 -->
								<b>${reply.rwriter }</b> ${(now-date) }일 전<br>
							</c:if>
						</c:if>
						<c:if test="${now-date==0 }"><!-- 하루 미만 -->
							<b>${reply.rwriter }</b> ${fn:split(reply.date, ' ')[1] }<br>
						</c:if>
							${reply.rcontents }<c:if test="${reply.rupdate!=null }">(${reply.rupdate })</c:if>
					</div>
					<div class="col">
					<sec:authorize access="isAuthenticated()">
						<c:if test="${reply.rwriter==user.username }">
							<button onclick="modal(${reply.rno})" class="btn btn-outline-white">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
						  			<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
									<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
								</svg>
							</button>
						</c:if>
					</sec:authorize>
					</div>
					<div class="col">
					<sec:authorize access="isAuthenticated()">
						<c:if test="${reply.rwriter==user.username }">
							<button onclick="removeReply(${reply.rno})" class="btn btn-outline-white">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
											<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
								</svg>
							</button>
						</c:if>
					</sec:authorize>
					</div>
				</div>
			</div>
		</c:forEach>
		<!-- END 댓글 목록 -->
	</div>
	<!-- END 메인 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
	/* 게시물 삭제 */
	function removeBoard(bno) {
		$.ajax({
			type : "POST",
			url : "/boards/removeboard",
			data : {
				bno : bno
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				alert("게시물이 삭제되었습니다.")
				window.location.href = '/boards/list';
			},
			error : function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
		})
		window.location.href = '/boards/list';
	}
	/* 댓글 삭제 */
	function removeReply(rno) {
		$.ajax({
			type : "POST",
			url : "/boards/removereply",
			data : {
				rno : rno
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				window.location.reload();
				alert("댓글이 삭제되었습니다.")
			},
			error : function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
		})
		window.location.reload();
	}
	/* 댓글 등록 */
	function replyNewFunction() {
		$.ajax({
			type : "POST",
			url : "/boards/replynew",
			data : {
				bno : document.getElementById('bno').value,
				rwriter : document.getElementById('rwriter').value,
				rcontents : document.getElementById('rcontents').value
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				window.location.reload();
				alert("댓글이 등록되었습니다.");
			},
			error : function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
		})
		window.location.reload();
	}
	/* 댓글 수정 모달 */
	function modal(rno) {
		$.ajax({
			type : "POST",
			url : "/boards/modal",
			data : {
				rno : rno
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				$(".modal-body #replyRcontents").val(result);
				$(".modal-body #replyRno").val(rno);
				$("#modal").modal('show');
			},
			error : function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
		})
	}
	/* 댓글 수정 */
	function editReply() {
		$.ajax({
			type : "POST",
			url : "/boards/editReply",
			data : {
				rno : document.getElementById('replyRno').value,
				rcontents : document.getElementById('replyRcontents').value
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				$("#modal").modal('hide');
				window.location.reload();
			},
			error : function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
		})
		window.location.reload();
	}
</script>
</body>
</html>