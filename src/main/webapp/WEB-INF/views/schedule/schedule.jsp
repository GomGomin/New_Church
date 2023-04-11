<%--
	작성자 : 박지원
	작성일 : 2023-04-08
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
				<h4 class="pb-3 mb-3">일정 ${mode eq "new" ? "작성" : "보기"}</h4>
			</header>
			<div>
				<form id = "form">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<c:if test="${mode ne 'new'}">
						<input type="hidden" name="sno" value="${schedule.sno}">
						<div class="pb-3 mb-3" id="view_only">
							<span class="fs-6">${schedule.swriter}(관리자)</span>&nbsp; | &nbsp;
							<span class="fs-6">등록일 : ${schedule.date}</span> | &nbsp;
							<span class="fs-6">조회수 : ${schedule.sview}</span>
						</div>
					</c:if>
						<div class="col-sm-8 my-5">
							<input type = "text" class = "form-control" name = "stitle" id = "stitle" placeholder="제목을 입력해 주세요." value="${schedule.stitle}" ${mode == "new" ? "" : "readonly"}>
						</div>
						<div class="col-sm-8">
							<textarea id="scontents" name = "scontents" rows="8" cols="14" class="form-control" placeholder="일정 내용을 입력해 주세요." ${mode == "new" ? "" : "readonly"}>${schedule.scontents}</textarea>
						</div>
						<div class="row my-5">
							<div class="col">
								<button type="button" id="listBtn" class="btn btn-secondary">목록</button>
								<%--<sec:authentication property="principal" var="user"/>--%>
								<%--<sec:authorize access="hasRole('ADMIN')">--%>
									<c:if test="${mode eq 'new'}">
										<%--<input type="hidden" value="${user.username}" name="swriter">--%>
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
				<br>
				<br>
				<c:if test="${mode ne 'new'}">
				<div id="hideReply">
					<div>
						<h2>댓글(${schedule.replyCount})</h2>
					</div>
					<br>
					<!-- 댓글 등록 -->
					<div class="row">
						<div class="col-sm-8">
							<textarea name="rcontents" id="rcontents" class="form-control" cols="12" rows="1" placeholder="댓글을 입력해주세요."></textarea>
						</div>
						<div class="col-2">
							<button id="replyAddBtn" class="form-control">등록</button>
						</div>
					</div>
					<br>
					<input type="test" style="display: none" id = "hidden" readonly>
					<div id="reply_list"></div>
					<!-- END 댓글 등록 -->
				</c:if>
				</div>
			</div>
		<!-- END paging & 글작성버튼 -->
		</div>
	<!-- END 메인 -->
	</div>
<script>
	/*댓글 ajax START*/
    let showList = function() {
        $.ajax({
            type: 'GET',
            url: '/reply',
            data: { sno: '${schedule.sno}' },
            success: function (result) {
                for (var i = 0; i < result.length; i++) {
                    var newReply = '<div class="reply">';
                    newReply += '<p class="reply-content">' + result[i].rcontents + '</p>'
                    newReply += '<div data-rno=' + result[i].rno + ' data-sno=' + result[i].sno + ' data-rwriter=' + result[i].rwriter + '>'
                    newReply += '<span class="reply-writer">' + "작성자 : " + result[i].rwriter + '</span>'
                    newReply += '<span class="reply-date">' + "&nbsp;&nbsp;&nbsp;" + result[i].date + result[i].rupdate + '</span>'
                    newReply += '<button class="mx-3 btn-sm float-right replyModifyBtn">수정</button>'
                    newReply += '<button class="mx-3 btn-sm float-right replyRemoveBtn">삭제</button>'
					newReply += '<textarea style="display: none" name="rcontents" id="modify_contents" class="form-control" cols="12" rows="1" placeholder="새로운 댓글을 입력해주세요."></textarea>'
                    newReply += '</div></div><br><br><br>'
                    $('#reply_list').append(newReply);
                }
            }
        })
    }
	$(document).ready(function(){
		showList();

        $("#replyAddBtn").click(function(){
            if($("#rcontents").val()=="") {
                alert("댓글을 입력해 주세요.");
                $("#rcontents").focus();
                return false;
            }
            let register = {
                rwriter : 'aaaa',
                sno : '${schedule.sno}',
                rcontents : $("#rcontents").val()
            };
            $.ajax({
                type:'POST',
                url: '/reply',
                data : JSON.stringify(register),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                headers : { "content-type": "application/json"},
                dataType : 'json',
                beforeSend : function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success : function(result){
					location.reload();
                },
                error  : function() {
                    alert("댓글 등록에 실패하였습니다.");
                }
            });
        });
		$("#reply_list").on('click', '.replyModifyBtn', function() 	{
			const isReadOnlyReply = $("#hidden").attr('readonly');
			if(isReadOnlyReply=='readonly'){
				$("#hidden").attr('readonly', false);
				$("#replyAddBtn").hide()
				$("#modify_contents").show();
				$("#rcontents").hide();
				$(".replyRemoveBtn").hide();
				$(".replyModifyBtn").html("수정완료");
				return;
			}
			if($("#modify_contents").val()=="") {
				alert("댓글을 입력해 주세요.");
				$("#modify_contents").focus();
				return false;
			}
			let rno = $(this).parent().attr("data-rno");
			let modify = {
				rwriter : 'aaaa',
				rno : rno,
				rcontents : $("#modify_contents").val()
			};
			$.ajax({
				type:'PATCH',
				url: '/reply',
				data : JSON.stringify(modify),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
				headers : { "content-type": "application/json"},
				dataType : 'json',
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(result){
					alert("댓글 수정 완료");
					location.reload();
				},
				error  : function() {
					alert("댓글 수정에 실패하였습니다.");
				}
			});
		});
		$("#reply_list").on('click', '.replyRemoveBtn', function() 	{
			if(!confirm("정말로 삭제하시겠습니까?")) return;
			let rno = $(this).parent().attr("data-rno");
			let sno = $(this).parent().attr("data-sno");
			let remove = {
				sno : sno,
				rno : rno
			};
			$.ajax({
				type:'DELETE',
				url:'/reply',
				data: JSON.stringify(remove),
				headers : { "content-type": "application/json"},
				dataType : 'json',
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function (result){
					alert("댓글이 삭제되었습니다.")
				},
			});
			location.reload();
		});

	});



	/*댓글 ajax END*/

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
		form.attr("action", '/schedule/adminRemove${searchCondition.queryString}');
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
	$('#modifyBtn').on("click", function(){
		const form = $('#form');
		const isReadOnly = $("input[name=stitle]").attr('readonly');

		if(isReadOnly=='readonly'){
			$("input[name=stitle]").attr('readonly', false);
			$("textarea").attr('readonly', false);
			$("#modifyBtn").html("등록");
			$("h4").html("일정 수정");
			$("#view_only").hide();
			$("#hideReply").hide();
			return;
		}
		form.attr('action', '/schedule/modify${searchCondition.queryString}');
		form.attr('method', 'post');
		if (formCheck()) {
			form.submit();
		}
	});

	$('#listBtn').on("click", function(){
		location.href = `/schedule/list${searchCondition.queryString}`;
	});
</script>

</body>
</html>
