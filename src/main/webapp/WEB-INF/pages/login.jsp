<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>SIMPLE PROVIDER</title>
    <script type="text/javascript" src="/js/scripts.js"></script>
    <style><%@include file="css/bootstrap.css"%></style>
</head>
<body onload='document.loginForm.id.focus();'>
<br/><br/>
<div>
    <h1 align="center">SIMPLE PROVIDER</h1>
    <br/><br/>

    <div class="container" style="width: 300px;">
        <form role="form" action="/login_check" method="post" name="loginForm">
            <div class="form-group">
                <label for="id">№ Договора</label>
                <input type="text" class="form-control" id="id" name="id" required  placeholder="Введите номер договора">
            </div>
            <div class="form-group">
                <label for="password">Пароль</label>
                <input type="password" class="form-control" id="password" name="password" required  placeholder="Пароль">
            </div>
            <div class="checkbox">
                <label><input type="checkbox" name="_spring_security_remember_me"> Запомнить меня</label>
                <%--<a  href="register">Зарегистрироваться</a>--%>
            </div>
            <button type="submit" class="btn btn-lg btn-primary btn-block" >Войти</button>
        </form>

    </div>
    <p style="color: red;" align="center">${error_message}

</div>

</body>
</html>
