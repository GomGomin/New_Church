<!--
작성자 : 김도영
최초 작성일 : 23.04.04
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>

<style type="text/css">
#STATICMENU { margin: 0pt; padding: 0pt; position: absolute; z-index: 1; right: 0px; top: 0px;}

</style>



<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Amatic+SC">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<body class="text-center" onload="InitializeStaticMenu()">

<!-- Chat GPT -->

<img data-bs-toggle="offcanvas" aria-expanded="false"  data-bs-target="#offcanvasRight" aria-controls="offcanvasRight" id="STATICMENU" style="width: 100px; height: 80px;" src="/resources/img/GPT.png">


<div class="offcanvas offcanvas-end" tabindex="-1"  data-bs-scroll="true" data-bs-backdrop="false" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" style="z-index: 5">
  <div class="offcanvas-header">
    <h3 class="offcanvas-title" id="offcanvasRightLabel">Church AI[CHAT GPT]</h3>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
  <img style="width: 110px; height: 80px;" src="/resources/img/GPT2.jpg">
  <br><br>	
    <div id="body">
    <br>
      <input type="text" id="search" class="form-control" placeholder="무엇이든 물어보세요!"><br>
            <b style="float: left; padding-left: 40px;">예시1) 하나님은 왜 선악과를 만드셨나요?</b><br>
            <b style="float: left; padding-left: 40px;">예시2) 성경에서 요셉이 누구인가요?</b><br>
            <b style="float: left; padding-left: 40px;">예시3) 성경에서 노아의 방주가 뭔가요?</b><br>                <br>	
                <button type="button" onclick="javascript:chat()" id="chatBtn" class="btn btn-primary">Search!</button>
                  <br><br>	
          </div>

                    <img style="width: 100px; height: 120px; display: none;" id="loading" src="/resources/img/Loading.gif">

                  
  </div>
</div>

<!-- Chat GPT -->
  </body>

<script type="text/javascript">
var stmnLEFT = 30; // 오른쪽 여백 
var stmnGAP1 = 100; // 위쪽 여백 
var stmnGAP2 = 550; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
var stmnBASE = 100; // 스크롤 시작위치
var stmnActivateSpeed = 20; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 20; //스크롤 속도 (클수록 느림)var stmnTimer;

function RefreshStaticMenu() {
var stmnStartPoint, stmnEndPoint;
stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10);
stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2;
if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1;
if (stmnStartPoint != stmnEndPoint) {
stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 );
document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px';
stmnRefreshTimer = stmnScrollSpeed;
}
stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed);
}
function InitializeStaticMenu() {
document.getElementById('STATICMENU').style.right = stmnLEFT + 'px'; //처음에 오른쪽에 위치. left로 바꿔도.
document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px'; 
RefreshStaticMenu();
}

$('.toastsDefaultBottomRight').click(function() {
    $(document).Toasts('create', {
      title: 'Toast Title',
      position: 'bottomRight',
      body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
    })
  });

function chat() {
	prompt = $("#search").val();
	$.ajax({
		type:"POST",
		url:"/album/answer",
		data:{
			prompt : prompt
		},
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            $("#loading").show();
            var input = document.getElementById("search");
            input.value = null;
            $("#chatBtn").attr("class", "btn btn-secondary");
            $("#chatBtn").attr("disabled", true);
        
        },
		success:function(result) {
// 			var str = "";
// 				str+="";
// 				str = str.replaceAll("\"", "");
            $("#loading").hide();
            $("#chatBtn").attr("class", "btn btn-primary");
            $("#chatBtn").attr("disabled", false);
				var body = document.getElementById("body");
				
				var bold = document.createElement("b");
				var div = document.createElement("div");
				bold.textContent = '질문 : ';
				div.textContent = prompt;
				div.setAttribute("class", "alert alert-success");
				bold.setAttribute("class", "bold");

				div.prepend(bold);
				body.append(div);

				
				var bold2 = document.createElement("b");
				var div2 = document.createElement("div");
				bold2.textContent = '응답 : ';
				div2.textContent = result;
				div2.setAttribute("class", "alert alert-info");
				bold2.setAttribute("class", "bold");

				div2.prepend(bold2);
				body.append(div2);



		},
		error:function(request,status,error) {
			alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
		}
		
	})
	

}

</script>



</html>