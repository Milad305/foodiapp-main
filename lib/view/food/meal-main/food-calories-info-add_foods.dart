import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/meal-main/chart.dart';

import 'calorie-progress2.dart';
import 'calorie-progress_add_foods.dart';

class FoodCalorieInfoAllFoods extends GetView<FoodGetter> {
  final onlySnack;

  const FoodCalorieInfoAllFoods({Key? key, this.onlySnack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width/1.1,
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,offset: Offset(0,5))],
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("کل وعده های غذایی"),
          const SizedBox(
            height: 15,
          ),
          Obx(() {
            final allRecords = controller.allRecords;
            //config
            final config = Get.find<HomeGetter>().allData['GetCalorieReport'];
            final burned = config["burned"];
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: const Text(
                          "کالری",
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: CalorieProgressAllFoods(
                            calories: burned > 0 ? burned : 0),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: LayoutBuilder(
                    builder: (context, snapshot) {
                      RxMap foodsAverage = controller.allRecords;

                      final dailyAverage = Get.find<HomeGetter>()
                          .allData['get_pfc_daily_average'];
                      var carbohydrate = dailyAverage['carbohydrate'];
                      var protein = dailyAverage['protein'];
                      var fat = dailyAverage['fat'];

                      //////////////////////
                      double finalCarbohydrateAverage = 0.0;
                      List allRecordsKeys = controller.allRecords.keys.toList();
                      if (onlySnack) {
                        try {
                          foodsAverage.remove("2");
                          foodsAverage.remove("4");
                          foodsAverage.remove("6");
                        } catch (e) {
                          throw (e);
                        }
                        allRecordsKeys = [3, 5, 7];
                      }
                      for (int i = 0; i < allRecordsKeys.length; i++) {
                        if (foodsAverage.containsKey(i.toString())) {
                          final item =
                              foodsAverage[allRecordsKeys[i].toString()] == null
                                  ? []
                                  : foodsAverage[allRecordsKeys[i].toString()];
                          for (int x = 0; x < item.length; x++) {
                            finalCarbohydrateAverage += double.parse(
                                foodsAverage[allRecordsKeys[i].toString()][x]
                                        ["carbohydrate"]
                                    .toString());
                          }
                        }
                      }

                      //////
                      double finalProteinAverage = 0.0;
                      for (int i = 0; i < allRecordsKeys.length; i++) {
                        if (foodsAverage[allRecordsKeys[i].toString()] !=
                            null) {
                          for (int z = 0;
                              z <
                                  foodsAverage[allRecordsKeys[i].toString()]
                                      .length;
                              z++) {
                            final protein =
                                foodsAverage[allRecordsKeys[i].toString()][z]
                                    ["protein"];
                            if (protein != null) {
                              finalProteinAverage += double.parse(
                                  foodsAverage[allRecordsKeys[i].toString()][z]
                                          ["protein"]
                                      .toString());
                            }
                          }
                        }
                      }

                      //////
                      double finalFatAverage = 0.0;
                      if (foodsAverage != null) {
                        for (int i = 0; i < allRecordsKeys.length; i++) {
                          if (foodsAverage[allRecordsKeys[i].toString()] !=
                              null) {
                            for (int z = 0;
                                z <
                                    foodsAverage[allRecordsKeys[i].toString()]
                                        .length;
                                z++) {
                              finalFatAverage += double.parse(
                                  foodsAverage[allRecordsKeys[i].toString()][z]
                                          ["fat"]
                                      .toString());
                            }
                          }
                        }
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 0.32,
                                  child: CalorieProgress2(
                                    title: "کربوهیدرات",
                                    data: carbohydrate,
                                    foodsAverage: finalCarbohydrateAverage,
                                    color: Color(0xff2e97e8),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.32,
                                  child: CalorieProgress2(
                                    title: "پروتئین",
                                    data: protein,
                                    foodsAverage: finalProteinAverage,
                                    color: Color(0xff25a456),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.32,
                                  child: CalorieProgress2(
                                    title: "چربی",
                                    data: fat,
                                    foodsAverage: finalFatAverage,
                                    color: Color(0xfff14447),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          const AllFoodCaloriesChart(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
