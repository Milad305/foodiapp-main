import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foods.dart';

class CalorieProgressAllFoods extends GetView<FoodGetter> {
  final calories;
  CalorieProgressAllFoods({Key? key, required this.calories})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    double caloriesCount = 0.0;
    if (controller.allRecords.isNotEmpty) {
      final allRecordsKeys = controller.allRecords.keys.toList();
      final allRecords = controller.allRecords;
      for (int i = 0; i < allRecordsKeys.length; i++) {
        final item = allRecords[allRecordsKeys[i].toString()];
        for (int z = 0; z < item.length; z++) {
          caloriesCount += double.parse(item[z]["calories"].toString());
        }
      }
    }

    Color color = Colors.yellow;

    var myProgress = 0.0;
    if (controller.allRecords.isNotEmpty && calories > 0) {
      myProgress = ((caloriesCount * 100) / calories) / 100;
      if (myProgress > 0.5 && myProgress <= 1) {
        color = Colors.green;
      } else if (myProgress > 1) {
        color = Colors.red;
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("کالری"),
              Text(
                  "%${((caloriesCount / calories) * 100).toStringAsFixed(2).toString().toPersianDigit()}"),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                height: 10,
                color: Colors.grey.shade400,
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: myProgress,
                  child: Container(
                    height: 10,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
