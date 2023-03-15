import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/appbar.dart';
import 'package:salamatiman/view/food/food-category.dart';

import '../../../widgets/macro-micro/macro-micro.dart';
import 'food-calories-info.dart';
import 'food-copy-and-add.dart';
import 'food-empty.dart';
import 'foodbox.dart';

class MealMain extends GetView<FoodGetter> {
  final group, title;

  MealMain({Key? key, required this.title, required this.group})
      : super(key: key) {
    Get.put(FoodGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.groupId(group);
      controller.getFoodRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> back() async {
      if (controller.foodSelected.isEmpty) {
        return true;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Get.find<FoodGetter>().foodSelected([]);
        });

        return false;
      }
    }

    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() {
            if (controller.recordsLoad.value == 1 &&
                controller.records.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    FoodPageAppBar(
                        title: title, groupId: controller.groupId.value),
                                if (group != -1) ...[
                      Padding(
                        padding: EdgeInsets.only(right:Get.width/12),
                        child: FoodCopyAndAdd(group: group, title: title),
                      ),
                      SizedBox(
                        height: Get.height/50
                      ),
                                                  Divider(color: Constants.shadeColor,thickness: 1,endIndent: Get.width/17,indent: Get.width/17,)
                     , SizedBox(
                        height: Get.height/50)
                    ],
                  
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight: Get.height / 2),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.records.length,
                                itemBuilder: (context, index) {
                                  final Food = controller.records[index];
                                  return FoodBox(Food: Food);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final records = controller.records.value;
                                  double caloriesCount = 0;
                                  records
                                      .map((item) => caloriesCount +=
                                          double.parse(
                                              item["calories"].toString()))
                                      .toList();

                                  return Text.rich(TextSpan(
                                        text:" جمع کالری :    "+
                                            caloriesCount.toStringAsFixed(2).toString().toPersianDigit(),
                                        style: TextStyle(fontSize: 12.sp, color: Constants.textColor, fontWeight: FontWeight.w700),
                                      ));
                                               
                                  
                                },
                              ),
                            ),
                            Divider(color: Constants.shadeColor,thickness: 1,endIndent: Get.width/17,indent: Get.width/17,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                 
                    GetBuilder<HomeGetter>(
                        init: HomeGetter(),
                        builder: (homeController) {
                          return FoodCalorieInfo(
                              homeController: homeController, title: title);
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    // Obx(() => controller.topNutrients.isNotEmpty
                    //     ? CalorieProgress3(
                    //         nutrient: controller.topNutrients,
                    //         date: controller.dateSelected == ""
                    //             ? GetDate.todayOnlyDate()
                    //             : controller.dateSelected.value,
                    //         groupId: group)
                    //     : Container()),
                    MicroWidget(onlySnack: true, onlyfood: true, gid: group),
                    SizedBox(
                      height: 30.sp
                    ),
                  ],
                ),
              );
            }
            if (controller.recordsLoad.value != 1 &&
                controller.recordsLoad.value != 2) {
              return const Center(
                child: SpinKitThreeBounce(
                  color: Colors.black45,
                  size: 17,
                ),
              );
            }
            return Column(
              children: [
                FoodPageAppBar(title: title, groupId: controller.groupId.value),
                FoodEmpty(
                  title: title,
                  group: group,
                ),
                Expanded(child: Container()),
              ],
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => FoodCategory(group: group, title: title),
                transition: Transition.zoom);
          },
        ),
      ),
    );
  }
}
