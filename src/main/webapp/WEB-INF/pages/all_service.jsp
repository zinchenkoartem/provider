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

    <div align="center">
            <table class="table table-bordered table-condensed table-hover"  style="alignment:center  ;width: auto;color: #080808;" >
        <thead>
        	<tr>
        		<td colspan="6" align="center" style="font-size: 30px;">
                    <a  href="/admin/allservice" style="color: #ffffff;" ><b>  Список услуг</b></a>
                </td>
        	</tr>
            <tr class="th-head">
                <th>Id</th>
                <th>Название</th>
                <th>Описание</th>
                <th>Цена</th>
                <th>Изменить</th>
         		<th>Удалить</th>
                </tr>
        </thead>
        <tbody>
           <c:forEach items="${serv_list}" var="serv">
                <tr class="info" style="cursor: pointer;">
                    <td onclick="location.href='/admin/service/${serv.service_ID}'"><c:out value="${serv.service_ID}" /></td>
                    <td onclick="location.href='/admin/service/${serv.service_ID}'"><c:out value="${serv.serviceName}" /></td>
                    <td onclick="location.href='/admin/service/${serv.service_ID}'"><c:out value="${serv.serviceDescription}" /></td>
                    <td onclick="location.href='/admin/service/${serv.service_ID}'"><c:out value="${serv.servicePrice}" /> &nbsp;грн</td>
                    <td>
                        <form  action="/admin/service/update" style="margin: 1px;padding: 1px;"  >
                             <input  type="hidden" name="id" value="${serv.service_ID}"  >
                             <input  class="btn btn-sm btn-primary  btn-block"   type="submit" value="Изменить">
                         </form>
                    </td>
					<td>
                      <form  action="/admin/service/delete" onsubmit="return confirm('Удалить услугу?')" style="margin: 1px;padding: 1px;" >
                         <input class="field"  type="hidden" name="id" value="${serv.service_ID}"  >
                         <input   class="btn btn-sm btn-primary  btn-block" type="submit" value="Удалить">
					 </form>
                    </td>
                </tr>
           </c:forEach>
        </tbody>
        
 <thead>
       <tr>
          <%--<td colspan="1" align="left" style="border-right-style: hidden;">--%>
               <%--<a class="btn btn-sm btn-primary ${disable_prev}" href="/admin/allservice?from=<c:out value="${prev_page_from}" />" role="button"><</a>--%>
         <%--</td>--%>
         <td colspan="5" align="center">
         	<form  action="/admin/service/add" style="margin: 1px;padding: 1px;" >
					 <input  class="btn btn-md btn-primary "  type="submit" value="Добавить">
			 </form> 
		</td>
        <td colspan="1" align="right" style="border-left-style: hidden;" >
            <a class="btn btn-sm btn-primary ${disable_prev}" href="/admin/allservice?from=<c:out value="${prev_page_from}" />" role="button"><</a>
               <a class="btn btn-sm btn-primary ${disable_next}"  href="/admin/allservice?from=<c:out value="${next_page_from}" />" role="button">> </a>
       </td>
  	 </tr>
 </thead>     
        
    </table>
</div>
</body>
</html>