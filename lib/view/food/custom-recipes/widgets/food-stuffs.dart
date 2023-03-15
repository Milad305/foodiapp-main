import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/recipes.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/food-stuffs-add.dart';

import '../../../../utils/constants.dart';

class FoodStuffs extends GetView<RecipesGetter> {
  const FoodStuffs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color titleColor = Colors.grey.shade500;
    return Container(
      width: Get.width / 1.05,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Constants.shadeColor,
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
      child: Column(
        children: [
          SizedBox(height: 5.sp),
          SizedBox(
            width: Get.width / 1.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "لیست مواد اولیه",
                  style: TextStyle(color: Constants.textColor, fontSize: 16.sp),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Obx(() {
                      final foods = controller.foods;
                      double calories = 0.0;
                      List caloriesList = [];
                      try {
                        foods
                            .map((e) => caloriesList.add(controller.calories(
                                  food: e['food'],
                                  size: double.parse(e['count'].toString()),
                                  portions: e['portion'],
                                )))
                            .toList();

                        caloriesList
                            .map((e) => calories += e['calories'])
                            .toList();
                      } catch (e) {}
                      return Text(
                        calories.toStringAsFixed(1).toPersianDigit().toString(),
                        style: TextStyle(color: Constants.textColor),
                      );
                    }),
                    Text(
                      " کالری ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Constants.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Constants.shadeColor,
            indent: Get.width / 17,
            endIndent: Get.width / 17,
            thickness: 1,
          ),
          Obx(() {
            final foods = controller.foods;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (foods.isEmpty) ...[
                  SizedBox(height: 30.sp),
                ],
                if (foods.isNotEmpty) ...[
                  SizedBox(height: 5.sp),
                  for (int i = 0; i < foods.length; i++) ...[
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double calories = 0.0;
                        List caloriesList = [];
                        try {
                          caloriesList.add(controller.calories(
                            food: foods[i]['food'],
                            size: double.parse(foods[i]['count'].toString()),
                            portions: foods[i]['portion'],
                          ));
                        } catch (e) {}
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: i % 2 != 0
                                ? Constants.textFieldBg
                                : Colors.white,
                          ),
                          width: Get.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (Get.width - 220).sp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foods[i]['food'].shortTitle.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      foods[i]["portion"]["modifier"]
                                              .replaceAll('"', '')
                                              .toString() +
                                          ": " +
                                          foods[i]["count"]
                                              .toString()
                                              .toPersianDigit(),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                '${double.parse(caloriesList[0]['calories'].toString()).toStringAsFixed(1).toPersianDigit()} کالری',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.foods.remove(foods[i]);
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                  SizedBox(height: 10.sp),
                ],
              ],
            );
          }),
          const FoodStuffsAdd(),
          SizedBox(height: 10.sp),
        ],
      ),
    );
  }
}
