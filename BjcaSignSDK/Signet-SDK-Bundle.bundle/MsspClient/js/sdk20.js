//验证输入框
var panduanArray = new Array(false, false, false);

var isName = false;
var isIDCard = false;
var isIDDate = false;

var ischange = false;
var selectText = false;

function checkIpt(val){
    var reg =  /^[0-9a-zA-Z]+$/
    if (!reg.test(val)) {
        return false;
    }
}

//验证码
function sdkPanduanCode(n, lengths) {
	if(((String($(".sdk_input"+n).val()).indexOf(" ")!=-1))||((String($(".sdk_input"+n).val()).indexOf("　")!=-1))){
		$(".sdk_ted s"+n).hide();
		$(".zm_sdk_ts"+n).hide();
		$(".kg_sdk_ts"+n).show();
	}else{
		$(".kg_sdk_ts"+n).hide();
		if(($(".sdk_input" + n).val().length == lengths) && (!isNaN($(".sdk_input" + n).val()))) {
			$(".sdk_ts" + n).hide();
			$(".zm_sdk_ts" + n).hide();
			panduanArray[n] = true;
		} else if($(".sdk_input" + n).val().length == 0) {
			$(".sdk_ts" + n).hide();
			$(".zm_sdk_ts" + n).hide();
			panduanArray[n] = false;
		} else {
			if(isNaN($(".sdk_input" + n).val())) {
				$(".zm_sdk_ts" + n).show();
				$(".sdk_ts" + n).hide();
			} else {
				$(".sdk_ts" + n).show();
				$(".zm_sdk_ts" + n).hide();
			}
			panduanArray[n] = false;
		}

		if(n == 3) {
			if(panduanArray[n]) {
				$(".btn-primary").attr("disabled", false);
			} else {
				$(".btn-primary").attr("disabled", true);
			}
		} else if(n == 4) {
			if(panduanArray[n] && (String($(".sdk_input" + n).val()).charAt(0) == 1)) {
				$(".btn-primary").attr("disabled", false);
			} else {
				$(".btn-primary").attr("disabled", true);
			}
		} else {
			if(panduanArray[0] && panduanArray[1] && panduanArray[2]) {
				$(".btn-primary").attr("disabled", false);
			} else {
				$(".btn-primary").attr("disabled", true);
			}
		}
	}
}

//口令
function sdkPanduan(n, lengths) {
	if(((String($(".sdk_input"+n).val()).indexOf(" ")!=-1))||((String($(".sdk_input"+n).val()).indexOf("　")!=-1))){
		$(".sdk_ts"+n).hide();
		$(".zm_sdk_ts"+n).hide();
		$(".kg_sdk_ts"+n).show();
	}else{
		$(".kg_sdk_ts"+n).hide();	
		if(String($(".sdk_input" + n).val()).length > (lengths-1) && checkIpt($(".sdk_input" + n).val()) != false) {
			$(".sdk_ts" + n).hide();
			$(".zm_sdk_ts" + n).hide();
			panduanArray[n] = true;
		} else if(String($(".sdk_input" + n).val()).length < lengths){
		    $(".sdk_ts" + n).show();
            $(".zm_sdk_ts" + n).hide();
            panduanArray[n] = false;
		}else if($(".sdk_input" + n).val().length > (lengths-1) && checkIpt($(".sdk_input" + n).val()) == false){
            $(".sdk_ts" + n).hide();
            $(".zm_sdk_ts" + n).show();
            panduanArray[n] = false;
        }else if($(".sdk_input" + n).val().length == 0) {
			$(".sdk_ts" + n).hide();
			$(".zm_sdk_ts" + n).hide();
			panduanArray[n] = false;
		} else {
			if(checkIpt($(".sdk_input" + n).val()) == false) {
				$(".zm_sdk_ts" + n).show();
				$(".sdk_ts" + n).hide();
			} else {
				$(".sdk_ts" + n).show();
				$(".zm_sdk_ts" + n).hide();
			}
			panduanArray[n] = false;
		}
	
		if(n == 3) {
			if(panduanArray[n]) {
				$(".btn-primary").attr("disabled", false);
			} else {
				$(".btn-primary").attr("disabled", true);
			}
		} else if(n == 4) {
			if(panduanArray[n] && (String($(".sdk_input" + n).val()).charAt(0) == 1)) {
				$(".btn-primary").attr("disabled", false);
			} else {
				$(".btn-primary").attr("disabled", true);
			}
		} else {
			if(panduanArray[0] && panduanArray[1] && panduanArray[2]) {
				$(".btn-primary").attr("disabled", false);
			} else {
				$(".btn-primary").attr("disabled", true);
			}
		}
	}
}

