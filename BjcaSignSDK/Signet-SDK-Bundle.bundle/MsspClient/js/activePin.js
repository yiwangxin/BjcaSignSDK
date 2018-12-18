/*************************************************************************************************
 * <pre>
 * @包路径：
 * @版权所有： 北京数字医信科技有限公司 (C) 2018
 *
 * @类描述:
 * @版本:       V3.0.0
 * @作者        daizhenhong
 * @创建时间    2018/9/12 下午4:32
 *
 * @修改记录：
 -----------------------------------------------------------------------------------------------
 ----------- 时间      |   修改人    |     修改的方法       |         修改描述   ---------------
 -----------------------------------------------------------------------------------------------
 </pre>
 ************************************************************************************************/
var regCode = /[0-9a-z]{6}/;
var regPin = /[0-9]{6}/;
var submitCondition={
    code:false,
    pin:false,
    pinSure:false
}

function verifyActiveCode() {
    var code = document.getElementById("idCode").value
    submitCondition.code = regCode.test(code)
    if (submitCondition.code) {
        $('.active_code_number').hide()
    } else {
        $('.active_code_number').show()
    }
    checkEnableSubmit()
    return submitCondition.code

}

function verifyPin() {
    var pin = document.getElementById("idUserPin").value
    submitCondition.pin = regCode.test(pin)
    if (submitCondition.pin) {
        $('.user_pin_number').hide()
    } else {
        $('.user_pin_number').show()
    }
    checkEnableSubmit()
    return submitCondition.pin
}

function verifyPinSure() {
    submitCondition.pinSure = regCode.test(document.getElementById("idUserPinSure").value)
    if (submitCondition.pinSure) {
        $('.user_pin_sure_number').hide()
    } else {
        $('.user_pin_sure_number').show()
    }
    checkEnableSubmit()
    return submitCondition.pinSure
}

function checkEnableSubmit() {
    if (submitCondition.code && submitCondition.pin && submitCondition.pinSure) {
        $(".btn_submit").attr("disabled", false).css("opacity", "1");
    } else {
        $(".btn_submit").attr("disabled", true).css("opacity", "0.3");
    }
}

function active() {

    var otpCode = document.getElementById("idCode").value;
    if (otpCode.length != 6) {
        request('signet', 'alertWarnig', '请输入六位短信验证码');
        return;
    }
    var pin1 = "";
    var pin2 = "";
    if (document.getElementById("idUserPin") && document.getElementById("idUserPinSure")) {
        pin1 = document.getElementById("idUserPin").value;
        pin2 = document.getElementById("idUserPinSure").value;

        if (!regPin.test(pin1) || !regPin.test(pin2)) {
            request('signet', 'alertWarnig', '请输入6位数字口令');
            return;
        }
        if (pin1 != pin2) {
            request('signet', 'alertWarnig', '口令输入不一致');
            return;
        }
    }
    var paramObj = new Object();
    paramObj.otp = otpCode;
    paramObj.pinOne = pin1;
    paramObj.pinTwo = pin2;

    request('signet', 'activeUser', JSON.stringify(paramObj));

}


function checkPin(pin) {
    return regPin.test(pin)
}

function checkCode(code) {

}