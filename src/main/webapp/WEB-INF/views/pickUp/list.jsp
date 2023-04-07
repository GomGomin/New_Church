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
<title>계정 교회</title>


<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>


</head>
<body>



  
    <!-- Contact Section -->
  <div class="w3-container w3-padding-64" id="contact">
    <h1>계정교회 픽업신청 리스트</h1><br>
    
    
<!------------------------- form ------------------------------->






    <h3>승인 목록</h3>

<table id="example1"  class="w3-table-all w3-hoverable" style="margin-bottom: 100px;">
<thead>
<tr>
<th>No.</th>
<th>주소</th>
<th>전화번호</th>
<th>신청인</th>
</tr>
</thead>
<tbody>
<c:forEach items="${accessList}" var="access">
<tr>
<td onclick="location.href='./detail?pbwriter=${access.pbwriter}'">${access.pbno}</td>
<td onclick="location.href='./detail?pbwriter=${access.pbwriter}'" id="address1">${access.pbaddress}</td>
<td onclick="location.href='./detail?pbwriter=${access.pbwriter}'">${access.pbtel}</td>
<td onclick="location.href='./detail?pbwriter=${access.pbwriter}'">${access.pbname}</td>
<td><button type="button" class="btn btn-success btn-sm" onclick="remove('${access.pbno}')">
	픽업 완료
</button></td>
</tr>
</c:forEach>
</tbody>
</table>


    <h3>신청 목록</h3>

<table id="example2"  class="w3-table-all w3-hoverable">
<thead>
<tr>
<th>No.</th>
<th>주소</th>
<th>전화번호</th>
<th>신청인</th>
</tr>
</thead>
<tbody>
<c:forEach items="${denyList}" var="deny">
<tr>
  <%
//  pbaddress 값을 '/'를 기준으로 분리하여 배열로 만듦
     String[] addressArr = deny.getPbaddress().split("/");
  %>
  <%
    // 분리한 배열의 값을 출력
    for (int i = 0; i < addressArr.length; i++) {
      out.print(addressArr[i] + "<br>");
    }
   %>



<td onclick="location.href='./detail?pbwriter=${deny.pbwriter}'">${deny.pbno}</td>
<td onclick="location.href='./detail?pbwriter=${deny.pbwriter}'">${deny.pbaddress}</td>
<td onclick="location.href='./detail?pbwriter=${deny.pbwriter}'">${deny.pbtel}</td>
<td onclick="location.href='./detail?pbwriter=${deny.pbwriter}'">${deny.pbname}</td>
<td><button type="button" class="btn btn-primary btn-sm" onclick="access('${deny.pbno}')"> 승인
</button>
<button type="button" class="btn btn-danger btn-sm" onclick="remove('${deny.pbno}')"> 거부
</button>
</td>

</tr>
</c:forEach>
</tbody>
</table>



<!------------------------- form end ------------------------------->
	         

	</div>
</body>



<script>
var address = $("#address1").val();
var addressList = address.split('/');
console.log(addressList);

	function access(pbno) {
		$.ajax({
			type:"POST",
			url:"/pickup/access",
			data:{pbno : pbno
			},
			beforeSend : function(xhr)
	        {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success:function(result) {
				window.location.reload();
			},
			error:function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
			
		})

	}
	
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
				window.location.reload();
			},
			error:function(request, status, error) {
				alert(request.status + " " + request.responseText);
			}
			
		})

	}
  
  
</script>
</html>