<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <script type="text/javascript" src="/js/scripts.js"></script>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <style  type="text/css"><%@include file="css/bootstrap.css"%></style>
    <style type="text/css"><%@include file="css/style.css"%></style>
<title>Client Info</title>
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
<sec:authorize  access="hasAuthority('user')">
    <table border=0 class="table">
        <tr>
            <td><a style="float: right;text-align: right;" class="btn btn-sm btn-primary " href="j_spring_security_logout" role="button" onclick="return confirm('Вы действительно хотите выйти?')">Выйти</a></td>
        </tr>
    </table>
</sec:authorize>

<br><br>
<h2 align="center"> Данные абонента №:&nbsp;&nbsp; <c:out  value="${cl.client_ID}" /></h2>
 <%--<p style="color: crimson;clear: both" >  mes:  ${info} </p>--%>
<div align="center" style="clear: both;">
<table border=1  class="table table-bordered table-condensed " style="width: auto;color: #080808;" >
        <thead>
            <tr  class="th-head">
                <th>Имя</th>
                <th>Фамилия</th>
                <th>Email</th>
                <th>Телефон</th>
                <th>Адрес</th>
                <th>Кредитование</th>
                <th>День Рождения</th>
                <th>Тариф</th>
                <th>Баланс</th>
                <th>Статус</th>
                <th>Изменить</th>
                </tr>
        </thead>
        <tbody>
                <tr class="info">
                    <td><c:out value="${cl.firstName}" /></td>
                    <td><c:out value="${cl.lastName}" /></td>
                    <td><c:out value="${cl.email}" /></td>
                    <td><c:out value="${cl.phone}" /></td>
                    <td><c:out value="${cl.address} кв ${cl.room}" /></td>
                    <c:set var="credit_tmp" value="${cl.credit}"/>
		                   		<c:if test="${credit_tmp==false}" >
		 							<c:set var="credit" value="Отключено" />
								</c:if>
								<c:if test="${credit_tmp==true}" >
		 							<c:set var="credit" value="Включено" />
								</c:if>
                    <td><c:out value="${credit}" /></td>
                    <fmt:formatDate value="${cl.birthday}" var="dateString" type="date" dateStyle="FULL" pattern="dd.MM.yyy"/>
                    <td><c:out value="${dateString}" /></td>
                    <td><c:out value="${cl.tarif}" />грн</td>
                    <td><c:out value="${cl.account}" />грн</td>
                    <c:set var="stat_tmp" value="${cl.status}"/>
		                   		<c:if test="${stat_tmp==0}" >
		 							<c:set var="status" value="Отключен" />
                                </c:if>
								<c:if test="${stat_tmp==1}" >
		 							<c:set var="status" value="Активирован" />
								</c:if>
								<c:if test="${stat_tmp==2}" >
		 							<c:set var="status" value="Приостановлен" />
								</c:if>
                     <td><c:out value="${status}" /></td>
                    <td>
                        <form action="${action}" style="margin: 1px;padding: 1px;" >
                            <input type="hidden" name="id" value="${cl.client_ID}">
                            <input type="submit" class="btn btn-md btn-primary "   value="Изменить">
                        </form>
                    </td>
                </tr>
                <tr >
                	<td colspan="11" align="center" style=";border-bottom: hidden;border-left: hidden;border-right: hidden;"  >
                        <p align="center" style="color: red;"><h5>${info}</h5></td>
                </tr>
        </tbody>
    </table>
</div>

<table id="table1"  class="table table-bordered table-condensed table-hover"    style="float: left;width: auto;color: #080808;">
	<thead>
		<tr>	
			<td colspan="5" align="center"  style=" color: #ffffff;" ><b>Тарифный план</b></td>
		</tr>
		<tr  style="background-color: #a2a2a2; ">
			<th>№</th>
			<th>Название</th>
			<th>Описание</th>
			<th>Цена</th>
			<th>Отключить</th>
		</tr>
	</thead>
	<c:set var="count" value="1"/>
	<% int i=1; %>
	<c:forEach items="${cl.tarifplane}" var="tarif">
         
	<tr class="info" >
		<td> <c:out value="<%= i %>" /></td>
		<td> <c:out value="${tarif.serviceName}" /></td>
		<td> <c:out value="${tarif.serviceDescription}" /></td>
		<td> <c:out value="${tarif.servicePrice}" />грн</td>
		<td>
            <a class="btn btn-sm btn-primary" href="/client/delService?id_serv=${tarif.service_ID}&id_client=${cl.client_ID}" role="button" onclick="return confirm('Удалить услугу?')">Отключить</a>
        </td>
		<% i++; %>
	</tr>
	</c:forEach>
</table>

<table id="table2"  class="table table-bordered table-condensed table-hover"  style="width: auto;float: right;color: #080808;" >
	<thead>
		<tr>	
			<td colspan="5" align="center" style=" color: #ffffff;"><b>Доступные услуги</b></td>
		</tr>
		<tr  style="background-color: #a2a2a2; ">
            <th>№</th>
            <th>Название</th>
            <th>Описание</th>
            <th>Цена</th>
            <th>Подключить</th>
        </tr>
	</thead>
	<c:set var="count" value="1"/>
	<% int j=1; %>
	<c:forEach items="${cl.avaliableService}" var="tarif">
         
	<tr class="info">
		<td> <c:out value="<%= j %>" /></td>
		<td> <c:out value="${tarif.serviceName}" /></td>
		<td> <c:out value="${tarif.serviceDescription}" /></td>
		<td> <c:out value="${tarif.servicePrice}" />грн</td>
		<td>
            <a class="btn btn-sm btn-primary" href="/client/addService?id_serv=${tarif.service_ID}&id_client=${cl.client_ID}" role="button" onclick="return confirm('Подключить услугу?')">Подключить</a>
           <%--<form  action="addClientService"  onsubmit="return confirm('Подключить услугу?')" >--%>
		<%--<input class="field"  type="hidden" name="service_id" value="${tarif.service_ID}"  >--%>
		<%--<input class="field"  type="hidden" name="client_id" value="${cl.client_ID}"  >--%>
					 	<%--<input class="btn btn-sm btn-primary "  type="submit" value="Подключить">--%>
			 <%--</form>--%>
        </td>
		<% j++; %>
	</tr>
	</c:forEach>
</table>
</body>
</html>