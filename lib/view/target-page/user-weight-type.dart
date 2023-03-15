import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import 'target-item-box.dart';
import 'weight.dart';

class UserWeightType extends GetView<PersonTargetGeter> {
  UserWeightType({Key? key}) : super(key: key) {
    controller.targetWeightType(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "لطفا هدفتو انتخاب کن",
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(height: 60.sp),
                Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.targetWeightType(1);
                      },
                      child: Obx(() => TargetItemBox(
                            text: "افزایش وزن",
                            imageID: 1,
                            isActive: controller.targetWeightType.value == 1
                                ? true
                                : false,
                          )),
                    ),
                    SizedBox(
                      width: Get.width / 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.targetWeightType(2);
                      },
                      child: Obx(() => TargetItemBox(
                            text: "کاهش وزن",
                            imageID: 2,
                            isActive: controller.targetWeightType.value == 2
                                ? true
                                : false,
                          )),
                    ),
                    // SizedBox(
                    //   width: Get.width / 25,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     controller.targetWeightType(3);
                    //   },
                    //   child: Obx(() => TargetItemBox(
                    //         text: "تثبیت وزن",
                    //         imageID: 3,
                    //         isActive: controller.targetWeightType.value == 3
                    //             ? true
                    //             : false,
                    //       )),
                    // ),
                  ],
                ),
                SizedBox(
                  height: Get.height / 17,
                ),
                Image.asset(
                  "assets/images/wheighttarget.png",
                  scale: 2,
                ),
                SizedBox(
                  height: Get.height / 17,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * .20,
                    height: Get.height / 20,
                    child: Obx(() => controller.targetWeightType.value > 0
                        ? Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(100)),
                                depth: 8,
                                lightSource: LightSource.topLeft,
                                color: Colors.grey.shade400),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => InputUserWeight());
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: Constants.primarygradiant,
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter)),
                                alignment: Alignment.center,
                                child: Text("بعدی",
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white)),
                              ),
                            ),
                          )
                        : Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(100)),
                                depth: 8,
                                lightSource: LightSource.topLeft,
                                color: Colors.grey.shade400),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                color: Constants.disabledColor,
                                alignment: Alignment.center,
                                child: Text("بزن بریم",
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white)),
                              ),
                            ),
                          )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
