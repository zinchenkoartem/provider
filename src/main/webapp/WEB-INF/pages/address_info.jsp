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

<div align="center">
    <table class="table table-bordered table-condensed "  style="alignment:center  ;width: auto;" >
        <thead>
        <tr>
        	<td colspan="4" align="center" style="font-size: 30px;"><b> Адрес</b></td>
        </tr>
            <tr  class="th-head" style=" color: #080808;">
   				<th >Id</th>
                <th >Адрес</th>
                <th>Изменить</th>
                <th>Удалить</th>
                </tr>
        </thead>
        <tbody>           
                <tr>
                    <td> <input   type="text"  class="form-control" readonly  value="${address.address_ID}"   style="width: 80px;"></td>
                    <td> <input   type="text"  class="form-control" readonly  value="${address.path}"   style="width: 450px;"></td>
                    <td>
                        <form action="/admin/address/update" style="margin: 1px;padding: 1px;">
                            <input type="hidden" value="${address.address_ID}" name="id">
                            <input class="btn btn-md  btn-primary btn-block" type="submit" value="Изменить">
                        </form>
                    </td>
                    <td>
                        <form action="/admin/address/delete" style="margin: 1px;padding: 1px;" onsubmit="return confirm('Удалить адрес?')">
                            <input type="hidden" value="${address.address_ID}" name="id">
                            <input class="btn btn-md  btn-primary btn-block" type="submit" value="Удалить">
                        </form>
                    </td>
                </tr>         
        </tbody>
    </table>
</div>
</body>
</html>