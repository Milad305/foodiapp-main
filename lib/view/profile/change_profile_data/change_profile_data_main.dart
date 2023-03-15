import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

abstract class ChangeProfileData extends StatelessWidget {
  ChangeProfileData({Key? key}) : super(key: key);

  static show({
    required title,
    required name,
    required value,
    required TextInputType type,
    required TextDirection align,
    required bool isBack,
  }) {
    TextEditingController txtcontroller = TextEditingController(text: "$value");
    Get.dialog(
        GestureDetector(
          onTap: () => Get.back(),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () => false,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    constraints: BoxConstraints(minHeight: 150),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text(
                                "$title",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: (Get.width) - 140,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: txtcontroller,
                                    onTap: () {
                                      txtcontroller.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: txtcontroller
                                                      .text.length));
                                    },
                                    keyboardType: type,
                                    textDirection: align,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    textAlign: TextDirection.rtl == align
                                        ? TextAlign.start
                                        : TextAlign.end,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.find<AuthGetter>().changeProfileField(
                                          name: name,
                                          val: txtcontroller.text,
                                          isBack: isBack);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Constants.secondaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      alignment: Alignment.center,
                                      width: 80,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "ذخیره",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
        barrierDismissible: false,
        useSafeArea: true);
  }
}
