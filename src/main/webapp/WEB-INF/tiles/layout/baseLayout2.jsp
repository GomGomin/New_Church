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