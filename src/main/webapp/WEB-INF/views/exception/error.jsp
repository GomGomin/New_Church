<%--
	작성자 : 박지원
	작성일 : 2023-04-13
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page isErrorPage="true"%>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        .clearfix:before,
        .clearfix:after {
            display: table;

            content: ' ';
        }
        .clearfix:after {
            clear: both;
        }
        body {
            background: #f0f0f0 !important;
        }
        .page-404 .outer {
            position: absolute;
            top: 0;

            display: table;

            width: 100%;
            height: 100%;
        }
        .page-404 .outer .middle {
            display: table-cell;

            vertical-align: middle;
        }
        .page-404 .outer .middle .inner {
            width: 300px;
            margin-right: auto;
            margin-left: auto;
        }
        .page-404 .outer .middle .inner .inner-circle {
            height: 300px;

            border-radius: 50%;
            background-color: #ffffff;
        }
        .page-404 .outer .middle .inner .inner-circle:hover i {
            color: #39bbdb!important;
            background-color: #f5f5f5;
            box-shadow: 0 0 0 15px #39bbdb;
        }
        .page-404 .outer .middle .inner .inner-circle:hover span {
            color: #39bbdb;
        }
        .page-404 .outer .middle .inner .inner-circle i {
            font-size: 5em;
            line-height: 1em;

            float: right;

            width: 1.6em;
            height: 1.6em;
            margin-top: -.7em;
            margin-right: -.5em;
            padding: 20px;

            -webkit-transition: all .4s;
            transition: all .4s;
            text-align: center;

            color: #f5f5f5!important;
            border-radius: 50%;
            background-color: #39bbdb;
            box-shadow: 0 0 0 15px #f0f0f0;
        }
        .page-404 .outer .middle .inner .inner-circle span {
            font-size: 11em;
            font-weight: 700;
            line-height: 1.2em;

            display: block;

            -webkit-transition: all .4s;
            transition: all .4s;
            text-align: center;

            color: #e0e0e0;
        }
        .page-404 .outer .middle .inner .inner-status {
            font-size: 20px;

            display: block;

            margin-top: 20px;
            margin-bottom: 5px;

            text-align: center;

            color: #39bbdb;
        }
        .page-404 .outer .middle .inner .inner-detail {
            line-height: 1.4em;

            display: block;

            margin-bottom: 10px;

            text-align: center;

            color: #999999;
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test='${msg == null}'>
            <div class="page-404">
                <div class="outer">
                    <div class="middle">
                        <div class="inner">
                            <!--BEGIN CONTENT-->
                            <div class="inner-circle"><i class="fa fa-home"></i><span>404</span></div>
                            <span class="inner-status">페이지를 찾을 수 없습니다!</span>
                            <span class="inner-detail">
                                잘못된 경로이거나 사라진 페이지입니다.
                                <a href="/" class="btn btn-info mtl"><i class="fa fa-home"></i>&nbsp;
                                    홈으로
                                </a>
                             </span>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="page-404">
                <div class="outer">
                    <div class="middle">
                        <div class="inner">
                            <!--BEGIN CONTENT-->
                            <div class="inner-circle"><i class="fa fa-cogs"></i><span>500</span></div>
                            <span class="inner-status">죄송합니다! 서버에 문제가 있습니다.</span>
                            <span class="inner-detail">관리자에게 문의해주세요.</span>
                            <!--END CONTENT-->
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>