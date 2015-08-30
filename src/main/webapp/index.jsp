<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>SIMPLE PROVIDER</title>
<script type="text/javascript" src="/WEB-INF/pages/js/scripts.js"></script>
<style><%@include file="WEB-INF/pages/css/bootstrap.css"%></style>

</head>

<%--<body onload='document.toHome.enter.focus();'>--%>
<body>
<br/><br/>
<div>
<h1 align="center">WELCOME TO SIMPLE PROVIDER</h1>
</div>
<br/><br/>
<div class="container" style="width: 300px;">
    <form role="form" action="/client/home" name="toHome">
        <button type="submit" id="enter" name="enter" class="btn btn-lg btn-primary btn-block">Войти</button><br>
        <a class="btn btn-lg btn-primary btn-block" href="register">Заявка на подключение</a>
    </form>
    ${info}
    </div>

</body>
</html>
