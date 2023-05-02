<!-- 작업자 : 김남훈 -->
<!-- 작업 내용 : 메인 화면 -->
<!-- 최근 수정 내용 : 아이콘 링크 추가 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href ="resources/css/vision.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>교회 소개</title>
<meta charset="UTF-8">

<style>
.icon{
text-align: center;
width: 100%;
height: 220px;
display: inline-block;
}

.icon i{
font-size: 8em;
margin: 5%;
overflow: inherit;
color: #3b444b;
}

.icon p{
margin-top:20px;
color: black;
font-size: 30px;
}

.icon ul{
width: 100%;
height: 100%;
list-style: none;
display:flex;
justify-content: center;
}

.icon li{
text-align:center;
margin-left: 3%;
margin-right:3%;
float: left;
width:15%;
height: 150px;
}

@media screen and (max-width: 800px) {
  .icon {
    display: none;
  }
  
  
@media screen and (max-width: 640px){
body{
width: inherit !important;
height: inherit !important;
}

}
</style>

	<script>
		//오류 메시지 모달 띄우기 위한 함수
		<% String errorMessage = (String) request.getSession().getAttribute("errorMessage"); %>
		$(document).ready(function(){
			if (<%= errorMessage != null && !errorMessage.isEmpty() %>) {
				$('#error').modal('show');
				<% session.removeAttribute("errorMessage"); %>
			} else {
				$('#error').modal('hide');
			}
		});
	</script>

</head>
<body>
<section id="vision">
<!-- 아이콘 구간 -->
	<div class ="icon">
		<ul>
		<li><a href="/vision"><i class="fa-solid fa-cross"><p>교회소개</p></i></a></li>	
		<li><a href="/worship/list"><i class="fa-solid fa-book-bible"><p>예배와 말씀</p></i></a></li>	
		<li><a href="/boards/list"><i class="fa-solid fa-chalkboard-user"><p>게시판</p></i></a></li>	
		<li><a href="/notice/list"><i class="fa-solid fa-newspaper"><p>공지사항</p></i></a></li>	
		</ul>		
	</div>
<!-- 	아이콘 구간 END -->
<!-- 환영글 -->
	<div class="welcome">
			<h1>환영합니다!</h1>
			<hr>
			<p>계정교회의 비전은 하나님의 나라를 넓게 이루기 위한 새로운 교회를 세우는 것입니다. 이를 위해서는 지역사회에서 필요로 하는 복음의 메시지를 전하는 일과 그에 따른 변화를 이루어나가는 일이 중요합니다. 따라서 계정교회는 지역사회의 문제를 파악하고, 그 문제를 해결할 수 있는 실질적인 방안을 마련하며, 사랑과 관심을 바탕으로 지역사회와 교류하고 소통합니다.</p>
			<br>
			<p>	계정교회는 또한 다양한 세대와 문화를 아우르는 교회로서 성장하고, 예배와 봉사, 교육 등의 다양한 분야에서 지속적인 변화와 발전을 추구합니다. 이를 위해 교육적, 문화적, 사회적인 프로그램을 제공하고, 지속적인 리더십 개발과 전문성을 향상시키는 노력을 기울입니다.</p>
			<br>
			<p>	이러한 방식으로 계정교회는 하나님의 나라를 넓히기 위해 새로운 교회를 세우고, 지역사회와 교류하며, 세계적인 미션 활동을 전개하는 일에 힘쓰며, 하나님의 사랑과 더 나은 세상을 만드는 일에 동참합니다.</p>
	</div>
<!-- 	환영글 END -->
</section>

<!-- 오류 메시지 모달 -->
<div class="modal" id="error" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">오류 발생</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<%= errorMessage %>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


</body>
</html>