//获取验证码
var sdk_time_num = 59;
var sdk_time_interval;

function sdkTimeFun() {
	$("#sdk_time").unbind();
	$("#sdk_time").html(sdk_time_num-- + " 秒");
	sdk_time_interval = setInterval(function() {
		if(sdk_time_num > 0) {
			$("#sdk_time").html(sdk_time_num-- + " 秒");
		} else {
			clearInterval(sdk_time_interval);
			$("#sdk_time").html("获取验证码");
			sdk_time_num = 59;
			$("#sdk_time").bind("click", function() {
				active_sendmsg()
			});
		}
	}, 1000);
}

//olduser姓名和身份证验证
var olderUserNameToolean = new Array();
var olderIdCardToolean = false;

function sdkOlduserPuanduan(n) {
	if($(".sdk_input" + n).val().length >= 2) {
		$(".sdk_ts" + n).hide();
		olderUserNameToolean[n] = true;
		isName = true;
	} else if($(".sdk_input" + n).val().length == 0) {
		$(".sdk_ts" + n).hide();
		olderUserNameToolean[n] = false;
		isName = false;
	} else {
		$(".sdk_ts" + n).show();
		olderUserNameToolean[n] = false;
		isName = false;
	}
	if($(".sdk_input6").length == 0) {
		olderUserNameToolean[6] = true;
	}
	if(olderUserNameToolean[5] && olderUserNameToolean[6] && (olderIdCardToolean && isName && isIDCard && isIDDate)) {
		$(".btn-primary").attr("disabled", false);
	} else {
		$(".btn-primary").attr("disabled", true);
	}
}

