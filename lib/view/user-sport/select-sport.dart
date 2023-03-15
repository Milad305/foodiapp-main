import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/sport/sport-getter.dart';
import 'package:salamatiman/utils/age-calculator.dart';
import 'package:salamatiman/utils/constants.dart';

import 'add_record.dart';

class SelectSport extends GetView<SportGetter> {
  final id;
  final catTitle;
  final userInfo = Constants.userInfo;
  bool isLoadData = false;
  SelectSport({Key? key, required this.id, required this.catTitle})
      : super(key: key) {
    controller.minute(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle.toString()),
        centerTitle: true,
        surfaceTintColor: Constants.primaryColor,
        backgroundColor: Constants.primaryColor,
      ),
      body: SafeArea(
        child: Obx(() {
          if (isLoadData == false) {
            Get.find<SportGetter>().getSport(categoryID: id);
            isLoadData = true;
          }

          final loading = controller.loadingSport.value;
          final sport = controller.sport;
          final age = AgeCalculator.age(DateTime.parse(userInfo["birth_date"]));
          final stress = userInfo["stress"] ?? 1;
          final height = userInfo["height"] ?? 1;
          final weight = userInfo["weight"] ?? 1;
          final gender = userInfo["gender"] ?? "male";
          return loading
              ? Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black45,
                    size: 17,
                  ),
                )
              : sport.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: sport.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              final sport =
                                  Get.find<SportGetter>().sport[index];
                              AddSportRecord.add(sport);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              margin:
                                  EdgeInsets.only(bottom: 5, left: 5, right: 5),
                              padding: EdgeInsets.all(5),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Get.width * 0.8,
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text("${sport[index].description}"),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 17,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        "خطا در دریافت داده‌ها",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    );
        }),
      ),
    );
  }
}
