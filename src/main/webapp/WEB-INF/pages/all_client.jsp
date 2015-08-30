<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<html>
<head>
<title>All clients info</title>
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

<div align="center">
<table class="table table-bordered table-condensed table-hover"  style="alignment:center  ;width: auto; color: #080808;" >
        <thead>
      		  <tr>
        			<td colspan="13" align="center" style="font-size: 30px;">
                        <a  href="/admin/allclient" style="color: #ffffff;" > <b> Список абонентов</b></a>
                    </td>
       		</tr>
            <tr class="th-head" >
                <th>№</th>
                <th>Имя</th>
                <th>Фамилия</th>
                <th>Email</th>
                <th>Телефон</th>
                <th>Адрес</th>
                <th>Статус</th>
                <th>Кредит</th>
                <th>Дата Рождения</th>
                <th>Тариф</th>
                <th>Баланс</th>
                <th>Изменить</th>
                <th>Удалить</th>                
                </tr>
        </thead>
        <tbody>
           <c:forEach items="${cl_list}" var="cl">
                <tr class="info" style="cursor: pointer;font-size: small;" >
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.client_ID}" /></td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.firstName}" /></td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.lastName}" /></td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.email}" /></td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.phone}" /></td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.address} кв ${cl.room}" /></td>
		                   	<c:set var="stat_tmp" value="${cl.status}"/>
		                   		<c:if test="${stat_tmp==0}" >
		 							<c:set var="status" value="Отключен" />
								</c:if>
								<c:if test="${stat_tmp==1}" >
		 							<c:set var="status" value="Активно" />
								</c:if>
								<c:if test="${stat_tmp==2}" >
		 							<c:set var="status" value="Остановлен" />
								</c:if>
                     <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${status}" /></td>
								<c:set var="credit_tmp" value="${cl.credit}"/>
		                   		<c:if test="${credit_tmp==false}" >
		 							<c:set var="credit" value="Откл" />
								</c:if>
								<c:if test="${credit_tmp==true}" >
		 							<c:set var="credit" value="Вкл" />
								</c:if>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${credit}" /></td>
                    <fmt:formatDate value="${cl.birthday}" var="dateString" type="date" dateStyle="FULL"/>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${dateString}" /></td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.tarif}" />грн</td>
                    <td onclick="location.href='/admin/client/${cl.client_ID}'"><c:out value="${cl.account}" />грн</td>
                    <td>
                        <form  action="/admin/client/update"  style="margin: 1px;padding: 1px;">
						 <input  type="hidden" name="id" value="${cl.client_ID}"  >
                            <input class="btn btn-sm btn-primary  btn-block"  type="submit" value="Изменить" >
					 	</form> 
					</td>
					<td>
                        <form method="get" action="/admin/client/delete"  onsubmit="return confirm('Удалить абонента?')" style="margin: 1px;padding: 1px;">
					 	<input class="field"  type="hidden" name="id" value="${cl.client_ID}"  >
                        <input class="btn btn-sm btn-primary  btn-block"  type="submit" value="Удалить" >
						</form>
					</td>					 					                                
                </tr>
           </c:forEach>
        </tbody>
        <thead>
        	 <tr>
        		 <td colspan="12" align="center">
        		 	<form method="get" action="/admin/client/add" style="margin: 1px;padding: 1px;">
					 	 <input  class="btn btn-sm btn-primary " type="submit" value="Добавить">
					 </form>
				</td>
                 <td colspan="1" align="right"  style="border-left-style: hidden;" >
                     <a class="btn btn-sm btn-primary ${disable_prev}"  href="/admin/allclient?from=<c:out value="${prev_page_from}" />" role="button"><</a>
                     <a class="btn btn-sm btn-primary ${disable_next}"  href="/admin/allclient?from=<c:out value="${next_page_from}" />" role="button">> </a>
                 </td>
	        </tr>
       	 </thead>
    </table>
</div>
</body>

</html>