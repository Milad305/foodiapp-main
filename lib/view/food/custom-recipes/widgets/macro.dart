import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/recipes.dart';
import 'package:salamatiman/utils/constants.dart';

class Macro extends GetView<RecipesGetter> {
  Macro({Key? key}) : super(key: key);
  final macroList = {
    "protein": "پروتئین",
    "fat": "چربی",
    "carbohydrate": "کربوهیدرات",
    "calories": "انرژی",
  };
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final foods = controller.foods;
      print(foods);

      if (foods.isEmpty) {
        return Container();
      }
      double calories = 0.0;
      List caloriesList = [];

      try {
        for (int i = 0; i < foods.length; i++) {
          caloriesList.add(controller.calories(
            food: foods[i]['food'],
            size: double.parse(foods[i]['count'].toString()),
            portions: foods[i]['portion'],
          ));
        }
      } catch (e) {}
      final macroListKeys = macroList.keys.toList();

      return SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < macroList.length; i++) ...[
              MacroLoop(
                title: macroList[macroListKeys[i].toString()].toString(),
                value: SumOfNumbers(caloriesList
                    .map((value) => value[macroListKeys[i]])
                    .toList()), // caloriesList[0][macroListKeys[i].toString()]
                color: i % 2 == 0 ? Constants.textFieldBg : Colors.transparent,
              ),
            ],
          ],
        ),
      );
    });
  }

  SumOfNumbers(numbers) {
    double number = 0.0;
    numbers.map((num) => number += num).toList();
    return number;
  }

  Widget MacroLoop({title, value, color}) {
    return Container(
      width: Get.width / 1.1,
      padding: EdgeInsets.symmetric(horizontal: 2.sp, vertical: 4.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Wrap(
        children: [
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Text(
              title.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Text(
              value.toStringAsFixed(1).toString().toPersianDigit(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
