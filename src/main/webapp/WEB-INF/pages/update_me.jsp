<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<html>
<head>
    <title>Add client</title>

    <link rel="stylesheet" href="css/jquery-ui.css">
    <script src="/js/jquery-ui.js"></script>
    <script src="/js/jquery.js" ></script>
    <%--<script src="/js/jquery-ui.min.js"></script>--%>
    <script type="text/javascript" src="/js/scripts.js"></script>

    <style type="text/css"><%@include file="css/bootstrap.css"%></style>
    <style type="text/css"><%@include file="css/style.css"%></style>

    <script>
        $(function() {
            $( "#datepicker" ).datepicker(
                    {changeMonth: true, changeYear: true, yearRange: "1950:2015",dateFormat: "yy-mm-dd",autoSize: false }),
                    $.datepicker.regional['ru'] = {
                        closeText: 'Закрыть',
                        prevText: '&#x3c;Пред',
                        nextText: 'След&#x3e;',
                        currentText: 'Сегодня',
                        monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь', 'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                        monthNamesShort:['Январь','Февраль','Март','Апрель','Май','Июнь', 'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
//           monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн','Июл','Авг','Сен','Окт','Ноя','Дек'],
                        dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
                        dayNamesShort: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
                        dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
                        weekHeader: 'Не',
//           dateFormat: 'dd.mm.yy',
                        firstDay: 1,
                        isRTL: false,
                        showMonthAfterYear: false,
                        yearSuffix: ''};
            $.datepicker.setDefaults($.datepicker.regional['ru']);
            $('div.ui-datepicker').css({ fontSize: '13px' });
        });
    </script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

    <%--<style>--%>
    <%--.datepicker{--%>
    <%--}--%>
    <%--</style>--%>

    <%--<script>--%>
    <%--$(function() {--%>
    <%--$( ".datepicker" ).datepicker(--%>
    <%--{changeMonth: true, changeYear: true, yearRange: "1950:2015",dateFormat: "dd/mm/yy",autoSize: false }),--%>
    <%--$.datepicker.regional['ru'] = {--%>
    <%--closeText: 'Закрыть',--%>
    <%--prevText: '&#x3c;Пред',--%>
    <%--nextText: 'След&#x3e;',--%>
    <%--currentText: 'Сегодня',--%>
    <%--monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь', 'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],--%>
    <%--monthNamesShort:['Январь','Февраль','Март','Апрель','Май','Июнь', 'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],--%>
    <%--//           monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн','Июл','Авг','Сен','Окт','Ноя','Дек'],--%>
    <%--dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],--%>
    <%--dayNamesShort: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],--%>
    <%--dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],--%>
    <%--weekHeader: 'Не',--%>
    <%--//           dateFormat: 'dd.mm.yy',--%>
    <%--firstDay: 1,--%>
    <%--isRTL: false,--%>
    <%--showMonthAfterYear: false,--%>
    <%--yearSuffix: ''};--%>
    <%--$.datepicker.setDefaults($.datepicker.regional['ru']);--%>
    <%--$('div.ui-datepicker').css({ fontSize: '13px' });--%>
    <%--});--%>
    <%--</script>--%>
</head>

<body>
<sec:authorize  access="hasAuthority('user')">
    <table border=0 class="table">
        <tr>
            <td><a  style="float: left;text-align: left;" class="btn btn-sm btn-primary "  href="/client/home" role="button" >На главную</a></td>
            <td><a style="float: right;text-align: right;" class="btn btn-sm btn-primary " href="j_spring_security_logout" role="button" onclick="return confirm('Вы действительно хотите выйти?')">Выйти</a></td>
        </tr>
    </table>
</sec:authorize>
<div align="center">
    <sf:form modelAttribute="clientBean"  method="POST"  action="/client/update_me" name="add_form" onsubmit="return isNumber()">
        <table class="table table-bordered table-condensed"  style="width: auto;" >
            <thead>
            <tr>
                <td colspan="2" align="center" style="font-size: 30px;">
                    <b>Изменить </b>
                    <p align="center" style="color: red;font-size: smaller;"> ${err}</p>
                </td>
            </tr>
            </thead>
            <tr>
                <td style="border-right: 0;padding: 8px;">Номер договора(авто)</td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input   class="form-control" readonly="true"  placeholder="Введите номер"  path="client_ID" cssStyle="height: 30px;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Имя </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите имя"  path="firstName" required="required" cssStyle="height: 30px;" />
                    <sf:errors path="firstName" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Фамилия </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите фамилию"  path="lastName" required="required" cssStyle="height: 30px;"  />
                    <sf:errors path="lastName" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Пароль </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:password class="form-control" placeholder="Введите пароль"  path="password" required="required" id="password1" cssStyle="height: 30px;" />
                    <sf:errors path="password" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Email </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите Email" path="email" required="required"  cssStyle="height: 30px;" />
                    <sf:errors path="email" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Дата рождения </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите дату"  path="birthday"  required="required"  id="datepicker"  cssStyle="height: 30px;"  />
                    <sf:errors path="birthday" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Телефон </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите номер" path="phone" required="required"  cssStyle="height: 30px" />
                    <sf:errors path="phone" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Статус </td>
                <td style="border-left: 0;padding: 8px;">
                        <c:set var="stat_tmp" value="${clientBean.status}"/>
                        <c:if test="${stat_tmp==0}" >
                            <c:set var="status0" value="selected" />
                            <c:set var="status_readonly" value="disabled" />
                        </c:if>
                        <c:if test="${stat_tmp==1}" >
                            <c:set var="status1" value="selected" />
                            <c:set var="usr_variant" value="disabled" />
                        </c:if>
                        <c:if test="${stat_tmp==2}" >
                            <c:set var="status2" value="selected" />
                            <c:set var="usr_variant" value="disabled" />
                        </c:if>
                    <select ${status_changer}  name="status"  class="form-control" style="height: 30px;">
                        <%--<option ${status0} disabled="disabled"   value="0">Отключено </option>--%>
                        <option ${status1}  value="1">Активировано</option>
                        <option ${status2}  value="2">Приостановлено</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Кредитование </td>
                <td style="border-left: 0;padding: 8px;">
                    <select name="credit"  class="form-control" style="height: 30px;">

                        <c:set var="credit_tmp" value="${clientBean.credit}"/>
                        <c:if test="${credit_tmp=='false'}" >
                            <c:set var="credit0" value="selected" />
                        </c:if>
                        <c:if test="${credit_tmp=='true'}" >
                            <c:set var="credit1" value="selected" />
                        </c:if>
                        <option ${credit0} value="false">Выключено</option>
                        <option ${credit1} value="true"> Включено</option>
                    </select>
                </td>
            </tr>
            <thead>
            <tr>
                <td colspan="2" align="center" style="font-size: 30px;">
                    <sf:hidden path="role"  />
                    <sf:hidden path="address_id" />
                    <sf:hidden path="room"  />
                    <sf:hidden path="account"  />
                    <input class="btn btn-lg  btn-primary btn-block " name="submit" type="submit" value="Изменить" />
                </td>
            </tr>
            </thead>
        </table>
    </sf:form>
</div>
</body>
</html>
