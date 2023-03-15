import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:widget_mask/widget_mask.dart';

class BodyWaterWidget extends StatelessWidget {
  final userWaterData, controller;
  const BodyWaterWidget(
      {Key? key, required this.userWaterData, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final userWater = userWaterData["cups"] ?? 0;
      final totalUserWater = userWaterData["total_cups"] == null ||
              userWaterData["total_cups"] == 0
          ? 0.0
          : double.parse(userWaterData["total_cups"].toString());
      final inFood = double.parse(totalUserWater.toString()) -
          double.parse(userWater.toString());
      const maxWater = 14.0;
      return FractionallySizedBox(
        widthFactor: 0.49,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
          child: Container(
            width: double.infinity,
            height: 210.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFd7d7d7),
                    blurRadius: 15,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: -4,
                    offset: const Offset(0.0, 2.0)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "آب",
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 90.sp,
                  child: WidgetMask(
                    blendMode: BlendMode.srcATop,
                    childSaveLayer: true,
                    mask: WaveWidget(
                      config: CustomConfig(
                        colors: totalUserWater > maxWater
                            ? [
                                const Color(0xFFDE1A48).withOpacity(0.5),
                                const Color(0xFFCE355A),
                              ]
                            : [
                                const Color(0xFF00BBF9).withOpacity(0.5),
                                const Color(0xFF00BBF9),
                              ],
                        durations: [
                          4500,
                          4000,
                        ],
                        heightPercentages: [
                          (1 -
                              ((((totalUserWater + 0.3) * 100) / maxWater) /
                                  100)),
                          (1 - (((totalUserWater * 100) / maxWater) / 100)),
                        ],
                        blur: const MaskFilter.blur(BlurStyle.normal, 0.5),
                      ),
                      backgroundColor: Colors.transparent,
                      size: const Size(double.infinity, double.infinity),
                      waveAmplitude: 1.0,
                    ),
                    child: Center(
                      child: Image.asset("assets/images/water-glass2.png"),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setBodyWater(
                            groupID: 1, count: userWater + 1);
                      },
                      child: SizedBox(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.grey.shade500,
                        ),
                        width: 30.sp,
                        height: 35.sp,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                      child: Text(
                        "${userWater.ceil()}".toPersianDigit(),
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1, fontSize: 20.sp),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (userWater > 0) {
                          controller.setBodyWater(
                              groupID: 1, count: userWater - 1);
                        }
                      },
                      child: SizedBox(
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade500,
                        ),
                        width: 30,
                        height: 35,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Constants.shadeColor,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: FittedBox(
                    child: Text(
                      "دریافتی از غذا (${inFood.toStringAsFixed(1)}${"لیوان"})"
                          .toPersianDigit(),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
