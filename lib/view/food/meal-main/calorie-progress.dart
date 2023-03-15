import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';

class CalorieProgress extends GetView<FoodGetter> {
  final calories;
  const CalorieProgress({Key? key, required this.calories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double caloriesCount = 0.0;
    if (controller.groupId == -1) {
      if (controller.allRecords.isNotEmpty) {
        final allRecordsKeys = controller.allRecords.keys.toList();
        final allRecords = controller.allRecords;
        for (int i = 0; i < allRecordsKeys.length; i++) {
          for (int z = 0;
              z < allRecords[allRecordsKeys[i].toString()].length;
              z++) {
            caloriesCount += double.parse(
                allRecords[allRecordsKeys[i].toString()][z]["calories"]
                    .toString());
          }
        }
        for (var i = 0; i < controller.records.value.length; i++) {
          caloriesCount +=
              double.parse(controller.records[i]["calories"].toString());
        }
      }
    } else {
      if (controller.records.isNotEmpty) {
        for (var i = 0; i < controller.records.value.length; i++) {
          caloriesCount +=
              double.parse(controller.records[i]["calories"].toString());
        }
      }
    }

    Color color = Colors.yellow;

    var myProgress = 0.01;
    if (controller.records.isNotEmpty && calories > 0) {
      myProgress = ((caloriesCount * 100) / calories) / 100;
      if (myProgress > 0.5 && myProgress <= 1) {
        color = Colors.green;
      } else if (myProgress > 1) {
        color = Colors.red;
      }
    }

    return Obx(() => controller.records.isNotEmpty
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                      text: "کالری ",
                      children: [
                        TextSpan(
                          text: caloriesCount
                              .toStringAsFixed(2)
                              .toString()
                              .toPersianDigit(),
                        ),
                        TextSpan(text: "  "),
                        TextSpan(
                            text:
                                "${((caloriesCount / calories) * 100).toStringAsFixed(2).toString().toPersianDigit()}"),
                        TextSpan(text: "%"),
                      ],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Constants.textColor,
                      )),
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
          )
        : Text(''));
  }
}
