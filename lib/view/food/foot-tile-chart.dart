import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/model/food/food-model.dart';
import 'package:salamatiman/utils/constants.dart';

class FoodTileChart extends GetView<FoodGetter> {
  final FoodModel food;

  const FoodTileChart({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final proteinSize = (food.protein / 100);
      final fatSize = food.fat / 100;
      final carbohydrateSize = food.carbohydrate / 100;

      final deviceWidth = Get.width * 0.8;

      ///portions

      var portionSelected = (controller.portions.value == ""
          ? food.portions[0]
          : jsonDecode(controller.portions.value));

      var amount = double.parse(portionSelected["amount"].toString());
      var gram_weight = double.parse(portionSelected["gram_weight"].toString());
      var thisGram = gram_weight / amount;
      var forProteinSize = (thisGram * proteinSize) * controller.size.value;
      var forFatSize = (thisGram * fatSize) * controller.size.value;
      var forCarbohydrateSize =
          (thisGram * carbohydrateSize) * controller.size.value;

      final sum = forProteinSize + forFatSize + forCarbohydrateSize;

      final proteinWSize = (forProteinSize / sum) * deviceWidth;
      final fatWSize = (forFatSize / sum) * deviceWidth;
      final carbohydrateWSize = (forCarbohydrateSize / sum) * deviceWidth;

      final forCalories =
          (forProteinSize * 4) + (forFatSize * 9) + (forCarbohydrateSize * 4);
      return PieChart(
        dataMap: {
          "پروتئین (${forProteinSize.toStringAsFixed(2).toString().toPersianDigit()})":
              proteinWSize,
          "چربی (${forFatSize.toStringAsFixed(2).toString().toPersianDigit()})":
              fatWSize,
          "کربوهیدرات (${forCarbohydrateSize.toStringAsFixed(2).toString().toPersianDigit()})":
              carbohydrateWSize,
        },
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 0,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: <Color>[
          Color(0xff25a456),
          Color(0xfff14447),
          Color(0xff2e97e8)
        ],
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 3,
        centerTextStyle: TextStyle(
            fontSize: 17,
            color: Colors.black87,
            fontFamily: Constants.primaryFontFamily),
        centerText: " " +
            ((forCalories.toStringAsFixed(2)).toString().toPersianDigit()) +
            " کالری ",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.left,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(fontSize: 17),
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
      );
    });
  }
}
