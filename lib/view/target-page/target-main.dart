import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/main/app_main.dart';
import 'package:salamatiman/view/target-page/select-target-type.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TargetMain extends GetView<PersonTargetGeter> {
  TargetMain({Key? key}) : super(key: key) {
    Get.lazyPut(() => PersonTargetGeter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserTarget(["days", 10]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => AppMain());
        Get.to(() => AppMain());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          surfaceTintColor: Constants.primaryColor,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Get.to(() => AppMain()),
            child: Icon(Icons.close),
          ),
        ),
        body: Center(
          child: Obx(() {
            final loading = controller.myTargetLoading.value;
            if (loading) {
              return Center(
                child: SpinKitThreeBounce(
                  color: Colors.black45,
                  size: 17.sp,
                ),
              );
            }
            if (controller.myTarget.isEmpty) {
              return Container();
            }

            var myTargetValues;
            final List<ChartData> chartData = [];
            if (controller.myTarget.isNotEmpty) {
              myTargetValues = controller.myTarget[0]["values"];

              if (myTargetValues.isNotEmpty) {
                myTargetValues.keys
                    .map(
                      (e) => chartData.add(ChartData(e.toString(),
                          double.parse(myTargetValues[e].toString()))),
                    )
                    .toList();
              }
            }
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height/30),
                    Align(alignment: Alignment.centerRight,
                      child: Padding(
                        padding:  EdgeInsets.only(right: Get.width/10),
                        child: Text("نمودار وزن شما",style: TextStyle(fontSize: 15.sp),),
                      )),
                      SizedBox(height: Get.height/50),

                    if (controller.myTarget.isNotEmpty) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: Get.width/1.2,
                              height: Get.height/3,
                              decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadowColor,blurRadius: 10,offset: const Offset(3,10))]
                              ),
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    labelRotation: -45,
                                    tickPosition: TickPosition.inside,
                                    majorTickLines:
                                        const MajorTickLines(color: Colors.transparent),
                                    placeLabelsNearAxisLine: true,
                                    labelPlacement: LabelPlacement.onTicks,
                                    labelStyle: TextStyle(
                                        fontFamily:
                                            Constants.primaryFontFamilyAdad),
                                  
                                    //autoScrollingDelta: 2,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    majorTickLines:
                                        MajorTickLines(color: Colors.transparent),
                                    labelStyle: TextStyle(
                                        fontFamily:
                                            Constants.primaryFontFamilyAdad),
                                    anchorRangeToVisiblePoints: true,
                                    //autoScrollingMode: AutoScrollingMode.end,
                                  ),
                                  series: <ChartSeries<ChartData, String>>[
                                    SplineSeries<ChartData, String>(
                                        color: Colors.red,
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) {
                                          final date =
                                              data.x.toString().split("-");
                                          final thisDate =
                                              date[1] + "/" + date[2];
                                          return thisDate
                                              .toString()
                                              .toPersianDigit();
                                        },
                                        yValueMapper: (ChartData data, _) =>
                                            data.y),
                                    ScatterSeries<ChartData, String>(
                                      color: Colors.red,
                                      borderColor: Colors.red,
                                      borderWidth: 3,
                                      dataSource: chartData,
                                      xValueMapper: (ChartData data, _) {
                                        final date = data.x.toString().split("-");
                                        final thisDate = date[1] + "/" + date[2];
                                        return thisDate
                                            .toString()
                                            .toPersianDigit();
                                      },
                                      yValueMapper: (ChartData data, _) => data.y,
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.sp),
                    ],
                    SelectTargetType()
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
