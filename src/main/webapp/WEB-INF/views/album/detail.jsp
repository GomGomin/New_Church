<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<head>
<title>글 상세보기</title>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>

</head>
<body class="text-center">

<!-- 	<!-- Content Wrapper. Contains page content --> -->
<!-- 	<div class="content-wrapper"> -->
<!-- 		<!-- Content Header (Page header) --> -->
<!-- 		<div class="content-header"> -->
<!-- 			<div class="container-fluid"> -->
<!-- 				<div class="row mb-2"> -->
<!-- 					<div class="col-sm-6"> -->
<!-- 						<h1 class="m-0">글 상세보기</h1> -->
<!-- 					</div> -->
<!-- 					/.col -->
<!-- 					<div class="col-sm-6"> -->
<!-- 						<ol class="breadcrumb float-sm-right"> -->
<!-- 							<li class="breadcrumb-item"><a href="#">홈</a></li> -->
<!-- 							<li class="breadcrumb-item active">글 상세보기</li> -->
<!-- 						</ol> -->
<!-- 					</div> -->
<!-- 					/.col -->
<!-- 				</div> -->
<!-- 				/.row -->
<!-- 			</div> -->
<!-- 			<!-- /.container-fluid --> -->
<!-- 		</div> -->
<!-- 		<!-- /.content-header --> -->



<!-- 		<!-- Main content --> -->
<!-- 		<div class="content"> -->
<!-- 			<div class="container-fluid"> -->
<!-- 				<div class="row"> -->
<!-- 					<div class="col-lg-12"> -->

<!------------------------- form ------------------------------->
<fieldset>
				
				
            
            <div class="card-body">
              <div class="form-group">
                <label for="inputName">제목</label>
                 ${albums.ano}
              </div>
              <div class="form-group">
                <label for="inputDescription">작성자</label>
                 ${albums.atitle}
              </div>
              <div class="form-group">
                <label for="inputStatus">유형</label>
                 ${albums.acontents}
              </div>
              <div class="form-group">
                <label for="inputStatus">날짜</label>
                 ${albums.awriter}
              </div>
              <div class="form-group">
                <label for="inputDescription">내용</label>
                 ${albums.date}
              </div>
              <div class="form-group">
                <label for="inputDescription">내용</label>
                 ${albums.aview}
              </div>

            </div>
  <button type="button" class="btn btn-danger btn-sm" onclick="deleteBoard()" style="margin-left: 10px; float: right;">
	앨범 삭제
</button>

<button type="button" class="btn btn-success btn-sm" onclick="editBoard()" data-toggle="modal" data-target="#modal-success" style="margin-left: 10px; float: right;">
	앨범 수정
</button>       
            
            <div class="row" style="padding-bottom: 30px; padding-left: 30px;">
          <a onclick="history.back()" class="btn btn-secondary">이전으로</a>
        </div>
			</fieldset>
			
			
<!-- 댓글 -->
<div class="card">
  <div class="card-body">
	댓글 리스트
	<br><br>
<%-- <b>${cnt}개의 답변이 있습니다.</b><br> --%>
<%-- 	<c:forEach items="${replyList}" var="reply"> --%>
	
<!-- 	<div class="card"> -->
<!--   <div class="card-header"> -->
<%--     ${reply.bwriter} --%>
<!--   </div> -->
<!--   <div class="card-body"> -->
<!--     <blockquote class="blockquote mb-0"> -->
<%--       <p>${reply.bcontent}</p> --%>
<%--       <footer class="blockquote-footer">${reply.bdate}</footer> --%>
<!--     </blockquote> -->
<!--   </div> -->
<!-- </div> -->
	
	
	
<!-- <br> -->
	
	
<%-- 	</c:forEach> --%>
	
	
	<!-- 댓글 등록 -->
<%-- 	<sec:authentication property="principal" var="user"/> --%>
<%-- <input id="boardWriter" type="hidden" value="${board.bwriter}" /> --%>
<%-- <input id="bwriter" type="hidden" value="${user.username}" /> --%>
<%-- <input id="bid" type="hidden" name="bid" value="${board.bid}" > --%>
<!-- <textarea name="bcontent" id="bcontent" rows="5" class="form-control"></textarea> -->
<!-- <input type="button" class="btn btn-primary my-2" onclick="replyNewFunction()" value="댓글 등록"> -->
	
<!--   </div> -->
<!-- </div> -->
<!-- 댓글 -->
				
<!------------------------- form end ------------------------------->
				</div>
			</div>
		</div>
	</div>
</div>


</body>


<script type="text/javascript">

// function replyNewFunction() {
// 	$.ajax({
// 		type:"POST",
// 		url:"/boards/replyNew",
// 		data:{
// 			boardWriter : document.getElementById('boardWriter').value,
// 			bid : document.getElementById('bid').value,
// 			bwriter : document.getElementById('bwriter').value,
// 			bcontent : document.getElementById('bcontent').value,
// 		},
// 		beforeSend : function(xhr)
//         {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
//             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//         },
// 		success:function(result) {
// 			alert("답변 등록 성공");
// 		},
// 		error:function(request, status, error) {
// 			alert(request.status + " " + request.responseText);
// 		}
		
// 	})
	
// 	window.location.reload();
// }

// function checkFunction(bid, check) {
// 	$.ajax({
// 		type:"POST",
// 		url:"/boards/check",
// 		data:{
// 			bid : bid,
// 			check : check
// 		},
// 		beforeSend : function(xhr)
//         {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
//             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//         },
// 		success:function(result) {
// 			window.location.reload();
// 		},
// 		error:function(request, status, error) {
// 			alert(request.status + " " + request.responseText);
// 		}
		
// 	})
	

// }

		function deleteBoard() {
// 			bid = $("#bid2").val();
			
			$.ajax({
				type:"POST",
				url:"/album/delete",
				data:{
					ano : "3"
				},
				beforeSend : function(xhr)
		        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success:function(result) {
					alert("삭제 성공")
					window.location.reload();
				},
				error:function(request,status,error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
				
			})
			

		}
		
		function editBoard() {
// 			bid = $("#bid2").val();
// 			btitle = $("#btitle2").val();
// 			bcontent = $("#bcontent2").val();
// 			bwriter = $("#bwriter2").val();
// 			bcate = $("#bcate2").val();
			
			$.ajax({
				type:"POST",
				url:"/album/modify",
				data:{
					ano : "2",
					atitle : "강서구 풍성빌딩 102호",
					acontents : "010-3333-3333"
				},
				beforeSend : function(xhr)
		        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success:function(result) {
					alert("수정 성공")
					window.location.reload();
				},
				error:function(request,status,error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
				
			})
			

		}

</script>

</html>