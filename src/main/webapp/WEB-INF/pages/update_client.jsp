<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<html>
<head>
<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
<title>Add client</title>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

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

<sec:authorize  access="hasAuthority('admin')">
    <table border=0 class="table">
        <tr>
            <td><a  style="float: left;text-align: left;" class="btn btn-sm btn-primary "  href="/admin/adminpage" role="button" >На главную</a></td>
            <td><h4 align="center"><b>Администратор:&nbsp;&nbsp; <c:out  value="${admin.firstName}" />&nbsp; <c:out value="${admin.lastName}" /></b></h4></td>
            <td><a style="float: right;text-align: right;" class="btn btn-sm btn-primary " href="j_spring_security_logout" role="button" onclick="return confirm('Вы действительно хотите выйти?')">Выйти</a></td>
        </tr>
    </table>
</sec:authorize>
    <p align="center" style="color: red;font-size: smaller;"> ${err}</p>

<div align="center">
        <sf:form modelAttribute="clientBean"  method="POST"  action="/admin/client/update" name="add_form" onsubmit="return isNumber()">
            <table class="table table-bordered table-condensed"  style="width: auto;" >
            <thead>
                <tr>
                    <td colspan="2" align="center" style="font-size: 30px;">
                        <b>Изменить абонента</b>
                    </td>
                </tr>
                </thead>
            <tr>
                <td style="border-right: 0;padding: 8px;">Номер (0-авто)</td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input   class="form-control" placeholder="Введите номер"  required="required" readonly="true"  id="cl_id" path="client_ID" cssStyle="height: 30px;"  />
                    <sf:errors path="client_ID" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>

            <tr>
                <td style="border-right: 0;padding: 8px;">Имя </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите имя"  path="firstName" required="required" id ="firstName" cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="firstName" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Фамилия </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите фамилию"  path="lastName" required="required" cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="lastName" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Пароль </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:password class="form-control" placeholder="Введите пароль"  path="password"  id="password1" required="required" cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="password" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Email </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите Email" path="email" required="required"  cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="email" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Дата рождения </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите дату"  path="birthday" required="required"   id="datepicker"  cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="birthday" cssStyle="font-size: smaller;color:red;"/>
                    <%--cssClass="datepicker"--%>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Телефон </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите номер" path="phone" required="required"  cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="phone" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Баланс </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите сумму" path="account" required="required"  id="account" cssStyle="height: 30px;" onclick="Border_col_reset(this)"    />
                    <sf:errors path="account" cssStyle="font-size: smaller;color:red;"/>
                </td>
             </tr>
             <tr>
                <td style="border-right: 0;padding: 8px;">Квартира </td>
                <td style="border-left: 0;padding: 8px;">
                    <sf:input class="form-control" placeholder="Введите номер"  path="room" required="required"  id="room" cssStyle="height: 30px;" onclick="Border_col_reset(this)"   />
                    <sf:errors path="room" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Адрес </td>
                <td style="border-left: 0;padding: 8px;">
                    <input class="form-control" placeholder="Введите адрес"  value="${clientBean.addressBean.path}" required="required"  id="address"    style="height: 30px;" />
                    <sf:errors path="address_id" cssStyle="font-size: smaller;color:red;"/>
                </td>
            </tr>
            <tr>
                <td style="border-right: 0;padding: 8px;">Статус </td>
                <td style="border-left: 0;padding: 8px;">
                <select name="status"  class="form-control" style="height: 30px;">
                <c:set var="stat_tmp" value="${clientBean.status}"/>
                                        <c:if test="${stat_tmp==0}" >
                                            <c:set var="status0" value="selected" />
                                        </c:if>
                                        <c:if test="${stat_tmp==1}" >
                                            <c:set var="status1" value="selected" />
                                        </c:if>
                                        <c:if test="${stat_tmp==2}" >
                                            <c:set var="status2" value="selected" />
                                        </c:if>
                        <option ${status0} value="0">Отключено </option>
                        <option ${status1} value="1">Активировано</option>
                        <option ${status2} value="2">Приостановлено</option>
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
            <tr>
                <td style="border-right: 0;padding: 8px;">Уровень доступа </td>
                <td style="border-left: 0;padding: 8px;">
                <select name="role"  class="form-control" style="height: 30px;">
                <c:set var="role_tmp" value="${clientBean.role}"/>
                                        <c:if test="${role_tmp=='user'}" >
                                            <c:set var="role0" value="selected" />
                                        </c:if>
                                        <c:if test="${role_tmp=='admin'}" >
                                            <c:set var="role1" value="selected" />
                                        </c:if>
                            <option ${role0} value="user"> Абонент</option>
                            <option ${role1} value="admin">Администратор</option>
                        </select>
                </td>
            </tr>
            <thead>
                <tr>
                    <td colspan="2" align="center" style="font-size: 30px;">
                        <sf:hidden path="address_id"  id="address_id" />
                        <input class="btn btn-lg  btn-primary btn-block " name="submit" type="submit" value="Изменить" />
                    </td>
                </tr>
                </thead>
        </table>
        </sf:form>
</div>

</body>
</html>
