function dataCheckValid(target){
	return true;
}
function elemVisibility(name){
	var elem = document.getElementById(name);
	
	if (elem.style.visibility=="visible"){
		elem.style.visibility="collapse";
	}else{
		elem.style.visibility="visible";
	}
		
}

function Clear_input(target){
    target.value="";
}

function Color_input(target){
    //target.value="";
	target.style.backgroundColor="white";
	target.style.borderColor="white";
}
function Border_col_reset(target){
    target.style.backgroundColor="white";
    target.style.borderColor="white";
}

function loginValid(id,pass){
	var str = document.getElementById(pass).value; 
	var element = document.getElementById(pass);
	if (!isEmptyFault(id)){
		 return false;
	}
	
	if (str.length==0){
		 alert("Введите пароль!");
		 element.style.backgroundColor="red";
		 return false;
	}
	return true;
	
}

function isEmptyFault(targetInput){
		 var str = document.getElementById(targetInput).value; 
		 var element = document.getElementById(targetInput);
		 if (str.length==0){
			 alert("Не корректный ввод! Введите число!");
			 element.style.borderColor="red";
			 //element.style.backgroundColor="red";
			 return false;
		 }
		 if (str.indexOf(' ')>=0){
			 alert("Не корректный ввод! Введите число!");
             element.style.borderColor="red";
			 //element.style.backgroundColor="red";
			 return false;
		 }
		 if (str.indexOf('.')>=0){
			 alert("Не корректный ввод! Введите число!");
			 //element.style.backgroundColor="red";
             element.style.borderColor="red";
			 return false;
		 }
		 
		 if (isNaN(str)){
			 alert("Не корректный ввод! Введите число!");
			 //element.style.backgroundColor="red";
             element.style.borderColor="red";
			 return false;
		 }
		 return true;

}

function isNumber(){
    //var str= targetInput.value;
    var account = document.getElementById("account");
    var account_val = account.value;
    var room = document.getElementById("room");
    var room_val = room.value;
    //var address_id = document.getElementById("address_id");
    //var address_id_val = address_id.value;
    var datepicker = document.getElementById("datepicker");
    var datepicker_val = datepicker.value;
    var cl_id = document.getElementById("cl_id");
    var cl_id_val = cl_id.value;
    var err_count=0;

    if (isNaN(cl_id_val) || cl_id_val.indexOf('.')>=0 || cl_id_val.indexOf(' ')>=0 || cl_id_val.indexOf('-')>=0 || cl_id_val.indexOf('+')>=0){
        cl_id.style.borderColor="red";
        cl_id.value="Введите число!";
            err_count=1;
        } else {
            account.style.borderColor="white";
         }
    if (isNaN(account_val) || account_val.indexOf('.')>=0 || account_val.indexOf(' ')>=0 ){
            account.style.borderColor="red";
            account.value="Введите число!";
            err_count=1;
        } else {
            account.style.borderColor="white";
         }
     if (isNaN(room_val) || room_val.indexOf('.')>=0 || room_val.indexOf(' ')>=0 ){
         room.style.borderColor="red";
         room.value="Введите число!";
            err_count=1;
        }else {
         room.style.borderColor="white";
     }
    // if (isNaN(address_id_val) || address_id_val.indexOf('.')>=0 || address_id_val.indexOf(' ')>=0 ){
    //    address_id.style.borderColor="red";
    //    address_id.value="Введите число!";
    //    err_count=1;
    //}else {
    //    address_id.style.borderColor="white";
    //}

    if (!(datepicker_val.match(/^(\d{4})[-\/](\d{2})[-\/](\d{2})$/))){
        datepicker.style.borderColor="red";
        datepicker.value="Введите дату!";
        err_count=1;
    }else{
        datepicker.style.borderColor="white";
    }
    if (err_count===1){
        return false;
    }else if (err_count===0) {
        return true;
    }
}

	   
