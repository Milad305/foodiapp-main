import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/auth.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/auth/register_step/around_the_wrist.dart';
import 'package:salamatiman/view/auth/register_step/help.dart';
import 'package:salamatiman/view/main/app_main.dart';
import 'package:salamatiman/widgets/datepicker/flutter_datepicker.dart';

import 'activity/activity-item.dart';
import 'activity/list-activity.dart';
import 'reqister_help/gender.dart';
import 'select_gender.dart';
import 'woman-child.dart';

abstract class AuthRegisterStep extends GetView<AuthGetter> {
  AuthRegisterStep() {
    //Get.lazyPut(() => AuthGetter());
  }
  static Widget name(controller) => Column(
        children: [
          Image.asset("assets/images/namelogin.png"),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: Get.width * .22, bottom: 8),
              child: Text(
                "نام و نام خانوادگی",
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
          Container(
            height: Get.height * .07,
            margin:
                EdgeInsets.only(left: Get.width * .15, right: Get.width * .15),
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Constants.textFieldBg,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: " حسین محمدی",
                hintStyle: TextStyle(
                  color: Constants.textColor.withOpacity(0.4),
                ),
                counterText: "",
                border: InputBorder.none,
              ),
              cursorColor: Colors.black87,
              textAlign: TextAlign.right,
              maxLength: 50,
              textDirection: TextDirection.rtl,
              initialValue:
                  controller.name.value != "" ? controller.name.value : "",
              onChanged: (val) {
                controller.name(val);
              },
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Container(
              width: Get.width * .3,
              height: Get.height * .05,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: controller.name.value.length > 3
                          ? Constants.primarygradiant
                          : Constants.disablegradiant,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(1000)),
              child: InkWell(
                onTap: controller.name.value.length > 2
                    ? () async {
                        controller.steep(2);
                      }
                    : null,
                child: Center(
                  child: Text(
                    "ادامـه",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              )),
        ],
      );

  static Widget age(controller) => Column(
        children: [
          Text(
            "لطفا در اینجا تاریخ تولدت رو انتخاب کن",
            style: TextStyle(
              fontSize: 17.sp,
            ),
          ),
          SizedBox(
            height: Get.height * 0.07,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: LinearDatePicker(
              isJalaali: true,
              showDay: true,
              showMonthName: true,
              columnWidth: Get.width * 0.21,
              selectedRowStyle:
                  TextStyle(fontSize: 18.sp, color: Constants.activeColor),
              unselectedRowStyle: TextStyle(fontSize: 16.sp),
              labelStyle:
                  TextStyle(color: Constants.textBtnColor, fontSize: 20.sp),
              dateChangeListener: (String selectedDate) {
                controller.ageDate(selectedDate);
                
              },
              
            ),
          ),
          SizedBox(
            height: Get.height * 0.08,
          ),
          Container(
            child: SizedBox(
              width: Get.width * 0.55,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ElevatedButton(
                  child: Text(
                    "ادامـه",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  onPressed: () {
                    controller.steep(3);
                  },
                ),
              ),
            ),
          ),
        ],
      );

  static Widget gender(controller, context, double? customHeight) {
    late ScrollController scrollController;
    int initialItem = 55;


    scrollController = FixedExtentScrollController(initialItem: initialItem);
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/ghadvazn.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width / 11,
                ),
                Container(
                  width: Get.width / 3,
                  height: Get.height / 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Constants.shadeColor, blurRadius: 5)
                      ],
                      color: Colors.white),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 20),
                        child: Text(
                          "قد :",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 32,
                        width: Get.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            maxLength: 3,
                            controller: controller.height,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontFamily: Constants.primaryFontFamilyAdad,
                              fontSize: 20,
                              color: Constants.secondaryColor,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              hintStyle: TextStyle(
                                color: Constants.textColor.withOpacity(0.4),
                                fontFamily: Constants.primaryFontFamilyAdad,
                                fontSize: 15.sp,
                              ),
                              hintText: "183".toPersianDigit(),
                            ),
                            onChanged: (value) {
                              controller.personHeight(
                                  controller.height.text.toString());
                              print(controller.personHeight.value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width / 3,
                  height: Get.height / 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Constants.shadeColor, blurRadius: 5)
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 20),
                        child: Text(
                          "وزن :",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 32,
                        width: Get.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            maxLength: 3,
                            controller: controller.weight,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontFamily: Constants.primaryFontFamilyAdad,
                              fontSize: 20,
                              color: Constants.secondaryColor,
                            ),
                            decoration: InputDecoration(
                                counterText: "",
                                hintStyle: TextStyle(
                                  color: Constants.textColor.withOpacity(0.4),
                                  fontFamily: Constants.primaryFontFamilyAdad,
                                  fontSize: 15.sp,
                                ),
                                hintText: "50 ".toPersianDigit()),
                            onChanged: (value) {
                              controller.personWeight(
                                  controller.weight.text.toString());
                                  print(controller.personWeight.value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Get.width / 11,
                ),
              ],
            ),
            SizedBox(
              height: Get.height / 45,
            ),
            const AroundWrist(),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Get.width / 7),
                      child: Text(
                        "جنسیت :",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Container(
                      child: SelectGender(controller: controller),
                    ),
                  ],
                ),
                if (controller.gender.value > 1) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    children: [
                      Container(
                          width: double.infinity,
                          child: ReqisterHelp(
                            child: GenderHelp(),
                            title: controller.gender.value == 2
                                ? "باردار"
                                : "شیرده",
                          )),
                      Container(
                        child: controller.gender.value == 2
                            ? WomanChild.Pregnancy(controller)
                            : WomanChild.Breastfeeding(controller),
                      ),
                    ],
                  ),
                ],
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            Divider(
              color: Constants.shadeColor,
              thickness: 1,
              indent: Get.width / 7,
              endIndent: Get.width / 7,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: Get.width / 7),
                child: Text(
                  "میزان فعالیت",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                for (var index = 0;
                    index < Avtivity.listActivity.length;
                    index++) ...[
                  Padding(
                    padding: EdgeInsets.only(
                        right: index == 0 ? Get.width / 7.5 : 0),
                    child: SizedBox(
                      child: ActivityItem(
                        title: Avtivity.listActivity[index]['title'],
                        icon: Avtivity.listActivity[index]['icon'],
                        index: index,
                      ),
                    ),
                  ),
                ]
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Get.width / 7, 8, Get.width / 7, 0),
              child: Container(
                height: Get.height / 10,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Constants.shadeColor)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      controller.personActivity.value == 0
                          ? Avtivity.listActivity[0]['content']
                          : controller.personActivity.value == 1
                              ? Avtivity.listActivity[1]['content']
                              : controller.personActivity.value == 2
                                  ? Avtivity.listActivity[2]['content']
                                  : controller.personActivity.value == 3
                                      ? Avtivity.listActivity[3]['content']
                                      : controller.personActivity.value == 4
                                          ? Avtivity.listActivity[4]['content']
                                          : "ابتدا فعالیت مورد نظر راانتخاب کنید",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 25,
            ),
            InkWell(
              onTap: () {
                var finalUserPerson = {
                  "name": controller.name.value.toString(),
                  "mobile": "0" + controller.phone.value.toString(),
                  "password": "0" + controller.phone.value.toString(),
                  "gender": Constants.generateGender(controller.gender.value),
                  "birth_date": controller.ageDate.value.toString(),
                 // "height": controller.personHeightSize.value,
                 "height":controller.personHeight.value,
                 /* "weight": (controller.personWeightKilo.value +
                          (int.parse(controller.personWeight.value) / 1000))
                      .toString(),*/
                  "weight":controller.personWeight.value.toString(),
                  "wrist": controller.aroundTheWrist.value,
                  //"lactation": (controller.gender.value==3?1:0),//breastfeedingID
                  "lactation_period": (controller.gender.value == 3
                      ? (controller.breastfeedingID.value == 3 ? 1 : 0)
                      : 0),
                  //"pregnant": (controller.gender.value==2?1:0),//pregnancyID
                  "pregnant_period": (controller.gender.value == 2
                      ? controller.pregnancyID.value
                      : 0),
                  "activity": controller.personActivity.value,
                  "code": Constants.storage.read('smsCode'),
                };
                RegisterUser(finalUserPerson);
              },
              child: Container(
                height: Get.height / 17,
                width: Get.width / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: Constants.primarygradiant,
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter)),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      "پایان ثبت نام",
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 25,
            ),
          ],
        ),
      ),
    );
  }


  static void RegisterUser(Map<String, dynamic> finalUserPerson) async {
    var result = await AuthUser.register(true, data: finalUserPerson);

    if (result is Success) {
      var json = jsonDecode(result.response.toString());
      Constants.token = json["token"];
      Constants.storage.write('UserToken', json["token"]);
      Constants.storage.write('UserInfo', json);
      Get.to(() => AppMain());
    } else if (result is Failure) {
      print(result.errorResponse);
      Get.snackbar("عضویت", "در عضویت خطایی رخ داد لطفا دوباره تلاش کنید");
    }
  }
}
