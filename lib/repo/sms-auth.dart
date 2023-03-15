import 'package:salamatiman/utils/constants.dart';

abstract class SmsAuth {
  //send sms for login
  static login(
      {required phone,
      required signcode,
      required smsCode,
      required personName}) {
    var smsBody = {
      "mobile": phone,
      "templateId": Constants.smsLoginThemeId,
      "parameters": [
        {"name": "USER", "value": personName},
        {"name": "PHONECODE", "value": signcode},
        {"name": "CODE", "value": smsCode}
      ]
    };
  }

  //send sms For register
  static register({required phone, required signcode, required smsCode}) {
    var smsBody = {
      "mobile": phone,
      "templateId": Constants.smsRegisterThemeId,
      "parameters": [
        {"name": "PHONECODE", "value": signcode},
        {"name": "CODE", "value": smsCode}
      ]
    };
  }
}
