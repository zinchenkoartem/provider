function passValid()
{
var minlength=3;
var PASS1count=document.add_form.password.value.length;
var PASS1=document.add_form.password.value;
var PASS2=document.add_form.password2.value;
if(PASS1==PASS2)
{alert("пароли равны")
document.getElementById("span").innerHTML="pass1 = pass2";
}
if(PASS1count<minlength) {
document.getElementById("span").innerHTML="Min length 6 chars";
document.newuserform.submit.disabled=true;
}
else
{
document.getElementById("span").innerHTML="Pass OK";
document.newuserform.submit.disabled=false;
}
}
function button() {
// alert(document.newuserform.login.value);
alert("sdfsdfsdf");
}