import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/view/report-card/my_chart_report_card.dart';
import 'package:salamatiman/view/report-card/report-card.dart';

class HomeWeightChart extends GetView<ReportCardHomePageGetter> {
  HomeWeightChart({Key? key}) : super(key: key) {
    Get.lazyPut(() => ReportCardHomePageGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Get.put(ReportCardHomePageGetter());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        if (controller.chartPointsHome.isEmpty) {
          return const Text("");
        }
        return SizedBox(
          width: Get.width,
          height: 210,
          child: LayoutBuilder(
            builder: (context, constraints) {
              //MyChartReportCard({chartData})
              List<ChartData> chartData = [];
              if (controller.chartPointsHome.isNotEmpty) {
                chartData = [];
                List dates = controller.chartPointsHome[0]["dates"];
                List values = controller.chartPointsHome[0]["values"];
                dates.map((e) {
                  final dateToSplite = e.toString().split("/");
                  final myDate = dateToSplite[1].toString() +
                      "/" +
                      dateToSplite[2].toString();
                  chartData.add(ChartData(myDate,
                      double.parse(values[dates.indexOf(e)].toString())));
                }).toList();
                return MyChartReportCard(chartData: chartData);
              }

              return Text("");
            },
          ),
        );
      }),
    );
  }
}
