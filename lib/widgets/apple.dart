import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

class AppleWidget extends StatelessWidget {
  double size, maxSize;
  final text;
  AppleWidget(
      {Key? key, required this.size, required this.maxSize, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appleSize = Constants.appleSize;
    double appleSizeH = appleSize + (appleSize / 10);
    final userSize = double.parse(text);
    return Center(
      child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: size),
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return Container(
              width: appleSize,
              height: appleSize + (appleSize / 7),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/images/leaves.png',
                      width: 35,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                            startAngle: 3 * math.pi / 2,
                            endAngle: 7 * math.pi / 2,
                            tileMode: TileMode.repeated,
                            center: Alignment.center,
                            colors: [
                              maxSize > (userSize - 50)
                                  ? maxSize < (userSize + 50)
                                      ? Constants.appleFullColor
                                      : Constants.appleLowColor
                                  : maxSize > (userSize - 50)
                                      ? userSize < maxSize
                                          ? Constants.appleOverFlowColor
                                          : Constants.appleFullColor
                                      : Constants.appleOverFlowColor,
                              //empty
                              Constants.appleEmptyColor.withOpacity(0.3),
                            ],
                            stops: [value, value],
                          ).createShader(rect);
                        },
                        child: Container(
                          width: appleSize,
                          height: appleSize + 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.asset(
                                  "assets/images/apple.png",
                                  color: Constants.appleEmptyColor,
                                ).image,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: appleSizeH / 2.5,
                    child: Container(
                      width: 80,
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "کالری",
                              style: TextStyle(fontSize: 23.sp),
                            ),
                            Text(
                              text.toString().toPersianDigit(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 21),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
