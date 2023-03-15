import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/meal-main/chart.dart';

import 'calorie-progress.dart';
import 'calorie-progress2.dart';

class FoodCalorieInfo extends GetView<FoodGetter> {
  final homeController, title;
  const FoodCalorieInfo(
      {Key? key, required this.homeController, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width/1.1,
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 8),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("وعده ${title}"),
          SizedBox(
            height: 15,
            
          ),
          Divider(color:Constants.shadeColor ,),
           SizedBox(
            height: 15,
            
          ),
          
          Obx(() {
            final records = controller.records.value;
            //config
            final config = homeController.allData['GetCalorieReport'];
            final burned = config["burned"];
            final energy = config["energy"];
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
                        child: Text(
                          "کالری",
                          style: TextStyle(fontSize: 14.sp, color: Constants.textColor),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child:
                            CalorieProgress(calories: burned > 0 ? burned : 0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: LayoutBuilder(
                    builder: (context, snapshot) {
                      final foodsAverage = controller.records.value;
                      final dailyAverage =
                          homeController.allData['get_pfc_daily_average'];
                      var carbohydrate = dailyAverage['carbohydrate'];
                      var protein = dailyAverage['protein'];
                      var fat = dailyAverage['fat'];

                      //////////////////////
                      double finalCarbohydrateAverage = 0.0;
                      foodsAverage
                          .map((e) => finalCarbohydrateAverage +=
                              double.parse(e["carbohydrate"].toString()))
                          .toList();
                      //////
                      double finalProteinAverage = 0.0;
                      foodsAverage
                          .map((e) => finalProteinAverage +=
                              double.parse(e["protein"].toString()))
                          .toList();
                      //////
                      double finalFatAverage = 0.0;
                      foodsAverage
                          .map((e) => finalFatAverage +=
                              double.parse(e["fat"].toString()))
                          .toList();

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
                          FoodCaloriesChart(),
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
