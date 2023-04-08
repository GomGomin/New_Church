<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>
<script>
console.log($('span').text());

</script>
<style>

*{
margin: 0;
padding: 0;
}

body{
display: block;
margin: 0 auto;
width: 100%;
height: 100%;
}

.header{
width: 100%;
height: 90px;
}

.container{
width:100%;
height:auto;
display: flex;
justify-content: center;
text-align: center;
margin: 0 auto;
overflow: hidden;
min-width: 780px;
margin-top: 15px;
}


.content{
width: 80%;
}

.footer{
width: 100%;
height:15%;
min-width: 780px;
margin: 0;
}
</style>
<title><tiles:insertAttribute name="title" /></title>  
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