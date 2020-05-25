// JavaScript Document

var signImageBase64;

var idCardInfo_revise = new Object();

var isRevise;

var userAgent = navigator.userAgent.toLowerCase();

function request(sp ,invoke ,myJSONText)
  {
	// 1 android 2 ios
//	try {
//		window.signet.transmit(sp,invoke,myJSONText);
//	} catch(Excep) {
//		 window.location.href = "#/signet?" + invoke + ":?" + myJSONText;
//	}
    if (/iphone|ipad|ipod/.test(userAgent )) {
        window.location.href = "#/signet?" + invoke + ":?" + myJSONText;
    } else if (/android/.test(userAgent )) {
        window.signet.transmit(sp,invoke,myJSONText);
    }else{
        console.log('device is not mobile!!')
    }
}

function setUserMobile(mobile){
	var userMobile=mobile;
	console.log(userMobile);
	document.getElementById("sdkActivePhoneNumber").innerHTML=mobile.substring(0,3)+"****"+mobile.substring(7,11);
		
}

function revertScreenCallBack(signImg){
	
	console.log(signImg);
	signImageBase64=signImg;
}

function getSignImageFromPage(){
	
	return signImageBase64;
}

function signSettingBack(){
	
	request('signet','signSettingBack','');


}

function captureIdCardCallBack(idCardStr){
	
	 var idCardInfo=JSON.parse(idCardStr);
	  console.log("idCardInfo : "+idCardStr);
	  console.log("idCardInfo.name : "+idCardInfo.name);
	  document.getElementById("idcard_name").innerHTML=idCardInfo.name;
	  document.getElementById("idcard_numb").innerHTML=idCardInfo.cardNum;
	  document.getElementById("idcard_val").innerHTML=idCardInfo.period;
	  console.log("finish");
	  $(".btn-primary").attr("disabled", false);
}

/**
 * 
 * @param {Object} idCardStr ocr得到的身份证信息
 * @param {Object} isRevise true时则身份证信息可修改，false则身份证信息不可修改
 */
function captureIdCardCallBack(idCardStr,isRevise){
	this.isRevise = isRevise;
	var idCardInfo=JSON.parse(idCardStr);
	
	if(isRevise == "true"){
		document.getElementById("default").style.display = "none";
		document.getElementById("revise").style.display = "block";
		
		document.getElementById("error_back").style.display = "none";
		document.getElementById("message_error").style.display = "block";
		
		document.getElementById("revise_name").value=idCardInfo.name;
	  document.getElementById("revise_paperid").value=idCardInfo.cardNum;
	  document.getElementById("revise_val").value=idCardInfo.period;
	  
	  sdkOlduserPuanduan(5);
	  checkIdCard();
	  checkIDCradDate();
		
	}else if(isRevise == "false"){
		document.getElementById("default").style.display = "block";
		document.getElementById("revise").style.display = "none";
		
		document.getElementById("error_back").style.display = "block";
		document.getElementById("message_error").style.display = "none";
		
//		var idCardInfo=JSON.parse(idCardStr);
//	  console.log("idCardInfo : "+idCardStr);
//	  console.log("idCardInfo.name : "+idCardInfo.name);
	  document.getElementById("idcard_name").innerHTML=idCardInfo.name;
	  document.getElementById("idcard_numb").innerHTML=idCardInfo.cardNum;
	  document.getElementById("idcard_val").innerHTML=idCardInfo.period;
//	  console.log("finish");
	}
	$(".btn-primary").attr("disabled", false);
	 
}
var idTypeObjs;
/**
 * 获取证件类型
 * @param {Object} IDType
 */
//function getIDType(IDType) {
//        var sel= document.getElementById("selectView");
//
//    if(IDType == "" || IDType == 'undefined' || IDType == null){
//        sel.options.add(new Option("身份证","SF"));
//        idTypeObjs[0] = '{"type":"SF","description":"身份证"}';
//    }else{
//        var str = IDType.substring(15,IDType.length-2);
//        idTypeObjs = str.split("},");
//        for(var i=0;i<idTypeObjs.length-1;i++){
//            idTypeObjs[i] +="}"
//        }
//        for(var i=0;i<idTypeObjs.length;i++){
//            var idTypeObj=JSON.parse(idTypeObjs[i]);
//            sel.options.add(new Option(idTypeObj.description,idTypeObj.type));
//        }
//    }

