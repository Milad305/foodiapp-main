import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/auth.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/main/app_main.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'register_page.dart';

class GetSms extends GetView<AuthGetter> {
  final phone, signcode;
  GetSms({Key? key, required this.phone, required this.signcode})
      : super(key: key) {
    sendSms(phone: phone, signcode: signcode);
    controller.timerCancel();
    controller.timer(60);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      if (controller.time.value == 0) {
        return Future.value(true);
      }
      Fluttertoast.showToast(
          msg:
              "بعد از ${controller.time.value} ثانیه دیگه میتونی شماره رو تغییر بدی");
      return Future.value(false);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () => onWillPop(),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/getsms.png"),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: Get.width * .18, bottom: 5),
                      child: Text(
                        "کد ارسالی",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.textFieldBg),
                    height: Get.height / 17,
                    width: (Get.width * 0.7).sp,
                    child: Center(
                      child: SizedBox(
                        height: Get.height / 5,
                        width: (Get.width * 0.5).sp,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: PinFieldAutoFill(
                              keyboardType: TextInputType.number,
                              onCodeChanged: (val) {
                                controller.verifayCode.value = val.toString();
                                // ignore: curly_braces_in_flow_control_structures
                                if (val != "") if (val!.length > 3) {
                                  return verificationCode(val);
                                }
                              },
                              onCodeSubmitted: (val) {
                                controller.verifayCode.value = val.toString();
                                if (val != "") if (val.length > 3) {
                                  return verificationCode(val);
                                }
                              },
                              autoFocus: false,
                              decoration: UnderlineDecoration(
                                  colorBuilder: FixedColorBuilder(
                                      Color.fromARGB(255, 45, 211, 194)),
                                  lineHeight: 1.5,
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                              codeLength: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 
                        Wrap(
                    children: [
                    
                      Align(alignment: Alignment.centerRight,
                        child: Padding(
                          padding:  EdgeInsets.only(right: Get.width * .18, top: 25),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.time == 0) {
                                Get.back();
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "به از ${controller.time} ثانیه دیگه میتونی شماره رو تغییر بدی");
                              }
                            },
                            child: Text(
                              "تغییر شماره ",
                              style: TextStyle(color: Color.fromARGB(255, 45, 211, 194)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Obx(() => controller.time.value > 0
                      ? Text(controller.time.value.toString().toPersianDigit() +
                          " ثانیه دیگه میتونی شماره رو تغییر بدی ")
                      : const Text("")),
                        SizedBox(
                    height: Get.height * 0.07,
                  ),
                  Obx(() => Container(
                        width: Get.width * .3,
                        height: Get.height * .05,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: controller.verifayCode.value.length > 3
                                    ? Constants.primarygradiant
                                    : Constants.disablegradiant,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(1000)),
                        child: InkWell(
                          onTap: controller.verifayCode.value.length > 3
                              ? () {
                                  verificationCode(
                                      controller.verifayCode.value);
                                }
                              : null,
                          child: const Align(
                            child: Text(
                              "ثبت و ادامه",
                              style: TextStyle(color: Colors.white),
                            ),
                            alignment: Alignment.center,
                          ),
                          radius: 50,
                          splashColor: Constants.primaryColor2,
                        ),
                      )),
                
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendSms({required phone, required signcode}) async {
    final res = await AuthUser.sendVerificationSms(false,
        phone: "0" + phone.toString(), autofillCode: signcode.toString());

    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      if (json["exists"] == 0) {
        Constants.storage.write('isNowUser', 0);
      } else {
        Constants.storage.write('isNowUser', 1);
      }
    } else if (res is Failure) {
      Get.snackbar("خطا", "خطا در ارسال کد فعال سازی");
      sendSms(phone: phone, signcode: signcode);
    }
  }

  verificationCode(myCode) async {
    var res = await AuthUser.checkVerificationCode(true,
        phone: "0" + phone.toString(), code: myCode.toString());

    if (res is Success) {
      var user = Constants.storage.read('isNowUser');
      if (user == 0) {
        Constants.storage.write('UserToken', "");
        Constants.storage.write('UserInfo', "");
        Constants.storage.write('smsCode', "");
        Constants.storage.write('smsCode', myCode);
        return Get.to(() => AuthRegisterPage());
      } else {
        var json = jsonDecode(res.response.toString());
        Constants.token = json["token"];
        controller.token(json["token"]);
        Constants.storage.write('UserToken', json["token"]);
        Constants.storage.write('UserInfo', json);
        Constants.storage.write('smsCode', myCode);
        return Get.to(() => AppMain());
      }
    } else if (res is Failure) {
      Get.snackbar("خطا", "خطا در اعتبار سنجی کد");
      Constants.token = "";
      controller.token("");
      Constants.storage.write('UserToken', "");
      Constants.storage.write('UserInfo', "");
      Constants.storage.write('smsCode', "");
      // return Get.to(() => AuthMain());
    }
  }
}
