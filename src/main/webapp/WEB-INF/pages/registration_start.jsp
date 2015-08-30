<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Add connection Request</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

    <script type="text/javascript" src="/js/scripts.js"></script>
    <style type="text/css"><%@include file="css/bootstrap.css"%></style>
    <style type="text/css"><%@include file="css/style.css"%></style>

     <script>
        //        Autocomplete script
        $(function() {
            var availableTags = [
                <c:forEach items="${adr_list}" var="adr">
                { label:"<c:out value="${adr.path}"/>",
                    key:"<c:out value="${adr.address_ID}"/>"},
                </c:forEach>
            ];
            $( "#address" ).autocomplete({
                source: availableTags,
                minLength: 3,
                change: function (event, ui){
                    var isValid = false;
                    for (i in availableTags) {
                        if (availableTags[i].label.toLowerCase()===(this.value.toLowerCase())) {
                            ValueKey= availableTags[i].key;
                            isValid = true;
                            break;
                        }
                    }
                    if (!isValid) {
                        this.style.borderColor="red";
                        this.value = "";
                    } else {
                        this.style.borderColor="white";
                        $("#address_id").val(ValueKey);
                    }
                },
                select: function  (event, ui) {
                    $("#address_id").val(ui.item.key)
                }
            }).keyup(function() {
                previousValue = "";
                var isValid = false;
                for (i in availableTags) {
                    if (availableTags[i].label.toLowerCase().match(this.value.toLowerCase())) {
                        isValid = true;
                    }
                }
                if (!isValid) {
                    this.value = previousValue;
                } else {
                    previousValue = this.value;
                }
            })
        });
    </script>

</head>
<body>
<c:if
        test="${not empty flowRequestContext.messageContext.allMessages}">

        <c:forEach items="${flowRequestContext.messageContext.allMessages}" var="message">
           <c:if test="${message.source eq 'firstName' }">
               <c:set var="firstName_err" value="${message.text}"/>
           </c:if>
            <c:if test="${message.source eq 'lastName' }">
                <c:set var="lastName_err" value="${message.text}"/>
            </c:if>
            <c:if test="${message.source eq 'phone' }">
                <c:set var="phone_err" value="${message.text}"/>
            </c:if>
            <c:if test="${message.source eq 'address_id' }">
                <c:set var="address_id_err" value="${message.text}"/>
            </c:if>
            <c:if test="${message.source eq 'email' }">
                <c:set var="email_err" value="${message.text}"/>
            </c:if>
            <c:if test="${message.source eq 'room' }">
                <c:set var="room_err" value="${message.text}"/>
            </c:if>

        </c:forEach>

</c:if>
<table border=0 class="table">
    <tr>
        <td><a  style="float: left;text-align: left;" class="btn btn-sm btn-primary "  href="/index" role="button" >На главную</a></td>
    </tr>
</table>
<br>
<div align="center">
    <sf:form modelAttribute="con_request"  method="POST"   name="add_form" onsubmit="return isNumber()">
        <table class="table table-bordered table-condensed"  style="width: auto;" >
            <thead>
            <tr>
                <td colspan="2" align="center" style="font-size: 30px;">
                    <b>Оформление</b>
                </td>
            </tr>
            </thead>

            <tr>
                <td style="border-right: 0;padding: 8px;">Имя </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите имя"  path="firstName" required="required" id ="firstName" cssStyle="height: 30px;"  onclick="Border_col_reset(this)"    />
                 <small style="color: red;font-size: smaller;">  <c:out value="${firstName_err}"/></small>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Фамилия </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите фамилию"  path="lastName" required="required" cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <small style="color: red;font-size: smaller;">  <c:out value="${lastName_err}"/> </small>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Email </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control"  placeholder="Введите Email" path="email" required="required"  cssStyle="height: 30px;" onclick="Border_col_reset(this)"  />
                    <small style="color: red;font-size: smaller;">  <c:out value="${email_err}"/></small>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Телефон </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите номер" path="phone" required="required"  cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <small style="color: red;font-size: smaller;">  <c:out value="${phone_err}"/></small>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Квартира </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control"  placeholder="Введите номер"  path="room" required="required"  id="room" cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <small style="color: red;font-size: smaller;">  <c:out value="${room_err}"/></small>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Адрес </td>
                <td style="border-left: 0;padding: 8px;">
                    <input class="form-control" placeholder="Введите адрес"  required="required"  <%--name="address_id"--%>  id="address"    style="height: 30px;" />
                    <small style="color: red;font-size: smaller;">  <c:out value="${address_id_err}"/></small>
                </td>
            </tr>
            <thead>
            <tr>
                <td colspan="2" align="center" style="font-size: 30px;">
                    <sf:hidden path="address_id"  id="address_id" />
                    <input class="btn btn-lg  btn-primary btn-block " name="_eventId_submit" type="submit" value="Добавить заявку" />
                </td>
            </tr>
            </thead>
        </table>
    </sf:form>
</div>


</body>
</html>





