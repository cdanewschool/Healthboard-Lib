import ASclasses.Constants;

import mx.controls.Alert;
import mx.events.ValidationResultEvent;

private function clearValidationErrorsLogin():void {
	userID.text = '';
	password.text = '';
	usernameValidator.validate('james');
	passwordValidator.validate('archer');
	hgLoginFail.visible = hgLoginFail.includeInLayout = false;
}

private var vResult:ValidationResultEvent;
private function forgotPasswordHandler():void {
	vResult = forgotPasswordEmailValidator.validate();
	if(vResult.type == ValidationResultEvent.VALID) {
		this.currentState = 'passwordSent';
	}
	else {
		Alert.show("Please enter a valid e-mail address");
	}
}

//next 2 variables originally in Nutrition.as 
private var today:Date = new Date();


//originally in vitalSigns.as
public function getDate(date:String):String {
	if(date.charAt(1) == '/') date = '0' + date;									// 3/4/2012
	if(date.charAt(4) == '/') date = date.substr(0,3) + '0' + date.substr(-6);		// 03/4/2012
	return Constants.MONTHS[uint(date.substr(0,2))-1] + ' ' + uint(date.substr(3,2)) + ', ' + date.substr(-4);
}

//originally in medications.as
public function unique(array:Array):Array {
	var arrayL:uint = array.length;
	if (!arrayL) return [];
	var newArray:Array = [array[0]];
	for (var i:uint = 1; i < arrayL; i++) {
		var item:* = array[i];
		if (array.lastIndexOf(item, i - 1) == -1) {
			newArray.push(item);
		}
	}
	return newArray;
}
