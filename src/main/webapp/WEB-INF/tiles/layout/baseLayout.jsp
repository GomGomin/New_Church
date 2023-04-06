<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html >
<head>
	
<title><tiles:insertAttribute name="title" /></title>  
</head>
<body>

<div class="my-5">
	<div class="alert alert-dark">
		<div class="container">
        <h1 class="display-3"><tiles:insertAttribute name="header" /> </h1>  
        <p><tiles:insertAttribute name="subheading" /></p>  
		</div>
	</div>
</div>
	
<div class="container">
    <div class="row" >
        <tiles:insertAttribute name="content" />  
    </div>
    <div class="footer">
        <tiles:insertAttribute name="footer" />  
    </div>
</div>
</body>
</html>