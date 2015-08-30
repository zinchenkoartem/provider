<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>SIMPLE PROVIDER</title>
    <script type="text/javascript" src="/js/scripts.js"></script>
    <style><%@include file="css/bootstrap.css"%></style>
</head>
<body>
<br/><br/>

    <div class="container" style="width: 300px; alignment: center;">
        <h1 align="center">Заявка подана</h1>
        <br/>
        <div style="text-align: center;">
            <a  href="${flowExecutionUrl}&_eventId=to_main_page" class="btn btn-lg btn-primary"  >На главную</a>
        </div>
    </div>
</body>
</html>
