import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/view/food/appbar.dart';
import 'package:salamatiman/widgets/macro-micro/macro-micro.dart';

import 'all_foods/all_foods.dart';
import 'food-calories-info-add_foods.dart';
import 'meal-main-loading-all.dart';

class MealMainAll extends GetView<FoodGetter> {
  final group, title, onlySnack;
  MealMainAll(
      {Key? key,
      required this.title,
      required this.group,
      required this.onlySnack})
      : super(key: key) {
    Get.put(FoodGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.groupId(group);
      controller.records([]);
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
        body: Column(
          children: [
            SafeArea(
              child: FoodPageAppBar(title: title, groupId: group),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: Get.width,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Obx(() {
                    final records = controller.allRecords;
                    if (controller.recordsLoad.value == 0) {
                      return MealMainLoadingAll(onlySnack: onlySnack);
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          AllFoodsCaloris(
                              allRecords: records, onlySnack: onlySnack),
                          const SizedBox(height: 30),
                          FoodCalorieInfoAllFoods(onlySnack: onlySnack),
                          const SizedBox(height: 30),
                          MicroWidget(onlySnack: onlySnack),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
