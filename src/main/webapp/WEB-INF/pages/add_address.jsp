<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<html>
<head>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>All service info</title>
    <script type="text/javascript" src="/js/scripts.js"></script>
    <style type="text/css"><%@include file="css/bootstrap.css"%></style>
    <style type="text/css"><%@include file="css/style.css"%></style>
</head>

<body>
<sec:authorize  access="hasAuthority('admin')">
    <table border=0 class="table">
        <tr>
            <td><a  style="float: left;text-align: left;" class="btn btn-sm btn-primary "  href="/admin/adminpage" role="button" >На главную</a></td>
            <td><h4 align="center"><b>Администратор:&nbsp;&nbsp; <c:out  value="${admin.firstName}" />&nbsp; <c:out value="${admin.lastName}" /></b></h4></td>
            <td><a style="float: right;text-align: right;" class="btn btn-sm btn-primary " href="j_spring_security_logout" role="button" onclick="return confirm('Вы действительно хотите выйти?')">Выйти</a></td>
        </tr>
    </table>
</sec:authorize>
<br/>
<p align="center" style="color: red;font-size: smaller;"> ${err}</p>
<div align="center">
    <sf:form modelAttribute="addressBean"  method="POST"  action="${action}" name="add_form"  onsubmit="return isEmptyFault('address_ID')">
        <table class="table table-bordered table-condensed "  style="alignment:center  ;width: auto;" >
            <thead>
            <tr>
                <td colspan="3" align="center" style="font-size: 30px;">
                    <b> Адрес</b>
                </td>
            </tr>
            <tr  class="th-head" style=" color: #080808;">
                <th >Id</th>
                <th >Адрес</th>
                <th>Изменить</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><sf:input class="form-control"  path="address_ID"  id="address_ID"  cssStyle="width:80px;" readonly="${readonly}" onclick="Color_input(this)"/>
                    <sf:errors path="address_ID" cssStyle="font-size: smaller;color:red;"/>
                </td>
                <td><sf:input class="form-control" required="required" placeholder="Введите адрес "  path="path"   cssStyle="width: 450px;"/>
                    <sf:errors path="path" cssStyle="font-size: smaller;color:red;"/>
                </td>
                <td><input class="btn btn-md  btn-primary btn-block" type="submit" value="${caption}"></td>
            </tr>
            </tbody>
        </table>
    </sf:form>
</div>
</body>
</html>