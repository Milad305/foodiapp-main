import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/main/app_main.dart';

import 'target-weight.dart';

class WeightStabilization extends GetView<PersonTargetGeter> {
  WeightStabilization({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.targetWeightType(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = GetStorage().read('UserInfo');
    var gender = "male";
    var weight = controller.weight.value;
    var height = userInfo["height"];
    var wrist = userInfo["wrist"] == null ? 20 : userInfo["wrist"];
    var age = userInfo["age"];

    var height_m = height / 100;
    var skl = height / wrist;
    var sklR;
    var normal_weight;
    var bmi = (weight / (height_m * height_m)).round();

    if (skl > 10.5) {
      sklR = 'slim';
    } else if (skl < 9.5) {
      sklR = 'fat';
    } else {
      sklR = 'normal';
    }

    if (gender == 'male') {
      if (age >= 16 && age < 31) {
        normal_weight = height_m * height_m * 23.3;
      } else if (age >= 31 && age < 45) {
        normal_weight = height_m * height_m * 24.8;
      } else if (age >= 45) {
        normal_weight = height_m * height_m * 25.4;
      }
    } else {
      if (age >= 16 && age < 31) {
        normal_weight = height_m * height_m * 20.8;
      } else if (age >= 31 && age < 40) {
        normal_weight = height_m * height_m * 22.5;
      } else if (age >= 40 && age < 45) {
        normal_weight = height_m * height_m * 24.1;
      } else if (age >= 45) {
        normal_weight = height_m * height_m * 25;
      }
    }

    if ((10 <= age) && (age <= 11) && (height_m < 1.65)) {
      normal_weight = (height_m * height_m) * (age + 8);
    } else if ((12 <= age) && (age <= 15) && (height_m <= 1.65)) {
      normal_weight = (height_m * height_m) * (age + 5);
    } else if ((10 <= age) && (age <= 15) && (height_m >= 1.65)) {
      if (gender == 'male') {
        normal_weight = (height_m * height_m) * 23.3;
      } else {
        normal_weight = (height_m * height_m) * 20.8;
      }
    }
    if (sklR == 'slim') {
      normal_weight *= 0.94;
    } else if (sklR == 'fat') {
      normal_weight *= 1.06;
    }

    normal_weight = (normal_weight).round();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width * 0.9,
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SafeArea(
                child: Container(
                  height: 300,
                  child: Image.asset("assets/images/target/bmi-balance.png",
                      fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text.rich(TextSpan(
                  text: Constants.userInfo["name"],
                  style: TextStyle(fontSize: 17.sp),
                  children: [
                    TextSpan(text: " "),
                    TextSpan(text: "عزیز"),
                    TextSpan(text: " "),
                    TextSpan(text: "شاخص توده بدنی شما"),
                    TextSpan(text: " "),
                    TextSpan(
                        text: Constants.getBMI(bmi).toString(),
                        style: TextStyle(
                            color: Constants.primaryColor2, fontSize: 19.sp)),
                    TextSpan(text: " می باشد "),
                    TextSpan(text: "و برار با "),
                    TextSpan(
                        text: bmi.toString().toPersianDigit(),
                        style: TextStyle(
                            color: Constants.primaryColor2, fontSize: 19.sp)),
                    TextSpan(text: " "),
                    TextSpan(text: "هستش"),
                    TextSpan(text: " و "),
                    TextSpan(text: "وزن ایده آل شما "),
                    TextSpan(
                        text: normal_weight.toString().toPersianDigit(),
                        style: TextStyle(
                            color: Constants.primaryColor2, fontSize: 19.sp)),
                    TextSpan(text: " کیلو گرم می باشد "),
                  ])),
              if (bmi > 24 || bmi < 18.5) ...[
                SizedBox(
                  height: 50,
                ),
              ],
              if (bmi > 24 || bmi < 18.5) ...[
                Container(
                  width: double.infinity,
                  child: Text.rich(
                    TextSpan(
                        text: "به شما توصیه میشه",
                        style: TextStyle(fontSize: 17.sp),
                        children: [
                          TextSpan(text: " "),
                          TextSpan(
                              text: bmi > 24
                                  ? "از وزنت کم کنی"
                                  : " به وزنت اضافه کنی",
                              style: TextStyle(color: Constants.successColor)),
                        ]),
                  ),
                ),
              ],

              if (bmi > 24 || bmi < 18.5) ...[
                SizedBox(
                  height: 70,
                ),
              ],

              if (bmi > 24 || bmi < 18.5) ...[
                Center(
                  child: SizedBox(
                    width: Get.width * .50,
                    height: 50,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 8,
                          lightSource: LightSource.topLeft,
                          color: Colors.grey.shade400),
                      child: SuccessButton(
                        onPressed: () {
                          Get.to(() => InputUserTargetWeight());
                        },
                        title: bmi > 24
                            ? "میخوام از وزنم کم کنم"
                            : "میخوام به وزنم اضافه کنم",
                      ),
                    ),
                  ),
                ),
              ],

              SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Text("بستن"),
                onTap: () {
                  controller.targetWeightType(0);
                  Get.off(() => AppMain());
                },
              )

              // Text("${normal_weight}"),
              // Text("${bmi}"),
              // Text("${gender}"),
              // Text("${Constants.getBMI(bmi)}"),
            ],
          ),
        ),
      ),
    );
  }
}
