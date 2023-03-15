import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';

class FoodCaloriesChart extends GetView<FoodGetter> {
  const FoodCaloriesChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.records.isEmpty) {
        return Container();
      }
      var foodData = controller.records[0];
      double protein = 0.0;
      controller.records
          .map((e) => protein += double.parse(e["protein"].toString()))
          .toList();
      /////
      double fat = 0.0;
      controller.records
          .map((e) => fat += double.parse(e["fat"].toString()))
          .toList();
      ////
      double carbohydrate = 0.0;
      controller.records
          .map(
              (e) => carbohydrate += double.parse(e["carbohydrate"].toString()))
          .toList();
      return SingleChildScrollView(
        child: PieChart(
          dataMap: {
            "پروتئین (${protein.toStringAsFixed(2).toString().toPersianDigit()})":
                protein,
            "چربی (${fat.toStringAsFixed(2).toString().toPersianDigit()})": fat,
            "کربوهیدرات (${carbohydrate.toStringAsFixed(2).toString().toPersianDigit()})":
                carbohydrate,
          },
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 5,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          colorList: const <Color>[
            Color(0xff25a456),
            Color(0xfff14447),
            Color(0xff2e97e8)
          ],
          initialAngleInDegree: 1,
          chartType: ChartType.disc,
          ringStrokeWidth: 5,
          centerTextStyle: TextStyle(
              fontSize: 12.sp,
              color: Constants.textColor,
              fontFamily: Constants.primaryFontFamily),
          centerText: "",
          legendOptions:  LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.left,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(fontSize: 15),
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
      );
    });
  }
}

class AllFoodCaloriesChart extends GetView<FoodGetter> {
  const AllFoodCaloriesChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double protein = 0.0;
      double fat = 0.0;
      double carbohydrate = 0.0;
      ///////////
      if (controller.allRecords.isNotEmpty) {
        final foodData = controller.allRecords;
        final allRecordsKeys = controller.allRecords.keys.toList();
        if (allRecordsKeys.isNotEmpty) {
          for (int i = 0; i < allRecordsKeys.length; i++) {
            for (int z = 0;
                z < foodData[allRecordsKeys[i].toString()].length;
                z++) {
              final val = foodData[allRecordsKeys[i].toString()][z];
              protein += double.parse(val["protein"].toString());
              fat += double.parse(val["fat"].toString());
              carbohydrate += double.parse(val["carbohydrate"].toString());
            }
          }
        }
      }

      return SingleChildScrollView(
        child: PieChart(
          dataMap: {
            "پروتئین (${protein > 0 ? protein.toStringAsFixed(2).toString().toPersianDigit() : "0".toPersianDigit()})":
                protein,
            "چربی (${fat > 0 ? fat.toStringAsFixed(2).toString().toPersianDigit() : "0".toPersianDigit()})":
                fat,
            "کربوهیدرات (${carbohydrate > 0 ? carbohydrate.toStringAsFixed(2).toString().toPersianDigit() : "0".toPersianDigit()})":
                carbohydrate,
          },
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 5,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          colorList: const <Color>[
            Color(0xff25a456),
            Color(0xfff14447),
            Color(0xff2e97e8)
          ],
          initialAngleInDegree: 1,
          chartType: ChartType.disc,
          ringStrokeWidth: 5,
          centerTextStyle: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontFamily: Constants.primaryFontFamily),
          centerText: "",
          legendOptions:  LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.left,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(fontSize: 15),
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
      );
    });
  }
}
