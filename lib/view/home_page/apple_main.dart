import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/biometric/biometric_get.dart';
import 'package:salamatiman/view/home_page/apple_full_data.dart';
import 'package:salamatiman/view/notes/notes-main.dart';
import 'package:salamatiman/widgets/apple.dart';

import '../../getx/bottom_navigation_bar.dart';
import '../user-sport/sport_records.dart';

class AppleMain extends StatelessWidget {
  final allData;
  AppleMain({Key? key, required this.allData}) : super(key: key){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Constants.userInfo = await GetStorage().read('UserInfo');
    });
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = 195.sp;
    // ignore: non_constant_identifier_names
    Widget AppleMainText(title, [title2]) {
      return Padding(
        padding: EdgeInsets.only(top: 4.0.sp),
        child: Container(
          height: Get.height / 15,
          width: Get.width / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 2))
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(bottom: 8.sp),
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minWidth: Get.width * 0.20,
          ),
          child: IntrinsicHeight(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  if (title2 != "") ...[
                    Divider(
                      color: Constants.shadeColor,
                      height: 2,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    FittedBox(
                      child: Text(
                        "$title2".toString().toPersianDigit(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey.shade600),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Obx(() {
      if (allData.containsKey("GetCalorieReport")) {
        final calories = allData['GetCalorieReport'];
        final getBiometricActivity = allData['getFirstPageStats'];

        final size = calories != ""
            ? (((calories["energy"] * 100) / calories["burned"]) / 100)
            : 0;
        return calories != ""
            ? SizedBox(
                width: Get.width,
                height: sizeHeight.sp,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: SizedBox(
                        width: Constants.appleSize,
                        child: GestureDetector(
                          onTap: () => Get.to(() => AppleFullData(
                                date: "",
                                allData: allData,
                              )),
                          child: AppleWidget(
                            size: size,
                            text: "${(calories["energy"]).toStringAsFixed(1)}",
                            maxSize: double.parse(allData['GetCalorieReport']
                                    ['burned']
                                .toString()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 2,
                      child: Container(
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  AppleMainText(
                                    "کالری مجاز",
                                    "${(calories["burned"]).toStringAsFixed(1)}",
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => BiometricGet());
                                },
                                child: getBiometricActivity["last_biometric"] !=
                                        null
                                    ? AppleMainText(
                                        getBiometricActivity[
                                                    "last_biometric"] ==
                                                null
                                            ? "بیومتریک"
                                            : getBiometricActivity[
                                                    "last_biometric"]
                                                ["description"],
                                        getBiometricActivity["last_biometric"]
                                                    ["amount"] ==
                                                null
                                            ? 0
                                            : getBiometricActivity[
                                                            "last_biometric"]
                                                        ["amount"]
                                                    .toString() +
                                                getBiometricActivity[
                                                            "last_biometric"]
                                                        ["unit"]
                                                    .toString())
                                    : AppleMainText("بایومتریک", "-"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => NotesMain());
                                },
                                child: AppleMainText("یادداشت", ""),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 5,
                            left: 30,
                            child: Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.only(
                                  left: 5, right: 0, top: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: Constants.primarygradiant,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.center,
                            ),
                          )
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AppleMainText(
                                    " کالری باقی‌مانده",
                                    "${(calories["burned"] - calories["energy"]).toStringAsFixed(1)}",
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => SportRecords());
                                },
                                child: AppleMainText(
                                    "فعالیت",
                                    getBiometricActivity["total_calories"]
                                        .toString()
                                        .split("-")[0]
                                        .toString()),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.find<BottomNavigationBarGetter>()
                                      .itemSelecter(2);
                                },
                                child: AppleMainText("کارنامه", ""),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 5,
                            right: 30,
                            child: Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 0, top: 5),
                              decoration: BoxDecoration(
                                color: Constants.appleEmptyColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              )
            : Text('');
      }
      return Container();
    });
  }
}
