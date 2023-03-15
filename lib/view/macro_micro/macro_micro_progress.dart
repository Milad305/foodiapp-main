import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/widgets/macro-micro/progress_bar_macro.dart';

class MacroMicroProgress extends StatelessWidget {
  final String title;
  final double width;
  final Color color;
  final progress;
  final target;
  const MacroMicroProgress(
      {Key? key,
      required this.title,
      required this.width,
      required this.color,
      required this.progress,
      required this.target})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Align(
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    title.toString().toPersianDigit(),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "%" + progress.toString().toPersianDigit(),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          SizedBox(
            height: 0,
          ),
          ProgressBarMacroMicro(
            width: width,
            progress: progress,
            color: color,
          ),
        ],
      ),
    );
  }
}
