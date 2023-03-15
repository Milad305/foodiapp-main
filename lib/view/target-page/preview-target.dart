import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/target-page/target-main.dart';
import 'package:salamatiman/widgets/fl_animated_linechart/chart/line_chart.dart';

//import 'chart_series.dart';

class PreviewTarget extends GetView<PersonTargetGeter> {
  PreviewTarget({Key? key}) : super(key: key) {
    Get.put(PersonTargetGeter());
  }

  @override
  Widget build(BuildContext context) {
    final myWeight = controller.weight.value;
    final myTargetWeight = controller.targetWeight.value;
    final myTargetType = controller.targetType.value;
    final myObesitySlimmingSelected = controller.obesitySlimmingSelected.value;
    final myObesitySlimmingSelectedType =
        controller.obesitySlimmingSelectedType[myObesitySlimmingSelected];

    final finalMyWeight = myTargetWeight > myWeight
        ? myTargetWeight - myWeight
        : myWeight - myTargetWeight;

    final myWeek = (finalMyWeight / myObesitySlimmingSelectedType).toInt();
    //////////////////////////

    Map<DateTime, double> createLineAlmostSaveValues() {
      Map<DateTime, double> data = {};
      if (controller.targetWeightType == 1) {
        data[DateTime.now().subtract(Duration(days: -1))] =
            double.parse((myObesitySlimmingSelectedType).toString());

        data[DateTime.now().subtract(Duration(days: -2))] =
            double.parse((myObesitySlimmingSelectedType * 2).toString());

        data[DateTime.now().subtract(Duration(days: -3))] =
            double.parse((myObesitySlimmingSelectedType * 3).toString());

        data[DateTime.now().subtract(Duration(days: -4))] =
            double.parse((myObesitySlimmingSelectedType * 4).toString());

        data[DateTime.now().subtract(Duration(days: -5))] =
            double.parse((myObesitySlimmingSelectedType * 5).toString());

        data[DateTime.now().subtract(Duration(days: -6))] =
            double.parse((myObesitySlimmingSelectedType * 6).toString());

        data[DateTime.now().subtract(Duration(days: -7))] =
            double.parse((myObesitySlimmingSelectedType * 7).toString());
      } else {
        data[DateTime.now().subtract(Duration(days: -1))] =
            double.parse((myObesitySlimmingSelectedType * 7).toString());

        data[DateTime.now().subtract(Duration(days: -2))] =
            double.parse((myObesitySlimmingSelectedType * 6).toString());

        data[DateTime.now().subtract(Duration(days: -3))] =
            double.parse((myObesitySlimmingSelectedType * 5).toString());

        data[DateTime.now().subtract(Duration(days: -4))] =
            double.parse((myObesitySlimmingSelectedType * 4).toString());

        data[DateTime.now().subtract(Duration(days: -5))] =
            double.parse((myObesitySlimmingSelectedType * 3).toString());

        data[DateTime.now().subtract(Duration(days: -6))] =
            double.parse((myObesitySlimmingSelectedType * 2).toString());

        data[DateTime.now().subtract(Duration(days: -7))] =
            double.parse((myObesitySlimmingSelectedType).toString());
      }

      return data;
    }

    LineChart chart;
    chart = LineChart.fromDateTimeMaps(
        [createLineAlmostSaveValues()], [Colors.green], [''],
        tapTextFontWeight: FontWeight.w400);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        leading: IconButton(
          onPressed: () {
            controller.targetType.value = 0;
            Get.offAll(PreviewTarget());
            Get.to(() => TargetMain());
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
                 height: Get.height/2,
                      width: Get.width/1,
               child: Center(
                 child: Stack(children: [
                   Image.asset("assets/images/dialog.png",width: Get.width,),
                       Positioned(
                        top: Get.height/5,
                        right: Get.width/4,
                         child: Center(
                           child: SizedBox(
                            height: Get.height/7,
                            width: Get.width/2,
                             child: Text.rich(TextSpan(
                                           text: "وزن فعلی من ",
                                           style: TextStyle(fontSize: 15.sp),
                                           children: [
                              const TextSpan(text: " "),
                              TextSpan(
                                  text: "${myWeight.toString().toPersianDigit()}",
                                  style: TextStyle(
                                      color: Constants.secondaryColor, fontSize: 15.sp)),
                              const TextSpan(text: " "),
                              const TextSpan(text: "و وزن هدف من"),
                              const TextSpan(text: " "),
                              TextSpan(
                                  text: "${myTargetWeight.toString().toPersianDigit()}",
                                  style: TextStyle(
                                      color: Constants.secondaryColor, fontSize: 15.sp)),
                              const TextSpan(text: " "),
                              const TextSpan(text: "و در عرض"),
                              const TextSpan(text: " "),
                              TextSpan(
                                  text: "${myWeek.toString().toPersianDigit()}",
                                  style: TextStyle(
                                      color: Constants.secondaryColor, fontSize: 15.sp)),
                              const TextSpan(text: " "),
                              const TextSpan(text: "هفته به هدف خودم خواهم رسید"),
                                           ],
                                         )),
                           ),
                         ),
                       ),

                 ],),
               ),
             ),
            GestureDetector(
              onTap: () {
                controller.targetType.value = 0;
                Get.offAll(PreviewTarget());
                
                Get.to(() => TargetMain());
              },
              child: Container(
                width: Get.width * .25,
                      height: Get.height/17,
             
                    decoration:  BoxDecoration(
                      gradient: const LinearGradient(colors: Constants.primarygradiant,
                      end: Alignment.bottomCenter,begin: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(16)
                      ),

            
                alignment: Alignment.center,
                child: Text(
                  "ذخیره",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = const Color.fromARGB(255, 226, 19, 64);
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.square;

    Paint paintRound = Paint();
    paintRound.color = Colors.blue;
    paintRound.strokeWidth = 10;
    paintRound.strokeCap = StrokeCap.round;

    Offset startingOffset = Offset(0, size.height);
    Offset endingOffset = Offset(size.width, 0);

    canvas.drawLine(startingOffset, endingOffset, paint);
    canvas.drawLine(
        Offset(size.width, 100), Offset(size.width, 100), paintRound);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 100), paint);
    canvas.drawLine(Offset(0, 0), Offset(size.width, 100), paint);
    canvas.drawLine(startingOffset, Offset(size.width, 70), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Circle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.fill;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;

    Offset offset = Offset(size.width * 0.5, size.height);
    canvas.drawCircle(offset, 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
