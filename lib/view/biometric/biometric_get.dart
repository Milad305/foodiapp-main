import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/biometric/biometric.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/select-date/select-date.dart';

import 'biometric-insert.dart';
import 'biometric_item_tile.dart';

class BiometricGet extends GetView<BiometricGetter> {
  BiometricGet({Key? key}) : super(key: key) {
    Get.lazyPut(() => BiometricGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusManager.instance.primaryFocus?.unfocus();
      controller.getBiometricRecords();
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
            afterChange: Get.find<BiometricGetter>()),
        centerTitle: true,
        toolbarHeight: 80,
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () {
          if (controller.loading.value) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Colors.black45,
                size: 17,
              ),
            );
          }
          if (controller.biometricRecords.isEmpty) {
            return Center(
              child: Text(
                "داده‌ای وارد نشده",
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            );
          }
          List items = controller.biometricRecords.reversed.toList();

          return Column(
            children: [
              SizedBox(height: 30.sp),
              Expanded(
                  child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return BiometricItemTile(item: item, controller: controller);
                },
              )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => BiometricInsert());
        },
      ),
    );
  }
}
