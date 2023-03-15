import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class ProfileWrist extends GetView<AuthGetter> {
  final defaultWrist;
  final defaultNum = 10;
  int userWrist = 0;
  FixedExtentScrollController? _ScrollerController =
      FixedExtentScrollController();
  ProfileWrist({Key? key, required this.defaultWrist}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userWrist = defaultWrist == null ? defaultNum : defaultWrist;
      controller.aroundTheWrist(userWrist);
      _ScrollerController =
          FixedExtentScrollController(initialItem: userWrist + defaultNum);
    });
  }
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotatedBox(
        quarterTurns: -5,
        child: Container(
          width: 65,
          child: ListWheelScrollView.useDelegate(
            controller: _ScrollerController,
            itemExtent: 30,
            diameterRatio: 200,
            onSelectedItemChanged: (val) async {
              controller.aroundTheWrist(val + 10);
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(seconds: 2), () {
                Get.find<AuthGetter>().changeProfileField(
                    name: "wrist",
                    val: int.parse(controller.aroundTheWrist.value.toString()),
                    isBack: false);
              });
            },
            physics: FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: 41,
                builder: (context, index) {
                  return RotatedBox(
                    quarterTurns: 1,
                    child: Container(
                      child: Obx(() {
                        final activeID = controller.aroundTheWrist.value;
                        return Column(
                          children: [
                            Container(
                              width: 2,
                              height: 25,
                              color: Colors.grey,
                            ),
                            activeID == (index + 10)
                                ? Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      (index + defaultNum)
                                          .toString()
                                          .toPersianDigit(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Constants.textSelected,
                                      ),
                                    ),
                                  )
                                : Text(
                                    (index + 10).toString().toPersianDigit()),
                          ],
                        );
                      }),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
