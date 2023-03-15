import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart' as prefix;
import 'package:salamatiman/getx/report-card/food_gruops_controller.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/meal-main/meal-main.dart';

class AllFoodsCaloris extends StatelessWidget {
  final allRecords, onlySnack;
  AllFoodsCaloris({Key? key, required this.allRecords, required this.onlySnack})
      : super(key: key);
  FoodGroupsController foodGroupsController = Get.put(FoodGroupsController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final allRecordsKeys = allRecords.keys.toList();
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onlySnack == false) ...[
              GestureDetector(
                onTap: () async {
                  Get.to(() => MealMain(group: 2, title: "صبحانه"));
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double calories = 0.0;
                    if (allRecordsKeys.contains("2"))
                      for (int i = 0; i < allRecords["2"].length; i++) {
                        calories += double.parse(
                            allRecords["2"][i]["calories"].toString());
                      }
                    return FoodAllTile(
                        title: "صبحانه",
                        img: "assets/images/vadeh/breakfast.png",
                        calories: allRecordsKeys.contains("2")
                            ? calories.toString()
                            : 0.toString(),
                        foodsConst: allRecordsKeys.contains("2")
                            ? allRecords["2"].length
                            : 0,
                        first: false);
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => MealMain(group: 4, title: "ناهار"));
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double calories = 0.0;
                    if (allRecordsKeys.contains("4")) {
                      allRecords["4"]
                          .map((item) => calories +=
                              double.parse(item["calories"].toString()))
                          .toList();
                    }
                    return FoodAllTile(
                        title: "ناهار",
                        img: "assets/images/vadeh/lunch.png",
                        calories: allRecordsKeys.contains("4")
                            ? calories.toString()
                            : 0.toString(),
                        foodsConst: allRecordsKeys.contains("4")
                            ? allRecords["4"].length
                            : 0,
                        first: false);
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => MealMain(group: 6, title: "شام"));
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double calories = 0.0;
                    if (allRecordsKeys.contains("6")) {
                      allRecords["6"]
                          .map((item) => calories +=
                              double.parse(item["calories"].toString()))
                          .toList();
                    }
                    return FoodAllTile(
                        title: "شام",
                        img: "assets/images/vadeh/dinner.png",
                        calories: allRecordsKeys.contains("6")
                            ? calories.toString()
                            : 0.toString(),
                        foodsConst: allRecordsKeys.contains("6")
                            ? allRecords["6"].length
                            : 0,
                        first: false);
                  },
                ),
              ),
            ],
            GestureDetector(
              onTap: () async {
                Get.to(() => MealMain(group: 3, title: "میان‌وعده قبل ناهار"));
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double calories = 0.0;
                  if (allRecordsKeys.contains("3")) {
                    allRecords["3"]
                        .map((item) => calories +=
                            double.parse(item["calories"].toString()))
                        .toList();
                  }

                  return FoodAllTile(
                      title: "میان‌وعده قبل ناهار",
                      img: "assets/images/vadeh/snaks.png",
                      calories: allRecordsKeys.contains("3")
                          ? calories.toString()
                          : 0.toString(),
                      foodsConst: allRecordsKeys.contains("3")
                          ? allRecords["3"].length
                          : 0,
                      first: false);
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                Get.to(() => MealMain(group: 5, title: "میان‌وعده بعد ناهار"));
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double calories = 0.0;
                  if (allRecordsKeys.contains("5")) {
                    allRecords["5"]
                        .map((item) => calories +=
                            double.parse(item["calories"].toString()))
                        .toList();
                  }

                  return FoodAllTile(
                      title: "میان‌وعده بعد ناهار",
                      img: "assets/images/vadeh/snaks.png",
                      calories: allRecordsKeys.contains("5")
                          ? calories.toString()
                          : 0.toString(),
                      foodsConst: allRecordsKeys.contains("5")
                          ? allRecords["5"].length
                          : 0,
                      first: false);
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                Get.to(() => MealMain(group: 7, title: "میان‌وعده بعد شام"));
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double calories = 0.0;
                  if (allRecordsKeys.contains("7")) {
                    allRecords["7"]
                        .map((item) => calories +=
                            double.parse(item["calories"].toString()))
                        .toList();
                  }

                  return FoodAllTile(
                      title: "میان‌وعده بعد شام",
                      img: "assets/images/vadeh/snaks.png",
                      calories: allRecordsKeys.contains("7")
                          ? calories.toString()
                          : 0.toString(),
                      foodsConst: allRecordsKeys.contains("7")
                          ? allRecords["7"].length
                          : 0,
                      first: true);
                },
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                double allCalorisSize = 0.0;
                if (allRecords.isNotEmpty) {
                  List allRecordsKeys = allRecords.keys.toList();
                  if (onlySnack) {
                    allRecordsKeys = ["3", "5", "7"];
                  }
                  Map<dynamic, dynamic> records = allRecords;

                  try {
                    for (int i = 0; i < allRecordsKeys.length; i++) {
                      final item = records[allRecordsKeys[i].toString()] != null
                          ? records[allRecordsKeys[i].toString()]
                          : [];
                      if (item.isNotEmpty)
                        for (int x = 0; x < item.length; x++) {
                          if (item[x] != null)
                            allCalorisSize +=
                                double.parse(item[x]["calories"].toString());
                        }
                    }
                  } catch (e) {
                    throw (e);
                  }
                }

                return Container(
                  width: Get.width / 1.1,
                  margin: EdgeInsets.only(top: 20.sp, bottom: 10.sp),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "جمع کل کالری",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Constants.textColor,
                        ),
                      ),
                      Text("----------------------------"),
                      Text(
                        double.parse(allCalorisSize.toString())
                            .toStringAsFixed(2)
                            .toPersianDigit(),
                        style: TextStyle(
                            fontSize: 13.sp, color: Constants.secondaryColor),
                      )
                    ],
                  ),
                );
              },
            ),
            Container(
              width: Get.width / 1.1,
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    "گروه های غذایی (واحد)",
                    style:
                        TextStyle(color: Constants.textColor, fontSize: 15.sp),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Obx(
                        () {
                          final item = foodGroupsController.byDay.value;
                          return PieChart(
                            dataMap: {
                              "گروه شیر و لبنیات" +
                                  "(" +
                                  item.foundations!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.foundations!.roundToDouble(),
                              "گروه میوه" +
                                  "(" +
                                  item.fruits!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.fruits!.roundToDouble(),
                              "گروه سبزیجات" +
                                  "(" +
                                  item.vegetables!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.vegetables!.roundToDouble(),
                              "گروه پرکالری" +
                                  "(" +
                                  item.highCallorie!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.highCallorie!.roundToDouble(),
                              "گروه غلات" +
                                  "(" +
                                  item.cereal!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.cereal!.roundToDouble(),
                              "گروه گوشت" +
                                  "(" +
                                  item.meat!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.meat!.roundToDouble(),
                              "گروه چربی" +
                                  "(" +
                                  item.fat!
                                      .roundToDouble()
                                      .toString()
                                      .toPersianDigit() +
                                  ")": item.fat!.roundToDouble(),
                            },
                            animationDuration:
                                const Duration(milliseconds: 800),
                            chartLegendSpacing: 0,
                            chartRadius: 120,

                            initialAngleInDegree: 0,
                            chartType: ChartType.disc,

                            centerTextStyle: TextStyle(
                                fontSize: 28.sp, color: Constants.textColor),
                            ringStrokeWidth: 20,
                            legendOptions: const LegendOptions(
                              legendPosition: prefix.LegendPosition.left,
                              showLegends: true,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: false,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  FoodAllTile(
      {required title,
      required String img,
      required foodsConst,
      required calories,
      required first}) {
    return Padding(
      padding: EdgeInsets.all(4.0.sp),
      child: Container(
        width: Get.width / 1.1,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Constants.shadeColor,
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 5.sp,
            ),
            Column(
              children: [
                SizedBox(
                  height: 5.sp,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Constants.shadeColor,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset("$img"),
                ),
                SizedBox(
                  height: 5.sp,
                ),
              ],
            ),
            const SizedBox(width: 7),
            Container(
              width: (Get.width - 190),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Constants.textColor,
                    ),
                  ),
                  Divider(
                    color: Constants.shadeColor,
                  ),
                  Text(
                    "${foodsConst} مورد".toPersianDigit(),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    double.parse(calories.toString()) > 0.00
                        ? double.parse(calories.toString())
                            .toStringAsFixed(2)
                            .toPersianDigit()
                        : 0.toString().toPersianDigit(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Constants.secondaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "کالری",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Constants.textColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5.sp,
            )
          ],
        ),
      ),
    );
  }
}