function getIDType(IDType) {
//	var IDType = '{"idcardType":[{"type":"SF","description":"身份证"},{"type":"HZ","description":"护照"}]}';
	var sel= document.getElementById("selectView"); 
	
	if(IDType == "" || IDType == 'undefined' || IDType == null){
		sel.options.add(new Option("身份证","SF"));
		idTypeObjs[0] = '{"type":"SF","description":"身份证"}';
	}else{
		var str = IDType.substring(15,IDType.length-2);	
		idTypeObjs = str.split("},");
		for(var i=0;i<idTypeObjs.length-1;i++){
			idTypeObjs[i] +="}"
		}
		for(var i=0;i<idTypeObjs.length;i++){
			var idTypeObj=JSON.parse(idTypeObjs[i]);
			sel.options.add(new Option(idTypeObj.description,idTypeObj.type));
		}
	}
}

function onSubmitIDInfo(){
	if(isRevise == "true"){
		idCardInfo_revise.name = document.getElementById("revise_name").value;
		idCardInfo_revise.cardNum = document.getElementById("revise_paperid").value;
		idCardInfo_revise.period = document.getElementById("revise_val").value
		request('signet','onSubmitIDInfo',JSON.stringify(idCardInfo_revise));
	}else if(isRevise == "false"){
		request('signet','onSubmitIDInfo',"");
	}
	
}

function checkIpt(val){
    var reg =  /^[0-9a-zA-Z]+$/
    if (!reg.test(val)) {
        return false;
    }
}

function activeUser(){
	
	 var otpCode=document.getElementById("otp").value;
	 if(otpCode.length != 6){
		 request('signet','alertWarnig','请输入六位短信验证码');
		 return;
	 }
	 var pin1="";
	 var pin2="";
	 if(document.getElementById("userpin1")&&document.getElementById("userpin2")){
		 pin1=document.getElementById("userpin1").value;
		 pin2=document.getElementById("userpin2").value;
		 
		 if(pin1.length<6||pin2.length<6){
			 request('signet','alertWarnig','请输入6-12位数字口令');
			 return;
		 }
		 if(checkIpt(pin1)==false||checkIpt(pin2)==false){
			 request('signet','alertWarnig','请输入数字或字母口令');
			 return;
		 }
		 if(pin1!=pin2){
			 request('signet','alertWarnig','口令输入不一致');
			 return;
		 }
	 }
	 var paramObj=new Object();
	 paramObj.otp=otpCode;
	 paramObj.pinOne=pin1;
	 paramObj.pinTwo=pin2;
	 
	 request('signet','activeUser',JSON.stringify(paramObj));	
	
}

function oldUserCheck(){
	var selectType;
	var IDtype = document.getElementById("selectView").value;
	
	var paramObj=new Object();
	paramObj.name=document.getElementById("name").value;
	paramObj.type = IDtype;
	paramObj.idCardNumber=document.getElementById("paperid").value;
	request('signet','userActiveDevice',JSON.stringify(paramObj));
	
}

//企业用户出发:检测企业身份有效性
function enterpriseCheck(){	

	var paramObj=new Object();
	paramObj.ORG=document.getElementById("enterpriseorg").value;
	paramObj.name=document.getElementById("name").value;
	paramObj.idCard=document.getElementById("paperid").value;
	
	request('signet','enterpriseActiveDevice',JSON.stringify(paramObj));
	
}

/**
 * 取消按钮
 */
function signSettingBack(){
	request('signet','signSettingBack','');
}

/**
 * 信息有误？请重新拍摄
 */
function messgeErrorBack(){
	request('signet','messgeErrorBack','');
}

function inputNumber(){
	  request('signet','inputNumber',document.getElementById("phonenumber01").value);
}



function active_sendmsg(){
	request('signet','reactive','');
	sdkTimeFun();
}
