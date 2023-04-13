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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<style>
.contents{
width:100%;
padding: 30px;
}

.head{
padding-bottom: 30px;
width: 100%;
}

.form-control{
width: 300px; !important;
height : 50px; !important;
margin: 0; !important;
padding: 0; !important;
}

.infodetail h5{
width : 130px;
display: inline-block;
font-size: 25px;
font-weight: bold;
}


.form-control{
/* text-align: center; */
padding-left:10px;
width: !important;
display: inline-block !important;
}

.long{
width:600px !important;
}

.infodetail{
margin: 10px;
}

.short{
width:150px !important;
}

#map{
width: 45%;
height: 400px;
margin: 0 left;
board:1px solid light grey;
border-radius: 10px;
box-shadow: 1px 1px 2px 4px grey;
margin-top: 30px;
margin-left: 10px;
}
</style>
</head>
<body>



				
  
  
  
    <!-- Contact Section -->
  <div class="contents">
  	<div class="head">
	    <h1>픽업 신청 상세보기</h1><br>
	    <p class="w3-text-blue-black w3-large"><b>※ 유아 및 어린이 회원은 승.하차가 익숙해질 때까지 보호자께서 동승하여 주시기 바랍니다.</b></p>
	    <p class="w3-text-blue-black w3-large"><b>※ 교회버스 승.하차 시 시간보다 10분 정도 일찍 나와주시기 바라며, 손을 흔들어 탑승 의사를 표현해 주시기 바랍니다.</b></p>
	    <p class="w3-text-blue-black w3-large"><b>※ 교회버스 도착시간 보다 지연될 경우 도로사정, 차량정체 등으로 인한 지연이오니 다른 교통수단을 이용해 주시기 바랍니다.</b></p>
	</div>
	
	<form id="form" action="/pickup/add?${_csrf.parameterName}=${_csrf.token}" class="form-horizontal" method="post">
	
	<div class="pickinfo">
		<div class="infodetail">
			<h5>
				<b><label for="inputDescription">신청인</label></b>
			</h5>
			<input name="pbname" class="form-control short" id="uname" value="${pickBoard.pbname}"
				 disabled="disabled" type="text"/>
		</div>
		
		<div class="infodetail">
			<h5>
				<b><label for="inputDescription">아이디</label></b>
			</h5>
			<input name="pbwriter" class="form-control short" id="uname" value="${pickBoard.pbwriter}"
				 disabled="disabled" type="text" />
		</div>
		<div class="infodetail">
			<h5>
				<b><label for="inputDescription">전화번호</label></b>
			</h5>
			<input name="pbtel" class="form-control short" id="uname" value="${pickBoard.pbtel}"
				 disabled="disabled" type="text" />
		</div>
		<div class="infodetail">
			<h5>
				<b><label for="inputDescription">신청일</label></b>
			</h5>
			<input name="date" class="form-control" id="date" value="${pickBoard.date}"
				 disabled="disabled" type="text" />
		</div>
		<div class="infodetail">
			<h5>
				<b><label for="inputDescription">승인 여부</label></b>
			</h5>
			<input name="pbstate" class="form-control short" id="pbstate" value="${pickBoard.pbstate}"
				 type="text" disabled="disabled"/>
		</div>
		<div class="infodetail">
			<h5>
				<b><label for="inputDescription">주소</label></b>
			</h5>
			<input name="pbaddress" class="form-control long" id="pbaddress" value="${pickBoard.pbaddress}"
				 disabled="disabled" type="text" />
		</div>
	</div>
		
		<div id="map"></div>

  </form>
	  </div>
	  <div style="margin-left: 35px; padding-bottom: 100px;">
	<button type="button" onclick="location.href='./modify?pbwriter=${pickBoard.pbwriter}'" class="btn btn-primary">수정</button>
	<button type="button" onclick="remove('${pickBoard.pbno}')" class="btn btn-danger">삭제</button>

</div>


  

  
</body>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91966b94c8dcb08be4fe8c7e60e81bb2&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


var pbaddress = $("#pbaddress").val();
var parts = pbaddress.split("/");
$("#pbaddress").val("(" + parts[0] + ") " + parts[1] + parts[2] + " " + parts[3]);

var kakaoAddress = parts[1] + parts[2] + " " + parts[3];

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


if ($("#pbstate").val() == '1') {
	$("#pbstate").val("승인");
}else{
	$("#pbstate").val("신청중");
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

    
    
    
    kakao.maps.load(function() {

		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(kakaoAddress, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:200px;text-align:center;padding:6px 0;"><b>' + parts[1] + '<b></div>' + '<div style="width:200px;text-align:center;padding:6px 0;"><b>'+ parts[2] + parts[3] + '<b></div>'
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		
		        
		    } 
		});   
	});   
    
    
    
    
	function remove(pbno) {
		$.ajax({
			type:"POST",
			url:"/pickup/delete",
			data:{pbno : pbno
			},
			beforeSend : function(xhr)
	        {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success:function(result) {
				alert("해당 픽업 신청이 삭제되었습니다.");
				window.location.replace("/");
			},
			error:function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
			
		})

	}

    
    
    
    
</script>


</html>