function isIdCardNo(num) {
	if(typeof(num) == undefined)
		return false;
	if(num == null)
		return false;
	var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
	var error;
	var varArray = new Array();
	var intValue;
	var lngProduct = 0;
	var intCheckDigit;
	var intStrLen = num.length;
	var idNumber = num;
	// initialize
	if(intStrLen != 18) {

		return false;
	}
	// check and set value
	for(i = 0; i < intStrLen; i++) {
		varArray[i] = idNumber.charAt(i);
		if((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {

			return false;
		} else if(i < 17) {
			varArray[i] = varArray[i] * factorArr[i];
		}
	}
	if(intStrLen == 18) {
		//check date
		var date8 = idNumber.substring(6, 14);
		if(checkDate(date8) == false) {

			return false;
		}
		// calculate the sum of the products
		for(i = 0; i < 17; i++) {
			lngProduct = lngProduct + varArray[i];
		}
		// calculate the check digit
		intCheckDigit = 12 - lngProduct % 11;
		switch(intCheckDigit) {
			case 10:
				intCheckDigit = 'X';
				break;
			case 11:
				intCheckDigit = 0;
				break;
			case 12:
				intCheckDigit = 1;
				break;
		}
		// check last digit
		if(varArray[17].toUpperCase() != intCheckDigit) {

			return false;
		}
	} else { //length is 15
		//check date
		var date6 = idNumber.substring(6, 12);
		if(checkDate(date6) == false) {

			return false;
		}
	}
	return true;
}

function checkDate(date) {
	return true;
}

function checkIdCard() {
	var cardnumber = $(".idcardinput").val();
	var idcardboolen = isIdCardNo(cardnumber);
	if(idcardboolen) {
		$(".sdk_ts_idcard").hide();
		olderIdCardToolean = true;
		isIDCard = true;
	} else {
		$(".sdk_ts_idcard").show();
		olderIdCardToolean = false;
		isIDCard = false;
	}
	//	if($(".sdk_input6").length==0){
	//		olderUserNameToolean[6]=true;
	//	}
	if(isName && isIDCard && isIDDate) {
		$(".btn-primary").attr("disabled", false);
		return true;
	} else {
		$(".btn-primary").attr("disabled", true);
		return false;
	}
}

function checkIDCradDate() {
	var date = document.getElementById("revise_val");

	var a = /^(\d{4}).(\d{2}).(\d{2})-(\d{4}).(\d{2}).(\d{2})$/
	var longtimes=false;
	if(String(date.value).indexOf("长期")!=-1){
		console.log("长期");
		if(date.value.length == 13){			
			longtimes=true;
		}
	}
	
	var idcardDateboolen = a.test(date.value);

	if(idcardDateboolen||longtimes) {
		$(".sdk_date_idcard").hide();
		isIDDate = true;
	} else {
		$(".sdk_date_idcard").show();
		isIDDate = false;
	}

	if(isName && isIDCard && isIDDate) {
		$(".btn-primary").attr("disabled", false);
	} else {
		$(".btn-primary").attr("disabled", true);
	}

	return idcardDateboolen;

}





function sdkOlduserPuanduan_olduer(n){
	if($(".sdk_input"+n).val().length>=2){
		$(".sdk_ts"+n).hide();
		olderUserNameToolean[n]=true;
		isName = true;
	}else if($(".sdk_input"+n).val().length==0){
		$(".sdk_ts"+n).hide();
		olderUserNameToolean[n]=false;
		isName = false;
	}else{
		$(".sdk_ts"+n).show();
		olderUserNameToolean[n]=false;
		isName = false;
	}
	if($(".sdk_input6").length==0){
		olderUserNameToolean[6]=true;
	}
	if(olderUserNameToolean[5]&&olderUserNameToolean[6]&&(olderIdCardToolean && isName && isIDCard )){
		$(".btn-primary").attr("disabled",false);
	}else{
		$(".btn-primary").attr("disabled",true);
	}
}

function checkIdCard_oldueren(){
	var cardnumber=$(".idcardinput").val();
	var idcardboolen = false;
	
	$('.idcardinput').blur(function () {
		if($(".idcardinput").val() == ""){
			$(".sdk_ts_idcard").hide();
		}
	});
	
	idcardboolen=isIdCardNo(cardnumber);
	
	if(idcardboolen){
		$(".sdk_ts_idcard").hide();
		olderIdCardToolean=true;
		isIDCard = true;
	}else{
		$(".sdk_ts_idcard").show();
		olderIdCardToolean=false;
		isIDCard = false;
	}
	if(isName && isIDCard && olderUserNameToolean[6]){
		$(".btn-primary").attr("disabled",false);
		return true;
	}else{
		$(".btn-primary").attr("disabled",true);
		return false;
	}
	
	
}

var neir = "";
function checkIdCard_olduer(){
	var cardnumber=$(".idcardinput").val();
	var idcardboolen = false;
	
	$('.idcardinput').blur(function () {
		if($(".idcardinput").val() == ""){
			$(".sdk_ts_idcard").hide();
		}
	});
	
	neir = $("#selectView option:selected").val();
	
	if(neir == "SF"){
		idcardboolen=isIdCardNo(cardnumber);
		
		if(idcardboolen){
			$(".sdk_ts_idcard").hide();
			olderIdCardToolean=true;
			isIDCard = true;
		}else{
			$(".sdk_ts_idcard").show();
			olderIdCardToolean=false;
			isIDCard = false;
		}
		if(isName && isIDCard){
			$(".btn-primary").attr("disabled",false);
			return true;
		}else{
			$(".btn-primary").attr("disabled",true);
			return false;
		}
	}else{

		if(cardnumber != "" && cardnumber != null){
		    isIDCard = true;
		    olderIdCardToolean=true;
		    if(isName){
		        $(".btn-primary").attr("disabled",false);
            	return true;
		    }

		}else{
			$(".btn-primary").attr("disabled",true);
			return false;
		}
	}
	
	
	
}

function onSelectType(){
    $(".sdk_ts_idcard").hide();
	var neir_tmp = $("#selectView option:selected").val();
	
	if(neir_tmp != neir){
		$(".idcardinput").val("");
		isIDCard = false;
        olderIdCardToolean=false;
        $(".btn-primary").attr("disabled",true);
	}
}








$(function() {
	sdkTimeFun();
});
