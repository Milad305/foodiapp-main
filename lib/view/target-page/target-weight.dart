import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/target-page/operation-target.dart';

class InputUserTargetWeight extends GetView<PersonTargetGeter> {
  InputUserTargetWeight({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.targetWeight(controller.weight.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("وزن هدفتو تعیین کن", style: TextStyle(fontSize: 22.sp)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: Get.width * 0.4,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade700,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50.sp),
                    ),
                    child: Obx(() {
                      final weight = controller.weight.value;
                      return TextFormField(
                        controller: TextEditingController(
                            text: double.parse(weight.toString()).toString()),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          hintText: "وزن هدف",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: Constants.primaryFontFamilyAdad,
                        ),
                        onChanged: (val) {
                          if (val != "")
                            controller
                                .targetWeight(double.parse(val.toString()));
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 20.sp),
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
                        child: GestureDetector(
                          onTap: () {
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
                            color: Constants.successColor,
                            alignment: Alignment.center,
                            child: Text(
                              "بریم بعدی",
                              style:
                                  TextStyle(fontSize: 17.sp, color: Colors.white),
                            ),
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
