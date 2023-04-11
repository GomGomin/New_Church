<!-- 작업자 : 김남훈 -->
<!-- 작업내용 : 베이스 레이아웃 테스트용 -->
<!-- 최근 수정 내역 : 아마 안 쓰지 않을까? -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>
<script>

</script>
<style>

</style>
</head>
<body>
<div class="header">
<tiles:insertAttribute name="header" />
</div>
<div class="container">
<tiles:insertAttribute name="content" />  
</div>
<div class="footer">
<tiles:insertAttribute name="footer" />  
</div>
</body>
</html>