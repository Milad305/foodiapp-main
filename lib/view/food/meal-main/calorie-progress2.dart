import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';

class CalorieProgress2 extends GetView<FoodGetter> {
  final title, data, foodsAverage, color;
  const CalorieProgress2(
      {Key? key,
      required this.title,
      required this.data,
      required this.foodsAverage,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dailyAverageTarget = data["target"];
    var dailyAverageNnitName = data["unit_name"];
    var dailyAverageValue = foodsAverage;
    var size = foodsAverage == 0 || foodsAverage == 0.0
        ? 0.0
        : double.parse(((double.parse((foodsAverage * 100).toString()) /
                    double.parse(dailyAverageTarget.toString())) /
                100.0)
            .toString());
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  "$title",
                  style:
                      TextStyle(fontSize: 12.sp,),
                ),
                Text.rich(TextSpan(
                    text: "Infinity" != size.toString()
                        ? (size * 100)
                            .toStringAsFixed(0)
                            .toString()
                            .toPersianDigit()
                        : "0".toPersianDigit(),
                        style: TextStyle(fontSize: 12.sp,color: Constants.textColor),
                    children: [
                      TextSpan(text: "%", style: TextStyle(fontSize: 11.sp)),
                    ])),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                height: 10,
                color: Colors.grey.shade300,
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: size.toString() == "Infinity" ? 0 : size,
                  child: Container(
                    height: 10,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                  text: dailyAverageValue
                      .toStringAsFixed(1)
                      .toString()
                      .toPersianDigit(),
                      style: TextStyle(fontSize: 10.sp)
                )),
                Text.rich(TextSpan(
                    text: dailyAverageTarget
                        .toStringAsFixed(1)
                        .toString()
                        .toPersianDigit(),
                        style: TextStyle(fontSize: 10.sp,color: Constants.textColor),
                    children: [
                      TextSpan(
                          text: "$dailyAverageNnitName",
                          style: TextStyle(fontSize: 12.sp)),
                    ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
