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


<style>
.uploadResult {
	width: 100%;
	background: Cyan;
	border-radius: 30px;
	
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.originImgDiv {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	z-index: 100;
	width: 100%;
	height: 100%;
	backgroud: gray;
}

.originImg {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.originImg img {
	width: 500px;
}




</style>


</head>
<body>
	
  
  
  
    <!-- Contact Section -->
  <div class="w3-container w3-padding-64" id="contact">
    <h1>포토 갤러리 등록</h1><br>
    
    		<form action="/album/add?${_csrf.parameterName}=${_csrf.token}" role='form' class="form-horizontal" method="post" enctype="multipart/form-data">
	

	<br>
    <hr class="w3-opacity">
  		<div>
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">제목</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 30%; margin-right: 900px; margin-bottom: 10px;">
				<input class="form-control" id="atitle" name="atitle" required="required"
					  type="text" />
			</div>
		</div>
		<div style="padding-top: 80px;">
			<div class="w3-third" style="width: 7%; padding-top: 5px;">
				<h5>
					<b><label for="inputDescription">첨부파일</label></b>
				</h5>
			</div>
			<div class="w3-third" style="width: 20%; margin-right: 1000px; margin-bottom: 10px;">
				<input class="form-control" name="uploadFile" id="uploadFile" multiple required="required"
					  type="file" />
			</div>
		</div>
			<div class="uploadDiv"></div>
		
	<!-- 업로드 결과 출력 -->
	<div class="uploadResult" style="margin-top: 100px; width: 1000px;">
		<ul style="display: flex; flex-wrap: wrap;"></ul>
	</div>
	<!-- END 업로드 결과 출력 -->

	<!-- 썸네일 이미지 원본 표시 -->
	<div class="originImgDiv">
		<div class="originImg">
		<!-- 이미지 태그 -->
		</div>
	</div>
	<!-- END 썸네일 이미지 원본 표시 -->
	
	


	
	
	  <div style="padding-top: 50px;">
	  <button type="button" style="margin-top: 30px;" onclick="history.back()" class="btn btn-secondary">이전으로</button>
	  
	<button type="button" style="margin-top: 30px;" id="subBtn" class="btn btn-primary"><i class="fa fa-paper-plane w3-margin-right"></i>등록</button>
</div>
  </form>
  </div>
  



				

  
</body>

	<script>
	
	//썸네일 이미지 원본 표시
	
	$('.uploadResult').hide();
	
// 	function showOriginal(originImg) {
// 		$('.originImgDiv').css({"display" : "flex"}).show();
	
// 		$('.originImg').html("<img src='/album/display?fileName=" + originImg + "'>").animate({width:'100%', height:'100%'}, 1000);
// // 		alert(originImg);
		
		
	
		
// 	}//END showOriginal()
	
	//썸네일 이미지 원본 클릭 이벤트 처리
	
	$(document).on('click', '.originImg', function(event) {
		$('.originImg').animate({width:'100%', height:'100%'}, 1000);
		$(this).slideUp(1000);
	});
	
	//END 썸네일 이미지 원본 클릭 이벤트 처리
	
	//파일 종류(exe, sh, zip) 및 크기(5MB) 제한
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 2621440;

	//업로드 제한 확인
	function uploadCheck(fileName, fileSize) {
		if(regex.test(fileName)){	//확장자 확인
			alert("해당 형식의 파일은 업로드 하실 수 없습니다.");
			return false;
		}
	
		if(fileSize >= maxSize) {
			alert("업로드 허용 크기(2MB) 초과 - 업로드 불가")
			return false;
		}
		return true;
	
	 
	}
	//END 업로드 제한 확인
	
	

	
	//첨부 파일 선택 이벤트 처리
// 	$('#uploadFile').change(function(event) {
	$("input[type='file']").on('change', function(event) {
	
		var formData = new FormData();	//form처럼 key/value로 값 생성 가능
		var files = $("input[name='uploadFile']")[0].files;
		
		
		
		
		//formData 객체에 파일 추가
		for(var i=0 ; i<files.length ; i++) {
			
			//업로드 제한 확인
			if(uploadCheck(files[i].name, files[i].size)){
				formData.append("uploadFile", files[i]);
// 				return false; //업로드 중지
			}
			
			
// 			continue //제한 파일 제외
			
			
		}
// 		var file;
		$.ajax({
			dataType : 'json',
			type : 'post',
			url : '/album/upload/ajaxAction',
			data : formData,
			contentType : false,
			processData : false,
			beforeSend : function(xhr)
	        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success : function(result){
				console.log('upload ok!');
				console.log(result);
				//파일 선택 초기화
				$("input[type='file']").val('');
				
				//업로드 결과 출력 함수 호출
				showUploadedFile(result);
				
			}
		});//END ajax()
	
	});//END 첨부 파일 선택 이벤트 처리

	
	
	
	

	
	//업로드 결과 출력
	var resultUL = $('.uploadResult ul');
	

	function showUploadedFile(result) {
		$('.uploadResult').show();
		var tag="";
		
			$(result).each(function (i, obj) {
				
				//서버로 전송할 데이터들
				tag += "<li data-folder='" + obj.upFolder + "' " + 
				"data-uuid='" + obj.uuid + "' " + 
				"data-filename='" + obj.fileName + "' " + 
				"data-image='" + obj.image + "'> ";
				
				
				

					
					
					//공백이나 한글 등 인코딩 처리
					var thumbImg = encodeURIComponent(obj.upFolder + "/s_" + obj.uuid + "_" + obj.fileName);
					
					
					//썸네일 이미지 클릭 시 원본 이미지 표시
					
					var originalImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName;
					originalImg = originalImg.replace(new RegExp(/\\/g), "/");
					tag += "<img style='width:100px; height:100px;' class='original' src='/album/display?fileName=" + thumbImg + "'><br>" + obj.fileName + " <span class='btn btn-warning btn-circle'  data-file='" + thumbImg + "' data-type='image'><i class='fa fa-times'></i></span></li>";		

					
					$(document).on('click', '.original', function(event) {
						
						showOriginal(originalImg);
				});
				
			});//END each()
			resultUL.append(tag);
			
	}//END showUploadedFile()

	



	

	
	//X 표시 클릭 이벤트 처리
	resultUL.on('click', 'span', function() {
		var x = $(this).closest('li');
	
	$.ajax({
		dataType : 'text',
		type : 'post',
		url : '/album/deleteFile',
		data : 
		{	
			   fileName : $(this).data('file'),
			   type : $(this).data('type')
			},
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다. */
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(result){
// 			alert(result);
			console.log(result);
			x.remove();	//클릭된 li 삭제
			
			}
		});//END ajax()
	
	});//END X 표시 클릭 이벤트 처리
	
	
	
	
	
	//submit 버튼 클릭 이벤트 처리
		
	$('#subBtn').on('click', function(event) {
		event.preventDefault(); //기본 이벤트 막기
		
		//생성된 li의 첨부파일 정보를 폼에 추가
		var tag = "";
		$('.uploadResult ul li').each(function (i, obj) {
			var o = $(obj);
			tag += " <input type='hidden' name='fileName' " +
				   "		 value='" + o.data('filename') + "'>";
			tag += " <input type='hidden' name='upFolder' " +
			   "		 value='" + o.data('folder') + "'>";
			tag += " <input type='hidden' name='uuid' " +
			   "		 value='" + o.data('uuid') + "'>";
			tag += " <input type='hidden' name='image' " +
			   "		 value='" + o.data('image') + "'>";
		});//END each()
			
		console.log(tag);
		
	if ($('.uploadResult ul')[0].innerText === "" || $('#atitle').val() === "") {
		alert("제목과 이미지를 정확히 입력해주세요.");
	}else{
		$("form[role='form']").append(tag).submit(); //폼 전송
	}


		
		
	
	});//END submit 버튼 클릭 이벤트 처리
	
	

	
	
	
	
	
	
	</script>


</html>