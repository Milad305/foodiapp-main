import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/utils/constants.dart';

class AppleFullData extends GetView<ReportCardApple> {
  final date;
  final allData;

  AppleFullData({Key? key, required this.date, required this.allData})
      : super(key: key) {
    Get.put(ReportCardApple());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: 
      
      Obx(
        () {
          
          List calorieReport = controller.calorieReport;
          final dayAverage = controller.getDayAverage;
          final loading = controller.loading.value;
          if (loading) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Colors.black45,
                size: 17,
              ),
            );
          }
          if (calorieReport.isEmpty || dayAverage.isEmpty) {
            return Center(
              child: Text(
                "خطا در دریافت اطلاعات",
                style: TextStyle(fontSize: 17.sp),
              ),
            );
          }
          final colors = Constants.config;
          final colorsPfc = jsonDecode(colors.toString())["colors"];

          final calorie = calorieReport[0];
          final pfcKeys = dayAverage[0].keys.map((e) => e).toList();
          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.all(Get.width/43),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.fromLTRB(Get.width/40,Get.height/70,Get.width/40,Get.height/70),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Constants.shadeColor,
                                offset: const Offset(6, 10),
                                blurRadius: 10,
                                spreadRadius: 5,
                                blurStyle: BlurStyle.normal,
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding:  EdgeInsets.all(Get.width/50),
                              child: Text(
                                "کالری مجاز",
                                style: TextStyle(fontSize: 20.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Divider(color: Constants.shadeColor,thickness: 1,indent: Get.width/12,endIndent: Get.width/12,),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                              
                                FractionallySizedBox(
                                  widthFactor: 0.60,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Get.width/50),
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      final tableData = [
                                        {
                                          "title": "فعالیت",
                                          "color":  Constants.textColor,
                                        "circleColor":   const Color(0xFFEA8722),
                                          "size": calorieReport[0]["exercise"]
                                        },
                                        {
                                          "title": "کالری مورد نیاز",
                                          "color":  Constants.textColor,
                                          "circleColor":   const Color(0xFFD15AA6),
                                          "size": calorieReport[0]["bmr"]
                                        },
                                        {
                                          "title": "سطح فعالیت",
                                          "color": Constants.textColor,
                                          "circleColor": const Color(0xFF08A5A4),

                                          "size": calorieReport[0]["activity"]
                                        }
                                      ];
                                      return Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(3),
                                          1: FlexColumnWidth(2),
                                        },
                                        border: TableBorder.all(
                                            color: Colors.transparent),
                                        textDirection: TextDirection.rtl,
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: tableData.map((item) {
                                          return TableRow(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.symmetric(
                                                    vertical: Get.height/100, horizontal: Get.width/50),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                       height: Get.width/45,
                                                    width: Get.width/45,
                                                      decoration: BoxDecoration(
                                                        color:item['circleColor'],
                                                        shape: BoxShape.circle),),
                                                        SizedBox(width: Get.width/80,),
                                                    Text(
                                                      '${item["title"]}',
                                                      style: TextStyle(
                                                          color: item["color"],
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(
                                                     vertical : Get.height/100, horizontal: Get.width/50),
                                                child: Text(
                                                  item["size"]
                                                      .toString()
                                                      .toPersianDigit(),
                                                  style: TextStyle(fontSize: 12.sp),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }),
                                  ),
                                ),
                                  FractionallySizedBox(
                                  widthFactor: 0.40,
                                  child: Padding(
                                    padding:  EdgeInsets.all(Get.width/50),
                                    child: SizedBox(
                                      height: Get.height/4,
                                      width: Get.height/4,
                                      child: Stack(
                                        children:[ 
                                          Container(
                                            height: Get.height/4,
                                            width: Get.height/4,
                                            decoration: BoxDecoration(
                                              boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,
                                              offset: const Offset(6,10)
                                              )
                                              ],
                                              shape: BoxShape.circle,color: Colors.white),
                                          ),
                                          
                                          PieChart(
                                          dataMap: {
                                            "exercise": double.parse(
                                                calorie["exercise"].toString()),
                                            "bmr":
                                                double.parse(calorie["bmr"].toString()),
                                            "activity": double.parse(
                                                calorie["activity"].toString()),
                                          },
                                          animationDuration:
                                              const Duration(milliseconds: 800),
                                          chartLegendSpacing: 10,
                                          chartRadius: 110,
                                          colorList: const [
                                            Color(0xFFEA8722),
                                            Color(0xFFD15AA6),
                                            Color(0xFF08A5A4),
                                          ],
                                          initialAngleInDegree: 0,
                                          chartType: ChartType.ring,
                                          centerText:
                                              calorie["burned"].toStringAsFixed(1).toString().toPersianDigit(),
                                          centerTextStyle:  TextStyle(
                                              fontSize: 20.sp, color: Constants.textColor),
                                          ringStrokeWidth: 10,
                                          legendOptions:  LegendOptions(
                                            showLegendsInRow: true,
                                            legendPosition: LegendPosition.bottom,
                                            showLegends: false,
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
                              ]),
                                    ),
                                  ),
                                ),
                               
                              ],
                            ),
                             FractionallySizedBox(
                                widthFactor: 1,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: Get.width/40,right: Get.width/40,bottom: Get.height/90),
                                  child: Container(
                                    width: double.infinity,
                       
                                       
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.fromLTRB(Get.width/30,Get.height/70,Get.width/30,Get.height/70),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "کالری مجاز",
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              Text(
                                                calorie["burned"].toStringAsFixed(1).toString().toPersianDigit(),
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "=",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "سطح ‌فعالیت",
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              Text(
                                                calorie["activity"].toStringAsFixed(1).toString().toPersianDigit(),
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "+",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "فعالیت",
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              Text(
                                                calorie["exercise"].toStringAsFixed(1).toString().toPersianDigit(),
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "+",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "متابولیسم",
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                              Text(
                                                calorie["bmr"].toStringAsFixed(1).toString().toPersianDigit(),
                                                style: TextStyle(fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),

                   

                    Padding(
                      padding:  EdgeInsets.fromLTRB(Get.width/40,Get.height/70,Get.width/40,Get.height/70),
                      child: Container(
                        decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Constants.shadeColor,
                                  offset: const Offset(6, 10),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  blurStyle: BlurStyle.normal,
                                )
                              ]),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(Get.width/50),
                              child: Text(
                                "کالری دریافتی",
                                style: TextStyle(fontSize: 20.sp),
                                textAlign: TextAlign.right,
                              ),
                              
                            ),
                            Divider(color: Constants.shadeColor,thickness: 1,indent: Get.width/12,endIndent: Get.width/12,),

                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                              
                                FractionallySizedBox(
                                  widthFactor: 0.60,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Get.width/50),
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      List tableData = [
                                        {
                                          "title": dayAverage[0][pfcKeys[1]]
                                                  ["name"]
                                              .toString(),
                                                                               "color": Constants.textColor,

                                          "size": calorie["protein"],
                                          "circleColor": Constants.getColorFromHex(
                                              colorsPfc[pfcKeys[1]])
                                        },
                                        {
                                          "title": dayAverage[0][pfcKeys[2]]
                                                  ["name"]
                                              .toString(),
                                          "color": Constants.textColor,
                                          "size": calorie["carbohydrate"],
                                          "circleColor": Constants.getColorFromHex(
                                              colorsPfc[pfcKeys[2]])
                                        },
                                        {
                                          "title": dayAverage[0][pfcKeys[3]]
                                                  ["name"]
                                              .toString(),
                                                                                    "color": Constants.textColor,

                                          "size": calorie["fat"],
                                          "circleColor": Constants.getColorFromHex(
                                              colorsPfc[pfcKeys[3]])
                                        }
                                      ];
                                      return Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(3),
                                          1: FlexColumnWidth(2),
                                        },
                                        border: TableBorder.all(
                                            color: Colors.transparent),
                                        textDirection: TextDirection.rtl,
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: tableData.map((item) {
                                          return TableRow(
                                            children: [
                                              Padding(
                                                padding:
                                                     EdgeInsets.symmetric(
                                                        vertical: Get.height/100,
                                                        horizontal: Get.width/50),
                                                child: Row(
                                                  children: [
                                                     Container(
                                                    height: Get.width/45,
                                                    width: Get.width/45,
                                                    decoration: BoxDecoration(
                                                      color:item['circleColor'],
                                                      shape: BoxShape.circle),),
                                                      SizedBox(width: Get.width/30,),
                                                    Text(
                                                      '${item["title"]}',
                                                      style: TextStyle(
                                                          color: item["color"],
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 8),
                                                child: Text(
                                                  item["size"]
                                                      .toString()
                                                      .toPersianDigit(),
                                                  style:
                                                      TextStyle(fontSize: 12.sp),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }),
                                  ),
                                ),
                                  FractionallySizedBox(
                                  widthFactor: 0.40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: Get.height/6,
                                      width: Get.height/6,
                                      decoration:  BoxDecoration(
                                          boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,
                                          offset: Offset(6,10)
                                          )
                                          ],
                                          shape: BoxShape.circle,color: Colors.white),
                                          child: PieChart(
                                    dataMap: {
                                      dayAverage[0][pfcKeys[1]]["name"]:
                                          double.parse(dayAverage[0][pfcKeys[1]]
                                                  ["value"]
                                              .toString()),
                                      dayAverage[0][pfcKeys[2]]["name"]:
                                          double.parse(dayAverage[0][pfcKeys[2]]
                                                  ["value"]
                                              .toString()),
                                      dayAverage[0][pfcKeys[3]]["name"]:
                                          double.parse(dayAverage[0][pfcKeys[3]]
                                                  ["value"]
                                              .toString())
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
                                        calorie["energy"].toStringAsFixed(1).toString().toPersianDigit(),
                                    centerTextStyle:  TextStyle(
                                        fontSize: 20.sp, color: Constants.textColor),
                                    ringStrokeWidth: 10,
                                    legendOptions:  LegendOptions(
                                      showLegendsInRow: true,
                                      legendPosition: LegendPosition.bottom,
                                      showLegends: false,
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height/30,)
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.fromLTRB(Get.width/40,Get.height/70,Get.width/40,Get.height/70),
                      child: Container(
                        width: double.infinity,
                         decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Constants.shadeColor,
                                  offset: const Offset(6, 10),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  blurStyle: BlurStyle.normal,
                                )
                              ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "کالری باقیمانده",
                                style: TextStyle(fontSize: 20.sp),
                                textAlign: TextAlign.right,
                              ),
                            ),
                             Divider(color: Constants.shadeColor,thickness: 1,indent: Get.width/12,endIndent: Get.width/12,),

                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                             
                                FractionallySizedBox(
                                  widthFactor: 0.60,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Get.width/50),
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      final tableData = [
                                        {
                                          "title": "کالری باقی مانده",
                                          "color":Constants.textColor,
                                          "size": calorieReport[0]["burned"],
                                          "circleColor" : Color(0xFFA9A9A9),
                                        },
                                        {
                                          "title": "کالری مصرفی",
                                          "color": Constants.textColor,
                                          "size": calorieReport[0]["energy"],
                                           "circleColor" :const Color(0xFFD15AA6),

                                        }
                                      ];
                                      return Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(2),
                                          1: FlexColumnWidth(1),
                                        },
                                       
                                        textDirection: TextDirection.rtl,
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: tableData.map((item) {
                                          return TableRow(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.symmetric(
                                                        vertical: Get.height/100,
                                                        horizontal: Get.width/50,),
                                                child: Row(
                                                  children: [
                                                       Container(
                                                         height: Get.width/45,
                                                      width: Get.width/45,
                                                        decoration: BoxDecoration(
                                                          color:item['circleColor'],
                                                          shape: BoxShape.circle),),
                                                          SizedBox(width: 10.sp),
                                                    Text(
                                                      '${item["title"]}',
                                                      style: TextStyle(
                                                          color: item["color"],
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(
                                                    vertical: Get.height/100, horizontal: Get.width/50),
                                                child: Text(
                                                  item["size"]
                                                      .toString()
                                                      .toPersianDigit(),
                                                  style: TextStyle(fontSize: 12.sp),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }),
                                  ),
                                ),
                                   FractionallySizedBox(
                                  widthFactor: 0.40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: Get.height/6,
                                      width: Get.height/6,
                                      decoration:  BoxDecoration(
                                          boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,
                                          offset: Offset(6,10)
                                          )
                                          ],
                                          shape: BoxShape.circle,color: Colors.white),
                                          
                                          child: PieChart(
                                      dataMap: {
                                        "burned": double.parse(
                                            calorie["burned"].toString()),
                                        "energy": double.parse(
                                            calorie["energy"].toString()),
                                      },
                                      animationDuration:
                                          const Duration(milliseconds: 800),
                                      chartLegendSpacing: 10,
                                      chartRadius: 110,
                                      colorList: const [
                                        Color(0xFFDADADA),
                                        Color(0xFFD15AA6)
                                      ],
                                      initialAngleInDegree: 0,
                                      chartType: ChartType.ring,
                                      centerText:
                                          (calorie["burned"] - calorie["energy"]).toStringAsFixed(1).toString().toPersianDigit(),
                                      centerTextStyle:  TextStyle(
                                          fontSize: 20.sp, color: Constants.textColor),
                                      ringStrokeWidth: 10,
                                      legendOptions:  LegendOptions(
                                        showLegendsInRow: true,
                                        legendPosition: LegendPosition.bottom,
                                        showLegends: false,
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
                                          
                                          ),
                                  ),
                                ),

                             
                              ],
                            ),
                            SizedBox(height: Get.width/30,),
                               FractionallySizedBox(
                                widthFactor: 1,
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                   const EdgeInsets.symmetric(horizontal: 5),
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: Get.height/78, vertical: Get.width/50),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(Get.width/30,Get.height/70,Get.width/30,Get.height/70),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "کالری باقیمانده",
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            Text(
                                              (calorie["burned"] - calorie["energy"]).toStringAsFixed(1).toString().toPersianDigit(),
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "=",
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "کالری مجاز",
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            Text(
                                              calorie["burned"].toStringAsFixed(1).toString().toPersianDigit(),
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "-",
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "کالری دریافتی",
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            Text(
                                              calorie["energy"].toStringAsFixed(1).toString().toPersianDigit(),
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    )

                    /////
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

