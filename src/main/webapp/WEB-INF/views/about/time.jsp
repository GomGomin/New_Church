<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <link rel="stylesheet" href ="resources/css/vision.css" type="text/css">

    <title>교회 소개</title>
    <meta charset="UTF-8">

    <style>
    </style>
</head>
<body>
<main>

</main>
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

<<<<<<< HEAD
			$.ajax({
				type:"POST",
				url:"/pickup/delete",
				data:{
					pbno : "1"
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
=======
        $.ajax({
            type:"POST",
            url:"/pickup/delete",
            data:{
                pbno : "1"
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
>>>>>>> jiwon
// 			bid = $("#bid2").val();
// 			btitle = $("#btitle2").val();
// 			bcontent = $("#bcontent2").val();
// 			bwriter = $("#bwriter2").val();
// 			bcate = $("#bcate2").val();

        $.ajax({
            type:"POST",
            url:"/pickup/modify",
            data:{
                pbno : "2",
                pbaddress : "강서구 풍성빌딩 102호",
                pbtel : "010-3333-3333"
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