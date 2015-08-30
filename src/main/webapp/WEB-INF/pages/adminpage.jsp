<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<html>
<head>
        <script type="text/javascript" src="/js/scripts.js"></script>
        <style type="text/css"><%@include file="css/bootstrap.css"%></style>
        <style type="text/css"><%@include file="css/style.css"%></style>
        <title>Admin page</title>
</head>

<body>
<sec:authorize  access="hasAuthority('admin')">
    <table border=0 class="table">
        <tr>
            <td><a  style="float: left;text-align: left;" class="btn btn-sm btn-primary disabled "   href="/admin/adminpage" role="button" onclick="return false" >На главную</a></td>
            <td><h4 align="center"><b>Администратор:&nbsp;&nbsp; <c:out  value="${admin.firstName}" />&nbsp; <c:out value="${admin.lastName}" /></b></h4></td>
            <td><a style="float: right;text-align: right;" class="btn btn-sm btn-primary " href="j_spring_security_logout" role="button" onclick="return confirm('Вы действительно хотите выйти?')">Выйти</a></td>
        </tr>
    </table>
</sec:authorize>
<br/><br/><br/><br/>
<p align="center" style="color: red;"> ${info}</p>

     <div align="center">
         <table class="table table-bordered table-condensed"  style="alignment:center  ;width: auto;" >
            <thead>
            <tr  >
                <td colspan="3" align="center" style="font-size: 30px;" class="padding1"><b>Управление</b></td>
            </tr>
 		<tr  class="th-head" style=" color: #080808;">
 			<td align="center" colspan="1" > Абоненты</td>
 			<td align="center" colspan="1"> Адреса</td>
 			<td  align="center" colspan="1"> Услуги</td>
 		</tr>
 	</thead>
 	<tbody>
 		<tr >
            <td>
                    <a class="btn btn-sm btn-primary btn-block" href="/admin/allclient?from=0" role="button">Все</a>
            </td>
 			<td>
                    <a class="btn btn-sm btn-primary  btn-block" href="/admin/alladdress?from=0" role="button">Все</a>
            </td>
 			<td>
                    <a class="btn btn-sm btn-primary  btn-block" href="/admin/allservice?from=0" role="button">Все</a>
            </td>
 		</tr>
 		<tr>
            <td>
                <a class="btn btn-sm btn-primary  btn-block" href="/admin/client/add" role="button">Добавить</a>
			</td>
			<td>
                <a class="btn btn-sm btn-primary  btn-block" href="/admin/address/add/" role="button">Добавить</a>
			</td>
			<td>
                <a class="btn btn-sm btn-primary btn-block" href="/admin/service/add/" role="button">Добавить</a>
			</td>
 		</tr>
 		 <tr>
 			<td>
                    <form   action="/admin/client/update" onsubmit="return isEmptyFault('cl_id_upd')" style="margin: 1px;padding: 1px;">
                    <input type="text" id="cl_id_upd" name="id" class="form-control" required placeholder="Введите номер" onclick="Color_input(this)" >
                    <input class="btn btn-sm btn-primary  btn-block"  type="submit" value="Изменить" ></form>
            </td>
 			<td>
                    <form  action="/admin/address/update" onsubmit="return isEmptyFault('adr_id_upd')" style="margin: 1px;padding: 1px;">
                    <input   type="text" id="adr_id_upd" name="id" class="form-control" required placeholder="Введите номер" onclick="Color_input(this)" >
                    <input class="btn btn-sm btn-primary btn-block" type="submit" value="Изменить" ></form>
            </td>
 			<td>
                    <form  action="/admin/service/update" onsubmit="return isEmptyFault('serv_id_upd')" style="margin: 1px;padding: 1px;">
                    <input   type="text" id="serv_id_upd" name="id" class="form-control" required placeholder="Введите номер" onclick="Color_input(this)" >
                    <input class="btn btn-sm btn-primary btn-block"  type="submit" value="Изменить"  ></form>
            </td>
 		</tr>

        <tr>
            <td>
                <form   action="/admin/client" onsubmit="return isEmptyFault('cl_id_view')" style="margin: 1px;padding: 1px;">
                    <input type="text" id="cl_id_view" name="id" class="form-control" required placeholder="Введите номер" onclick="Color_input(this)" >
                    <input class="btn btn-sm btn-primary  btn-block"  type="submit" value="Просмотреть" ></form>
            </td>
            <td>
                <form  action="/admin/address" onsubmit="return isEmptyFault('adr_id_view')" style="margin: 1px;padding: 1px;">
                    <input   type="text" id="adr_id_view" name="id" class="form-control" required placeholder="Введите номер" onclick="Color_input(this)" >
                    <input class="btn btn-sm btn-primary btn-block" type="submit" value="Просмотреть" ></form>
            </td>
            <td>
                <form  action="/admin/service" onsubmit="return isEmptyFault('serv_id_view')" style="margin: 1px;padding: 1px;">
                    <input   type="text" id="serv_id_view" name="id" class="form-control" required placeholder="Введите номер" onclick="Color_input(this)" >
                    <input class="btn btn-sm btn-primary btn-block"  type="submit" value="Просмотреть"  ></form>
            </td>
        </tr>

 		<tr>
 			<td>
                <form   action="/admin/client/delete" onsubmit="return (isEmptyFault('cl_id_del')  && confirm('Удалить абонента?'))" style="margin: 1px;padding: 1px;">
 				<input class="form-control" placeholder="Введите номер"  type="text" id="cl_id_del" name="id" required onclick="Color_input(this)" >
 				<input class="btn btn-sm btn-primary btn-block  "  type="submit" value="Удалить" ></form>
            </td>
 			<td>
                 <form   action="/admin/address/delete" onsubmit="return (isEmptyFault('adr_id_del') && confirm('Удалить адрес?'))" style="margin: 1px;padding: 1px;">
 				<input  class="form-control" placeholder="Введите номер" type="text" id="adr_id_del" name="id" required onclick="Color_input(this)" >
 				<input class="btn btn-sm btn-primary btn-block  "  type="submit" value="Удалить" ></form>
            </td>
 			<td >
                   <form   action="/admin/service/delete" onsubmit="return (isEmptyFault('serv_id_del') && confirm('Удалить услугу?'))" style="margin: 1px;padding: 1px;">
 				<input class="form-control" placeholder="Введите номер"   type="text" id="serv_id_del" name="id" required  onclick="Color_input(this)"  >
 				<input class="btn btn-sm  btn-primary btn-block "   type="submit" value="Удалить" ></form>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <a class="btn btn-sm btn-primary  btn-block  ${disabled_con_rec_button} " href="/admin/allconRequest" role="button" > Заявки на подключение: &nbsp; ${con_req_size} </a>
            </td>
        </tr>
            </tbody>
         </table>
    </div>

 </body>
</html>