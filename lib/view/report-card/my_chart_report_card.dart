import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/report-card/report-card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChartReportCard extends StatelessWidget {
  final chartData;
  const MyChartReportCard({Key? key, required this.chartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        enableMultiSelection: false,
        primaryXAxis: CategoryAxis(
          
          labelRotation: -45,
          tickPosition: TickPosition.inside,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Constants.appleLowColor),
          placeLabelsNearAxisLine: false,
          labelPlacement: LabelPlacement.onTicks,
          labelStyle: TextStyle(fontFamily: Constants.primaryFontFamilyAdad),
          //autoScrollingDelta: 2,
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent),
          labelStyle: TextStyle(
              fontFamily: Constants.primaryFontFamilyAdad, fontSize: 13.sp),
          anchorRangeToVisiblePoints: false,
          isVisible: true,
          //autoScrollingMode: AutoScrollingMode.end,
        ),
        series: <ChartSeries<ChartData, String>>[
          SplineSeries<ChartData, String>(
              color: Constants.appleLowColor,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y),
          ScatterSeries<ChartData, String>(
            color: Constants.appleLowColor,
            borderColor: Constants.appleLowColor,
            borderWidth: 3,
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle:
                    TextStyle(fontFamily: Constants.primaryFontFamilyAdad)),
          ),
        ]);
  }
}
