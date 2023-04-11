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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<title>계정 교회</title>
</head>
<body>



				
  
  
  
    <!-- Contact Section -->
  <div class="w3-container w3-padding-64" id="contact">
    <h1>픽업신청 수정</h1><br>
    <p class="w3-text-blue-black w3-large"><b>※ 유아 및 어린이 회원은 승.하차가 익숙해질 때까지 보호자께서 동승하여 주시기 바랍니다.</b></p>
    <p class="w3-text-blue-black w3-large"><b>※ 교회버스 승.하차 시 시간보다 10분 정도 일찍 나와주시기 바라며, 손을 흔들어 탑승 의사를 표현해 주시기 바랍니다.</b></p>
    <p class="w3-text-blue-black w3-large"><b>※ 교회버스 도착시간 보다 지연될 경우 도로사정, 차량정체 등으로 인한 지연이오니 다른 교통수단을 이용해 주시기 바랍니다.</b></p>
	<form id="form" action="/pickup/formModify?${_csrf.parameterName}=${_csrf.token}" class="form-horizontal" method="post">


<br><br>

		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">신청인</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 10%; margin-right: 1200px; margin-bottom: 10px;">
				<input class="form-control" value="${pickBoard.pbname}" id="uname" name="pbname"
					  type="text" />
			</div>
		</div>
		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">아이디</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 15%; margin-right: 1100px; margin-bottom: 10px;">
				<input class="form-control" value="${pickBoard.pbwriter}" id="uname"
					 disabled="disabled" type="text" />
			</div>
		</div>
		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">전화번호</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 15%; margin-right: 1100px; margin-bottom: 10px;">
				<input class="form-control" value="${pickBoard.pbtel}" id="uname" name="pbtel"
					  type="text" />
			</div>
		</div>
		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">신청 날짜</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 20%; margin-right: 1000px; margin-bottom: 10px;">
				<input class="form-control" value="${pickBoard.date}" id="date"
					 disabled="disabled" type="text" />
			</div>
		</div>
		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">승인 여부</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 5%; margin-right: 1250px; margin-bottom: 10px;">
				<input class="form-control" value="${pickBoard.pbstate}" id="pbstate"
					 type="text" disabled="disabled"/>
			</div>
		</div>
		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">주소</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 100%;">
	<div class="w3-third" style="width: 10%;">
  	<input name="pbno" value="${pickBoard.pbno}" type="hidden" />
  	<input name="pbaddress" id="pbaddress" value="${pickBoard.pbaddress}" type="hidden" />
	<input class="form-control" id="sample6_postcode" placeholder="우편번호" type="text" />
	</div>


	<button type="button" class="w3-aqua w3-large" onclick="sample6_execDaumPostcode()" style="margin-left: 10px;">우편번호 찾기</button>
	 		<div style="width: 33%; padding-top: 10px;">
	<input style="width: 100%;" class="form-control" id="sample6_address" placeholder="주소" type="text" />
	</div>
	 	 		<div class="w3-third" style="width: 15%; padding-top: 10px;">
<input type="text" id="sample6_detailAddress" style="width: 100%;" class="form-control" placeholder="상세주소">


	</div>
	<div class="w3-third" style="width: 15%; padding-top: 10px; padding-left: 10px;">
	<input type="text" id="sample6_extraAddress" style="width: 100%;" class="form-control" placeholder="참고항목">
			</div>
		</div>
		
</div>
	


	  <div style=" padding-top: 500px;">
	<button type="button" onclick="history.back()" class="btn btn-secondary">이전으로</button>
	<button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" class="btn btn-primary">수정</button>

</div>

  </form>
  </div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">계정교회</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>해당 픽업을 수정하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" onclick="check()" class="btn btn-primary">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

  
</body>





<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


var inputDate = $("#date").val();
var date = new Date(inputDate);
var year = date.getFullYear();
var month = ("0" + (date.getMonth() + 1)).slice(-2);
var day = ("0" + date.getDate()).slice(-2);
var hour = ("0" + date.getHours()).slice(-2);
var minute = ("0" + date.getMinutes()).slice(-2);
var second = ("0" + date.getSeconds()).slice(-2);
var ampm = hour < 12 ? "오전" : "오후";
hour = hour % 12;
hour = hour ? hour : 12;

var outputDate = year + "년 " + month + "월 " + day + "일 " + ampm + " " + hour + "시 " + minute + "분 " + second + "초";

$("#date").val(outputDate);

var pbaddress = $("#pbaddress").val();
var parts = pbaddress.split("/");
$("#sample6_postcode").val(parts[0]);
$("#sample6_address").val(parts[1]);
$("#sample6_extraAddress").val(parts[2]);
$("#sample6_detailAddress").val(parts[3]);

if ($("#pbstate").val() == '1') {
	$("#pbstate").val("승인");
}else{
	$("#pbstate").val("신청중");
}


function check() {
	$("#pbaddress").val($("#sample6_postcode").val() + "/" + $("#sample6_address").val() + "/" + $("#sample6_extraAddress").val() + "/" + $("#sample6_detailAddress").val());
	$("#form").submit();
}

    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }

</script>


</html>