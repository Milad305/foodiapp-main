import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import 'operation-target.dart';

class InputUserWeight extends GetView<PersonTargetGeter> {
  final userInfo = GetStorage().read('UserInfo');

  InputUserWeight({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.weight(double.parse(userInfo['weight'].toString()));
      controller.targetWeight(controller.weight.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 8,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     final weight2 = controller.weight.value;
                  //     final bmi = UserBMI.getBMI(
                  //         weight: weight2 == null
                  //             ? double.parse(weight2.toString())
                  //             : 0.0);
                  //     print(bmi);
                  //   },
                  //   child: SizedBox(
                  //     width: Get.width / 1.2,
                  //     child: Obx(() {
                  //       final weight = controller.weight.value;
                  //       if (weight < 1) {
                  //         return Container();
                  //       }
                  //
                  //       final bmi = UserBMI.getBMI(
                  //           weight: weight == null
                  //               ? double.parse(weight.toString())
                  //               : 0.0);
                  //       return Text.rich(TextSpan(
                  //           text: "شاخص توده بدنی شما",
                  //           style: TextStyle(fontSize: 15.sp),
                  //           children: [
                  //             const TextSpan(text: " "),
                  //             TextSpan(
                  //                 text: Constants.getBMI(bmi["bmi"]).toString(),
                  //                 style: TextStyle(
                  //                     color: Constants.secondaryColor,
                  //                     fontSize: 19.sp)),
                  //             const TextSpan(text: " می باشد "),
                  //             const TextSpan(text: "و برابر با "),
                  //             TextSpan(
                  //                 text: bmi["bmi"].toString().toPersianDigit(),
                  //                 style: TextStyle(
                  //                     color: Constants.secondaryColor,
                  //                     fontSize: 19.sp)),
                  //             const TextSpan(text: " "),
                  //             const TextSpan(text: "هستش"),
                  //             const TextSpan(text: " و "),
                  //             const TextSpan(text: "وزن ایده آل شما "),
                  //             TextSpan(
                  //                 text: bmi["normal_weight"]
                  //                     .toString()
                  //                     .toPersianDigit(),
                  //                 style: TextStyle(
                  //                     color: Constants.secondaryColor,
                  //                     fontSize: 19.sp)),
                  //             const TextSpan(text: " کیلو گرم می باشد "),
                  //           ]));
                  //     }),
                  //   ),
                  // ),
                  // Divider(
                  //   color: Constants.shadeColor,
                  //   indent: Get.width / 15,
                  //   endIndent: Get.width / 15,
                  //   thickness: 1,
                  // ),
                  Text(
                    "وزن فعلی و وزن هدف خودت رو وارد کن",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width / 2.5,
                        height: Get.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Constants.shadeColor, blurRadius: 10)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "وزن فعلی :",
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: Get.width * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.sp),
                              ),
                              child: TextFormField(
                                controller: TextEditingController(
                                    text: double.parse(
                                            userInfo['weight'].toString())
                                        .toString()),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(3),
                                  isDense: true,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: Constants.primaryFontFamilyAdad,
                                ),
                                onChanged: (val1) {
                                  if (val1 != "") {
                                    controller
                                        .weight(double.parse(val1.toString()));
                                  } else {
                                    controller.weight(0.0);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 10,
                      ),
                      Container(
                        width: Get.width / 2.5,
                        height: Get.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Constants.shadeColor, blurRadius: 10)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "وزن هدف :",
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: Get.width * 0.15,
                              child: Obx(() {
                                final weight = controller.weight.value;
                                return TextFormField(
                                  controller: TextEditingController(
                                      text: double.parse(weight.toString())
                                          .toString()),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true,
                                    hintText: "وزن هدف",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: Constants.primaryFontFamilyAdad,
                                  ),
                                  onChanged: (val) {
                                    if (val != "")
                                      controller.targetWeight(
                                          double.parse(val.toString()));
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  Center(
                    child: SizedBox(
                      width: Get.width * .25,
                      height: Get.height / 17,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(100)),
                            depth: 8,
                            lightSource: LightSource.topLeft,
                            color: Colors.grey.shade400),
                        child: InkWell(
                          onTap: () {
                            // Get.to(InputUserTargetWeight());
                            final targetWeight = controller.targetWeight.value;
                            final weight = controller.weight.value;
                            final type = controller.targetWeightType.value;
                            if (type == 2) {
                              if (weight < targetWeight) {
                                Fluttertoast.showToast(
                                    msg:
                                        "وزن هدف نباید بیشتر از وزن فعلیت باشه");
                              } else {
                                Get.to(() => OperationTarget());
                              }
                            }
                            if (type == 1) {
                              if (weight > targetWeight) {
                                Fluttertoast.showToast(
                                    msg:
                                        "وزن هدف نباید کمتر از وزن فعلیت باشه");
                              } else {
                                Get.to(() => OperationTarget());
                              }
                            }
                            if (type != 1 || type != 2) {
                              Get.to(() => OperationTarget());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: Constants.primarygradiant,
                                    end: Alignment.bottomCenter,
                                    begin: Alignment.topCenter)),
                            child: Text("بریم بعدی",
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.sp),
                    child: Image.asset("assets/images/target/target.png"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
