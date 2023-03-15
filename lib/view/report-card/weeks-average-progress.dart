import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

class WeeksAverageProgress extends StatelessWidget {
  final nutrient, color;
  const WeeksAverageProgress(
      {Key? key, required this.nutrient, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  "${nutrient["name"]} ${nutrient["percentage"].toStringAsFixed(1).toString().toPersianDigit()}%",
                  style:  TextStyle(fontSize: 16.sp),
                ),
                Text.rich(
                  TextSpan(
                    text:
                        "${nutrient["value"] != null ? nutrient["value"].toStringAsFixed(2).toString().toPersianDigit() : 0.0}",
                    children: [
                      const TextSpan(text: " / "),
                      TextSpan(
                          text:
                              '${nutrient["target"] != null ? nutrient["target"].toStringAsFixed(2).toString().toPersianDigit() : 0.0}')
                    ],
                  ),
                  style:  TextStyle(fontSize: 16.sp),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.grey.shade300,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: (nutrient["percentage"] >= 100
                                  ? 100
                                  : nutrient["percentage"]) /
                              100,
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 12,
                              color: Constants.getColorFromHex(color) != null
                                  ? Constants.getColorFromHex(color)
                                  : Constants.primaryColor2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
