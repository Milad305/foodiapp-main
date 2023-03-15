import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import 'preview-target.dart';

class OperationTarget extends GetView<PersonTargetGeter> {
  const OperationTarget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, String> type = {
      0: "خیلی آسان",
      1: "آسان",
      2: "متوسط",
      3: "سخت",
    };
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width * 0.9,
          margin:
              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GetSizeTitle(0, type),
                      GetSizeTitle(1, type),
                      GetSizeTitle(2, type),
                      GetSizeTitle(3, type),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Get.width * 0.05),
        child: SizedBox(
          height: 50,
          width: Get.width/4,
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 5,
                lightSource: LightSource.topLeft,
                color: Colors.grey.shade400),
            child: InkWell(
              onTap: () {
                controller.setUserTarget();
                Get.to(() => PreviewTarget(),
                    transition: Transition.circularReveal,
                    duration: Duration(milliseconds: 700));
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: Constants.primarygradiant,
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter)),
                alignment: Alignment.center,
                child: Text("بریم بعدی",
                    style: TextStyle(fontSize: 17.sp, color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GetSizeTitle(index, type) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.obesitySlimmingSelected(index);
          },
          child: Obx(() => Neumorphic(
                style: NeumorphicStyle(
                  
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(100)),
                    depth: 5,
                    lightSource: LightSource.topLeft,
                    color: Colors.grey.shade400),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        margin: EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                            color: index ==
                                    controller.obesitySlimmingSelected.value
                                ? Constants.successColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: index ==
                                        controller.obesitySlimmingSelected.value
                                    ? Constants.successColor
                                    : Constants.disabledColor,
                                style: BorderStyle.solid,
                                width: 1.3)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${type[index]}",
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          Text.rich(TextSpan(
                            style:  TextStyle(fontSize: 13.sp),
                            children: [
                              TextSpan(
                                  text: controller.targetWeightType.value == 3
                                      ? controller.weight.value >
                                              controller.targetWeight.value
                                          ? "کاهش"
                                          : "افزایش"
                                      : controller.targetWeightType.value == 1
                                          ? 'افزایش'
                                          : 'کاهش'),
                              const TextSpan(text: " "),
                              TextSpan(
                                text: Constants.obesitySlimming[index]
                                    .toString()
                                    .toPersianDigit(),
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.textColor),
                              ),
                              const TextSpan(text: ' کیلوگرمی'),
                              const TextSpan(text: ' در هفته'),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
