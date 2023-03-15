import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/food-box.dart';

import 'food-box-shimmer.dart';

class FoodListPage extends GetView<FoodGetter> {
  final group;
  FoodListPage({Key? key, required this.group}) : super(key: key) {
    Get.put(FoodGetter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: Get.width,
                height: (Get.height / 3.5),
                color: Color(0xFF007882),
                child: Container(
                  height: (Get.height / 3.5),
                  width: Get.width,
                  child: Hero(
                    tag: "homeBreakfast",
                    child: Image.asset(
                      "assets/images/vadeh/breakfast.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: (Get.height - (Get.height / 3.5) + 20),
                margin: EdgeInsets.only(top: (Get.height / 3.5) - 20),
                decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Container(
                    height: (Get.height - (Get.height / 3.5) + 20),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() => controller.foods.value.isNotEmpty
                              ? GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.80,
                                  ),
                                  itemCount: controller.foods.value.length,
                                  itemBuilder: (context, index) {
                                    final food = controller.foods.value[index];
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(4),
                                      child: FoodBox(
                                        group: 1,
                                        food: food,
                                      ),
                                    );
                                  })
                              : Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(4),
                                  child: FoodShimmer(),
                                )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
