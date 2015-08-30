<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>SIMPLE PROVIDER</title>
<script type="text/javascript" src="js/scripts.js"></script>
<style>
   <%@include file='css/style.css' %>
</style>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
</head>

<body>
<div>
<h1 align="center">SIMPLE PROVIDER</h1>
</div>

<form method="post" action="login" style="width: 232px; height: 98px"  onsubmit="return loginValid('login','pass')">

<table  >
     <tr>
        <td style="border-right: 0px;text-align: left; " ><b>Договор&nbsp;№</b></td>
        <td style="border-left: 0px;"><input  type="text" id="login" name="id" size="20" onclick="Color_input(this)"></td>
    </tr>
 
    <tr>
        <td style="border-right: 0px;text-align: left; " ><b>Пароль</b></td>
        <td style="border-left: 0px;"><input  type="password" id="pass" name="password"  style="width: 100%;" onclick="Color_input(this)"></td>
    </tr>        
    <tr>
        <td colspan = "2" align="center">
        	<input   type="submit" value="Login" style="width: 90px; " >
  			<input   type="reset" value="Reset" style="width: 90px; "></td>
    </tr>
    </table>
<label style="text-align: left;font-size: x-small; color: red;"> ${info}</label>



</form>
<fieldset  style="width: 50%">
    <legend>actions</legend>
<a  href="/allclient"  >all client</a> <br>
<a  href="/client/1"  >client #1</a> <br>
<a  href="/client/add"  >add newclient </a> <br>
</fieldset>
${info}


</body>
</html>
