import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/sport/sport-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/select-date/select-date.dart';

import 'sport_record_tile.dart';
import 'user-sport-main.dart';

class SportRecords extends GetView<SportGetter> {
  SportRecords({Key? key}) : super(key: key) {
    Get.lazyPut(() => SportGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getSportRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        title: WidgetSelectDateHome(
            filed: controller.dateSelected,
            afterChange: Get.find<SportGetter>()),
        centerTitle: true,
        toolbarHeight: 80,
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        final loading = controller.loading.value;
        if (loading) {
          return const Center(
            child: SpinKitThreeBounce(
              color: Colors.black45,
              size: 17,
            ),
          );
        }
        if (controller.records.isEmpty) {
          return Center(
            child: Text(
              "هنوز تمرینی انجام ندادی",
              style: TextStyle(fontSize: 18.sp),
            ),
          );
        }
        final records = controller.records;
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 1),
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(7),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: records
                          .map((element) => SportRecordTile(item: element))
                          .toList(),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "جمع کالری",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double calories = 0.0;
                            records
                                .map((element) => calories +=
                                    double.parse(element.calories.toString()))
                                .toList();
                            return Text(
                              calories
                                  .toString()
                                  .replaceAll(RegExp('[^0-9.]'), '')
                                  .toString()
                                  .toPersianDigit(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Constants.secondaryColor,
                              ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => UserSportMain());
        },
      ),
    );
  }
}
