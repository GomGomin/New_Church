<!-- 
작성자 : 심현민
최초 작성일 : 23.04.05
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
</head>
<body>
<sec:authentication property="principal" var="user" />
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
					<th>작성자 ${board.bwriter } ${board.date } 조회 ${board.bview }회 댓글 ${cnt }건</th>
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
								<c:if test="${board.bwriter==user.username }">
									<button onclick="location.href='/boards/edit?bno=${board.bno }'" class="form-control">수정</button>
								</c:if>
							</div>
							<div class="col">
								<c:if test="${board.bwriter==user.username }">
									<button onclick="removeBoard(${board.bno })" class="form-control">삭제</button>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- END 게시물 -->
		<!-- 댓글 등록 -->
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
		<!-- END 댓글 등록 -->
		<!-- 댓글 목록 -->
		<table class="table">
			<tbody>
				<c:forEach items="${replyList }" var="reply">
					<tr>
						<td>
							<div class="row">
								<div class="col-10">
									${reply.rcontents }
									${reply.rwriter }
									${reply.date }
									${reply.rupdate }
								</div>
								<div class="col">
									<c:if test="${reply.rwriter==user.username }">
										<button onclick="modal(${reply.rno})" class="form-control">수정</button>
									</c:if>
								</div>
								<div class="col">
									<c:if test="${reply.rwriter==user.username }">
										<button onclick="removeReply(${reply.rno})" class="form-control">삭제</button>
									</c:if>
								</div>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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