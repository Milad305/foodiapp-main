import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/utils/constants.dart';

import 'weeks-average-progress.dart';

class WeeksAverage extends GetView<ReportCardGetter> {
  final weeksAverage;
  var colors = "";

  WeeksAverage({Key? key, required this.weeksAverage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    colors = Constants.config;
    return Obx(() {
      final calorieReport = controller.calorieReport;
      if (calorieReport.isEmpty) {
        return Container();
      }
      final colorsPfc = jsonDecode(colors.toString())["colors"];
      final pfcKeys = weeksAverage[0].keys.map((e) => e).toList();
      final calorie = controller.calorieReport[0];
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Constants.shadeColor,
                      blurRadius: 10,
                      offset: Offset(3, 10))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  if (weeksAverage.isNotEmpty) ...[
                    for (int i = 0; i < weeksAverage[0].length; i++) ...[
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width / 17, right: Get.width / 17),
                        child: WeeksAverageProgress(
                            nutrient: weeksAverage[0][pfcKeys[i]],
                            color: colorsPfc[pfcKeys[i]]),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(right: Get.width / 17),
                    child: Text(
                      "خلاصه گزارش کالری",
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: Get.width / 2.3,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Constants.shadeColor,
                                blurRadius: 10,
                                offset: Offset(3, 10))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "کالری مصرفی",
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            PieChart(
                              dataMap: {
                                weeksAverage[0][pfcKeys[1]]["name"]: 20,
                                weeksAverage[0][pfcKeys[2]]["name"]: 30,
                                weeksAverage[0][pfcKeys[3]]["name"]: 50
                              },
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 10,
                              chartRadius: 110,
                              colorList: [
                                Constants.getColorFromHex(
                                    colorsPfc[pfcKeys[1]]),
                                Constants.getColorFromHex(
                                    colorsPfc[pfcKeys[2]]),
                                Constants.getColorFromHex(
                                    colorsPfc[pfcKeys[3]]),
                              ],
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              centerText:
                                  "${calorie["energy"].toStringAsFixed(1).toString().toPersianDigit()}",
                              centerTextStyle: TextStyle(
                                  fontSize: 20.sp, color: Constants.textColor),
                              ringStrokeWidth: 10,
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.bottom,
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width / 2.3,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Constants.shadeColor,
                                blurRadius: 10,
                                offset: Offset(3, 10))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "کالری مجاز",
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            PieChart(
                              dataMap: {
                                "متابولیسم":
                                    double.parse(calorie["energy"].toString()),
                                "سطح فعالیت": double.parse(
                                    calorie["activity"].toString()),
                                "تمرین": double.parse(
                                    calorie["exercise"].toString()),
                              },
                              animationDuration:
                                  const Duration(milliseconds: 800),
                              chartLegendSpacing: 10,
                              chartRadius: 110,
                              colorList: [
                                Constants.getColorFromHex(colorsPfc["energy"]),
                                Constants.getColorFromHex(
                                    colorsPfc["activity"]),
                                Constants.getColorFromHex(
                                    colorsPfc["exercise"]),
                              ],
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              centerText:
                                  "${calorie["burned"].toStringAsFixed(1).toString().toPersianDigit()}",
                              centerTextStyle: TextStyle(
                                  fontSize: 20.sp, color: Constants.textColor),
                              ringStrokeWidth: 10,
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.bottom,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height / 40,
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
