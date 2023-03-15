import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/utils/constants.dart';

class ReportFoodGoals extends GetView<ReportCardGetter> {
  final foodGoals;

  ReportFoodGoals({Key? key, required this.foodGoals}) : super(key: key);

  final List myFoodGoalsLang = [
    {
      "key": "vitamins",
      "fa": "ویتامین ها",
    },
    {
      "key": "immune",
      "fa": "سیستم ایمنی",
    },
    {
      "key": "electrolytes",
      "fa": "الکترولیت ها",
    },
    {
      "key": "antioxidants",
      "fa": "آنتی اکسیدانها",
    },
    {
      "key": "oral_health",
      "fa": "سلامت دهان و دندان",
    },
    {
      "key": "metabolism",
      "fa": "سوخت و ساز بدن",
    },
    {
      "key": "minerals",
      "fa": "مواد معدنی",
    }
  ];

  @override
  Widget build(BuildContext context) {
    //final myLength = (myFoodGoalsLang.length / 3).ceil();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ExpandablePageView.builder(
            controller: PageController(keepPage: true, initialPage: 0),
            itemCount: 3,
            onPageChanged: (val) {
              controller.pageView1(int.parse(val.toString()));
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index == 0) ...[
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          WidgetFoodGoals(index: 0),
                          WidgetFoodGoals(index: 1),
                          WidgetFoodGoals(index: 2),
                        ],
                      ),
                    )
                  ],
                  if (index == 1) ...[
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          WidgetFoodGoals(index: 3),
                          WidgetFoodGoals(index: 4),
                          WidgetFoodGoals(index: 5),
                        ],
                      ),
                    )
                  ],
                  if (index == 2) ...[
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          WidgetFoodGoals(index: 6),
                        ],
                      ),
                    )
                  ],
                ],
              );
            },
          ),
          Container(
            width: Get.width,
            height: 30,
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  Obx(() {
                    final pageActive = controller.pageView1.value;
                    return Container(
                      width: 9,
                      height: 9,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: pageActive == i
                            ? Constants.secondaryColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  })
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget WidgetFoodGoals({index}) {
    final goal = foodGoals[0][myFoodGoalsLang[index]["key"]];
    final goalFa = myFoodGoalsLang[index]["fa"];
    var percentage = 0.0;
    for (var i = 0; i < goal.length; i++) {
      percentage = (percentage +
          (goal[i]["percentage"] >= 100
              ? 100.0
              : double.parse(goal[i]["percentage"].toString())));
    }
    return GestureDetector(
      onTap: () {
        print(goalFa);
        MyAlertDialog(goal: goal, goalFa: goalFa);
      },
      child: FractionallySizedBox(
        widthFactor: 0.30,
        child: Column(
          children: [
            Container(
              width: Get.width * 0.29,
              height: Get.width * 0.29,
              alignment: Alignment.center,
              child: MyPieChart(
                goalFa: goalFa,
                myColor: goalFa=='آنتی اکسیدانها'?
                Constants.antioxidants:
                goalFa=='سیستم ایمنی'? Constants.immuneSystem:
                goalFa=='سلامت دهان و دندان'?Constants.dent:
                goalFa=='سوخت و ساز بدن'?Constants.metabolism:
                goalFa=='ویتامین ها'?Constants.vitamins:
                goalFa=='الکترولیت ها'?Constants.electrolytes:
                goalFa=='مواد معدنی'?Constants.minerals:Colors.black,
                  width: double.infinity,
                  title: goalFa,
                  size: (percentage / goal.length) >= 100
                      ? 100
                      : (percentage / goal.length)),
            ),
            Text(
              goalFa.toString(),
              style: TextStyle(
                fontSize: 14.sp,
                color: goalFa=='آنتی اکسیدانها'?
                Constants.antioxidants:
                goalFa=='سیستم ایمنی'? Constants.immuneSystem:
                goalFa=='سلامت دهان و دندان'?Constants.dent:
                goalFa=='سوخت و ساز بدن'?Constants.metabolism:
                goalFa=='ویتامین ها'?Constants.vitamins:
                goalFa=='الکترولیت ها'?Constants.electrolytes:
                goalFa=='مواد معدنی'?Constants.minerals:Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget MyPieChart({
    
    required width,
    required goalFa,
    required myColor,
    required title,
    required size,
  }) {
    final charSize = double.parse(size.toString());
    return Transform.rotate(
      angle: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, 0),
                blurRadius: 5.0,
                spreadRadius: 0.0)
          ],
        ),
        child: PieChart(
          dataMap: {
            title: charSize,
            "empty": (100 - (charSize * 100) / 100),
          },
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 5,
          chartRadius: width,
          colorList: [
                goalFa=='آنتی اکسیدانها'? Constants.antioxidants:
                goalFa=='سیستم ایمنی'? Constants.immuneSystem:
                goalFa=='سلامت دهان و دندان'?Constants.dent:
                goalFa=='سوخت و ساز بدن'?Constants.metabolism:
                goalFa=='ویتامین ها'?Constants.vitamins:
                goalFa=='الکترولیت ها'?Constants.electrolytes:
                goalFa=='مواد معدنی'?Constants.minerals:Colors.black,
            Colors.transparent,
          ],
          initialAngleInDegree: -90,
          chartType: ChartType.ring,
          centerText: "%${size.toStringAsFixed(1).toString().toPersianDigit()}",
          centerTextStyle:
              TextStyle(fontSize: 23.sp, color: myColor),
          ringStrokeWidth: 5,
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: false,
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),

          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        ),
      ),
    );
  }

  void MyAlertDialog({goal, goalFa}) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: Get.height * 0.6,
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${goalFa}",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: goal.length,
                    itemBuilder: (context, index) {
                      final percentage = goal[index]["percentage"] >= 100
                          ? 100
                          : goal[index]["percentage"];
                      return Container(
                        margin: EdgeInsets.only(top: 12, bottom: 5),
                        width: double.infinity,
                        color: Colors.grey.shade50.withOpacity(0.2),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: FractionallySizedBox(
                                widthFactor: 1,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${goal[index]["name"]}",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      "${goal[index]["unit_name"]}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade500,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.centerRight,
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: FractionallySizedBox(
                                    widthFactor: percentage / 100,
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      alignment: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
