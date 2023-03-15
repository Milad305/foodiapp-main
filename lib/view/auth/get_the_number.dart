import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/auth/terms-and-conditions.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'get_sms.dart';

class GetTheNumber extends GetView<AuthGetter> {
  GetTheNumber({Key? key}) : super(key: key) {
    Get.lazyPut(() => AuthGetter());
  }
  TextEditingController inputPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height*.15,),
              Image.asset(
                "assets/images/signup.png",
                width: Get.width * 0.5,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Align(alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right :Get.width*.18),
                  child: Text(
                    "شماره همراه",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01, 
              ),
              Container(
                height: Get.height*.07,
              
                margin:  EdgeInsets.only(left: Get.width*.15, right: Get.width*.15),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                    color: Constants.textFieldBg,
                    borderRadius: BorderRadius.circular(1000),
                 ),
                child: Padding(
                  padding:   EdgeInsets.only(top:Get.height*.024),
                  child: TextFormField( 
                    textAlignVertical:TextAlignVertical.center ,
                    controller: inputPhone,
                    decoration: InputDecoration(
                      
                      hintText: "5112 *** 912".toPersianDigit(),
                      hintStyle: TextStyle(
                        color: Constants.textColor.withOpacity(0.4),
                        fontFamily: Constants.primaryFontFamilyAdad,
                        fontSize: 20.sp,
                      ),
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontFamily: Constants.primaryFontFamilyAdad,
                      fontSize: 20.sp,
                      color: Colors.black87,
                    ),
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    cursorColor: Colors.black87,
                    textAlign: TextAlign.left,
                    maxLength: 10,
                    textDirection: TextDirection.ltr,
                    onFieldSubmitted: (val) async {
                      if (controller.phone.value.length > 9) {
                        final signcode = await SmsAutoFill().getAppSignature;
                        Get.to(() => GetSms(
                              phone: controller.phone.value,
                              signcode: signcode,
                            ));
                      }
                    },
                    onChanged: (val) {
                      if (val.length == 1 && val == "0") {
                        inputPhone.clear();
                      } else {
                        controller.phone(val);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Obx(() => Container(
                width: Get.width*.3,
                height: Get.height*.05,
                    decoration: BoxDecoration(
                        gradient:LinearGradient(colors: controller.phone.value.length > 9
                            ? Constants.primarygradiant
                            : Constants.disablegradiant,begin: Alignment.topCenter,end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(1000)),
                   
                    child: InkWell(
                      onTap: controller.phone.value.length > 9
                          ? () async {
                              var signCode = "";
                              try {
                                signCode = await SmsAutoFill().getAppSignature;
                              } catch (e) {
                                signCode = "salamatiman.ir";
                              }
                              Get.to(() => GetSms(
                                    phone: controller.phone.value,
                                    signcode: signCode,
                                  ));
                            }
                          : null,
                      child: const Align(
                        child: Text(
                          "ثبت نام ",
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.center,
                      ),
                      radius: 50,
                      splashColor: Constants.primaryColor2,
                    ),
                  )),
              SizedBox(height: Get.height*.23),
              Text.rich(
                TextSpan(text: "با زدن دکمه ثبت با ", children: [
                  TextSpan(
                      text: " قوانین",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => TermsAndConditions()),
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      )),
                  const TextSpan(text: " "),
                  const TextSpan(text: "موافقت میکنم"),
                ]),
                style: TextStyle(fontSize: 16.5.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
