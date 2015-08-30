<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
       <title>All connection request</title>
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
        		<td colspan="8" align="center" style="font-size: 30px; color: #ffffff;"><b>  Список заявок</b></td>
        	</tr>
            <tr class="th-head">
                <th>Id</th>
                <th>Имя</th>
                <th>Фамилия</th>
                <th>Адрес</th>
                <th>Почта</th>
                <th>Телефон</th>
         		<th>Добавить</th>
         		<th>Удалить</th>
                </tr>
        </thead>
        <tbody>
           <c:forEach items="${conRequest_list}" var="list">
                <tr class="info" style="cursor: pointer;">
                    <td onclick="location.href='/admin/conRequest/add?id=${list.id}'"><c:out value="${list.id}" /></td>
                    <td onclick="location.href='/admin/conRequest/add?id=${list.id}'"><c:out value="${list.firstName}" /></td>
                    <td onclick="location.href='/admin/conRequest/add?id=${list.id}'"><c:out value="${list.lastName}" /></td>
                    <td onclick="location.href='/admin/conRequest/add?id=${list.id}'"><c:out value="${list.addressBean.path}"/>&nbsp;кв. <c:out value="${list.room}" /></td>
                    <td onclick="location.href='/admin/conRequest/add?id=${list.id}'"><c:out value="${list.email}"/></td>
                    <td onclick="location.href='/admin/conRequest/add?id=${list.id}'"><c:out value="${list.phone}"/></td>
                    <td>
                        <form  action="/admin/conRequest/add" style="margin: 1px;padding: 1px;"  >
                             <input  type="hidden" name="id" value="${list.id}" >
                             <input  class="btn btn-sm btn-primary  btn-block"   type="submit" value="Добавить">
                         </form>
                    </td>
					<td>
                      <form  action="/admin/conRequest/delete" onsubmit="return confirm('Удалить завку?')" style="margin: 1px;padding: 1px;" >
                         <input class="field"  type="hidden" name="id" value="${list.id}"  >
                         <input   class="btn btn-sm btn-primary  btn-block" type="submit" value="Удалить">
					 </form>
                    </td>
                </tr>
           </c:forEach>
        </tbody>
        
 <thead>
       <tr>
        <td colspan="8" align="right"> <%--style="border-left-style: hidden;"--%>
            <a class="btn btn-sm btn-primary ${disable_prev}" href="/admin/allconRequest?from=<c:out value="${prev_page_from}" />" role="button"><</a>
               <a class="btn btn-sm btn-primary ${disable_next}"  href="/admin/allconRequest?from=<c:out value="${next_page_from}" />" role="button">> </a>
       </td>
  	 </tr>
    </thead>
    </table>
</div>
</body>
</html>