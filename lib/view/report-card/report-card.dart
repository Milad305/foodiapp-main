import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart' as prefix;
import 'package:pie_chart/src/legend_options.dart';
import 'package:salamatiman/getx/biometric/biometric.dart';
import 'package:salamatiman/getx/report-card/food_gruops_controller.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/model/biometric-model.dart';
import 'package:salamatiman/model/weeks/weeks-model.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/primary_handler.dart';
import 'package:salamatiman/view/report-card/my_chart_report_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'report-food-goals.dart';
import 'report-vitamins.dart';
import 'report-weeks-average.dart';

class ReportCard extends GetView<ReportCardGetter> {
  var BiometricController;
  TabController? _controller;
  ReportCard({Key? key}) : super(key: key) {
    Get.put(ReportCardGetter());
    BiometricController = Get.put(BiometricGetter());
    _controller?.addListener(_handleTabSelection);
  }

  List<WeeksModel>? weeks = <WeeksModel>[];
  List<BiometricModel> biometric = <BiometricModel>[];
  List<BiometricUnitModel> unit = <BiometricUnitModel>[];
  FoodGroupsController foodGroupsController = Get.put(FoodGroupsController());
  int week = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Text(""),
        title: Text(
          "کارنامه من",
          style: TextStyle(fontSize: 19.sp, color: Constants.secondaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Constants.primaryColor,
        toolbarHeight: 90,
      ),
      body: SafeArea(
        child: Obx(() {
          biometric = BiometricController.biometricList;

          //weeks
          if (weeks!.isEmpty) {
            Constants.ListWeeks.map((e) =>
                    weeks!.add(WeeksModel(id: e["id"], title: e["title"])))
                .toList();
          }

          //unit
          if (biometric.isNotEmpty) {
            unit = [];
            final biometricSelected =
                biometric[controller.biometricSelected.value];
            final unitExtraction = biometricSelected.unit.toString().split("|");
            unitExtraction
                .map((e) => {
                      unit.add(BiometricUnitModel(
                          id: unitExtraction.indexOf(e), title: e))
                    })
                .toList();
          }

          if (biometric.isNotEmpty && controller.loading.value == false) {
            return DefaultTabController(
              initialIndex: controller.tabInit.value,
              length: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 60,
                  ),
                  TabBar(
                    onTap: (val) {
                      controller.tabInit(int.parse(val.toString()));
                    },
                    indicatorColor: Constants.secondaryColor,
                    labelPadding: EdgeInsets.all(0),
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                          colors: Constants.primarygradiant,
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      color: Constants.secondaryColor,
                      borderRadius: BorderRadius.circular(50.sp),
                    ),
                    unselectedLabelColor: Constants.secondaryColor,
                    labelColor: Colors.white,
                    splashFactory: NoSplash.splashFactory,
                    automaticIndicatorColorAdjustment: true,
                    isScrollable: true,
                    tabs: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: const Tab(
                          text: "نمودارها",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: const Tab(
                          text: "گزارشات مغذی‌ها",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: const Tab(
                          text: "اهداف غذایی",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.width / 60,
                  ),
                  Divider(
                    color: Constants.shadeColor,
                    indent: Get.width / 7,
                    endIndent: Get.width / 7,
                    thickness: 1,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 7),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                        "کالری  ",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                        width: Get.width * 0.50,
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: MyDropdownButton(
                                            items: weeks,
                                            thisController: controller
                                                .weekNutrientReportsSelected,
                                            id: "weekNutrientReportsSelected"),
                                      ),
                                    ],
                                  ),
                                ),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final PfcCalorie = controller
                                            .PfcCalorie.isNotEmpty
                                        ? controller.PfcCalorie[0].isNotEmpty
                                            ? controller.PfcCalorie
                                            : controller.PfcCalorieFake
                                        : controller.PfcCalorieFake;
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        width: PfcCalorie.length > 7
                                            ? double.parse(
                                                ((PfcCalorie[0].length) * 50)
                                                    .toString())
                                            : Get.width,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            List<ChartData> proteinChart = [];
                                            List<ChartData> carbohydrateChart =
                                                [];
                                            List<ChartData> fatChart = [];
                                            List<ChartData> caloriesChart = [];

                                            if (PfcCalorie.isNotEmpty) {
                                              List dates =
                                                  PfcCalorie[0].keys.toList();
                                              List valueProtein = [];
                                              List valueCarbohydrate = [];
                                              List valueFat = [];
                                              List valueCalories = [];

                                              for (int i = 0;
                                                  i < dates.length;
                                                  i++) {
                                                final item =
                                                    PfcCalorie[0][dates[i]];

                                                valueProtein
                                                    .add(item["protein"]);
                                                valueCarbohydrate
                                                    .add(item["carbohydrate"]);
                                                valueFat.add(item["fat"]);
                                                valueCalories
                                                    .add(item["calories"]);
                                              }

                                              //converter
                                              dates.map((e) {
                                                final dateToSplite =
                                                    e.toString().split("/");
                                                final myDate = dateToSplite[1]
                                                        .toString() +
                                                    "/" +
                                                    dateToSplite[2].toString();
                                                ////////
                                                // add Protein to chart
                                                proteinChart.add(ChartData(
                                                    myDate,
                                                    double.parse(valueProtein[
                                                            dates.indexOf(e)]
                                                        .toString())));

                                                // add Carbohydrate to chart
                                                carbohydrateChart.add(ChartData(
                                                    myDate,
                                                    double.parse(
                                                        valueCarbohydrate[dates
                                                                .indexOf(e)]
                                                            .toString())));

                                                // add Fat to chart
                                                fatChart.add(ChartData(
                                                    myDate,
                                                    double.parse(valueFat[
                                                            dates.indexOf(e)]
                                                        .toString())));
                                                // add calories to chart
                                                caloriesChart.add(ChartData(
                                                    myDate,
                                                    double.parse(valueCalories[
                                                            dates.indexOf(e)]
                                                        .toString())));

                                                ////////
                                              }).toList();

                                              return MyColumnChart(
                                                  protein: proteinChart,
                                                  carbohydrate:
                                                      carbohydrateChart,
                                                  fat: fatChart,
                                                  calories: caloriesChart);
                                            }

                                            return Container();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: Get.width / 50),
                                    child: Wrap(
                                      children: [
                                        Container(
                                          width: Get.width * 0.30,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: MyDropdownButton(
                                              items: biometric,
                                              thisController:
                                                  controller.biometricSelected,
                                              id: "biometric"),
                                        ),
                                        Container(
                                          width: Get.width * 0.3,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: MyDropdownButton(
                                              items: weeks,
                                              thisController:
                                                  controller.weekSelected,
                                              id: "weeks"),
                                        ),
                                        Container(
                                          width: Get.width * 0.3,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: MyDropdownButton(
                                              items: unit,
                                              thisController:
                                                  controller.unitSelected,
                                              id: "unit"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    final chartPoints = controller.chartPoints;
                                    if (chartPoints.isEmpty ||
                                        chartPoints[0].isEmpty) {
                                      return Container();
                                    }
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: Get.height / 60),
                                      child: Container(
                                        width: chartPoints[0].isEmpty
                                            ? Get.width
                                            : double.parse((((controller
                                                        .chartPoints[0]["dates"]
                                                        .length) *
                                                    55)
                                                .toString())),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            //MyChartReportCard({chartData})
                                            List<ChartData> chartData = [];
                                            if (controller
                                                .chartPoints.isNotEmpty) {
                                              chartData = [];
                                              List dates = controller
                                                  .chartPoints[0]["dates"];
                                              List values = controller
                                                  .chartPoints[0]["values"];
                                              dates.map((e) {
                                                final dateToSplite =
                                                    e.toString().split("/");
                                                final myDate = dateToSplite[1]
                                                        .toString() +
                                                    "/" +
                                                    dateToSplite[2].toString();
                                                chartData.add(ChartData(
                                                    myDate,
                                                    double.parse(
                                                        values[dates.indexOf(e)]
                                                            .toString())));
                                              }).toList();
                                              return MyChartReportCard(
                                                  chartData: chartData);
                                            }

                                            return Text("");
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                        //گزارشات مغذی ها
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 15, top: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "میانگین:",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      Container(
                                        width: Get.width * 0.50,
                                        alignment: Alignment.centerRight,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: MyDropdownButton(
                                            items: weeks,
                                            thisController: controller
                                                .weekNutrientReportsSelected,
                                            id: "weekNutrientReportsSelected"),
                                      ),
                                    ],
                                  ),
                                ),
                                WeeksAverage(
                                  weeksAverage: controller.weeksAverage,
                                ),
                              ],
                            ),
                          ),
                        ),

                        //اهداف غذایی
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "میانگین:",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      Container(
                                        width: Get.width * 0.50,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(
                                            right: Get.width / 17),
                                        child: MyDropdownButton(
                                            items: weeks,
                                            thisController: controller
                                                .weekNutrientReportsSelected,
                                            id: "weekNutrientReportsSelected"),
                                      ),
                                    ],
                                  ),
                                ),
                                if (controller.nutrientScores.isNotEmpty) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 0),
                                    child: PrimaryHandler(
                                      pageName: "health_scores",
                                      child: ReportFoodGoals(
                                        foodGoals: controller.nutrientScores,
                                      ),
                                    ),
                                  ),
                                  // Divider(
                                  //   color: Constants.shadeColor,
                                  //   indent: Get.width / 10,
                                  //   endIndent: Get.width / 10,
                                  //   thickness: 1,
                                  // ),
                                  Container(
                                    width: Get.width / 1.1,
                                    decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 5,
                                            offset: Offset(0, 5))
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: InkWell(
                                      onTap: () =>
                                          foodGroupsController.getFoodGroups(),
                                      child: Obx(
                                        () {
                                          final item = foodGroupsController
                                              .oneWeeksLater.value;
                                          return false
                                              ? Container(
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: 10.sp,
                                                      ),
                                                      Text(
                                                        "گروه های غذایی (واحد)",
                                                        style: TextStyle(
                                                            fontSize: 17.sp,
                                                            color: Constants
                                                                .textColor),
                                                      ),
                                                      Divider(
                                                        color: Constants
                                                            .shadeColor,
                                                        indent: Get.width / 5,
                                                        endIndent:
                                                            Get.width / 5,
                                                        thickness: 1,
                                                      ),
                                                      foodGroupsController
                                                                  .loading
                                                                  .value ==
                                                              true
                                                          ? PieChart(
                                                              dataMap: {
                                                                "گروه شیر و لبنیات" +
                                                                    "(" +
                                                                    item.foundations!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.foundations!.roundToDouble(),
                                                                "گروه میوه" +
                                                                    "(" +
                                                                    item.fruits!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.fruits!.roundToDouble(),
                                                                "گروه سبزیجات" +
                                                                    "(" +
                                                                    item.vegetables!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.vegetables!.roundToDouble(),
                                                                "گروه پرکالری" +
                                                                    "(" +
                                                                    item.highCallorie!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.highCallorie!.roundToDouble(),
                                                                "گروه غلات" +
                                                                    "(" +
                                                                    item.cereal!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.cereal!.roundToDouble(),
                                                                "گروه گوشت" +
                                                                    "(" +
                                                                    item.meat!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.meat!.roundToDouble(),
                                                                "گروه چربی" +
                                                                    "(" +
                                                                    item.fat!
                                                                        .roundToDouble()
                                                                        .toString()
                                                                        .toPersianDigit() +
                                                                    ")": item.fat!.roundToDouble(),
                                                              },
                                                              animationDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          800),
                                                              chartLegendSpacing:
                                                                  0,
                                                              chartRadius: 120,

                                                              initialAngleInDegree:
                                                                  0,
                                                              chartType:
                                                                  ChartType
                                                                      .disc,

                                                              centerTextStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          28.sp,
                                                                      color: Constants
                                                                          .textColor),
                                                              ringStrokeWidth:
                                                                  20,
                                                              legendOptions:
                                                                  const LegendOptions(
                                                                legendPosition:
                                                                    prefix
                                                                        .LegendPosition
                                                                        .left,
                                                                showLegends:
                                                                    true,
                                                              ),
                                                              chartValuesOptions:
                                                                  const ChartValuesOptions(
                                                                showChartValueBackground:
                                                                    false,
                                                                showChartValues:
                                                                    false,
                                                                showChartValuesInPercentage:
                                                                    false,
                                                                showChartValuesOutside:
                                                                    false,
                                                                decimalPlaces:
                                                                    1,
                                                              ),
                                                              // gradientList: ---To add gradient colors---
                                                              // emptyColorGradient: ---Empty Color gradient---
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                )
                                              : Container();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  child: PrimaryHandler(
                                    pageName: "all_nutrients",
                                    child: Obx(() {
                                      if (controller
                                          .nutrientsWeeksAverage.isNotEmpty) {
                                        return ReportVitamins();
                                      }
                                      return Container();
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SpinKitThreeBounce(
              color: Colors.black45,
              size: 17.sp,
            );
          }
        }),
      ),
    );
  }

  Widget MyDropdownButton(
      {required List? items, required thisController, required id}) {
    return DropdownButton2(
      isExpanded: true,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 5),
      buttonDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 0.0,
            blurRadius: 5.0,
            offset: const Offset(-5, 5),
          )
        ],
      ),
      buttonElevation: 0,
      underline: const SizedBox(
        height: 0,
      ),
      buttonHeight: 40,
      offset: const Offset(0, -45),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      dropdownElevation: 1,
      scrollbarAlwaysShow: true,
      dropdownFullScreen: false,
      dropdownOverButton: true,
      items: items!
          .map((item) => DropdownMenuItem<String>(
                value: (items.indexOf(item)).toString(),
                child: Text(
                  item.title.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: (items.indexOf(items[thisController.value])).toString(),
      onChanged: (val) {
        week = items[int.parse(val.toString())].id;
        foodGroupsController.week.value = week;
        foodGroupsController.getFoodGroups();
        if (id == "biometric") {
          controller.unitSelected.value = 0;
        }
        if (id != "weekNutrientReportsSelected") {
          thisController.value = int.parse(val.toString());
          if (biometric.isNotEmpty) {
            unit = [];
            final biometricSelected =
                biometric[controller.biometricSelected.value];
            final unitExtraction = biometricSelected.unit.toString().split("|");
            unitExtraction
                .map((e) => {
                      unit.add(BiometricUnitModel(
                          id: unitExtraction.indexOf(e), title: e))
                    })
                .toList();
          }
          var json = {
            "bid": biometric[controller.biometricSelected.value].id,
            "unit": unit[controller.unitSelected.value].title,
            "weeks": weeks![controller.weekSelected.value].id,
          };
          controller.getChartPoints(data: json);
        }
        if (id == "weekNutrientReportsSelected") {
          controller.weekNutrientReportsSelected.value =
              int.parse(val.toString());
          controller.getNutrientScores(week);
        }
      },
    );
  }

  Widget MyColumnChart(
      {required protein,
      required carbohydrate,
      required fat,
      required calories}) {
    return SfCartesianChart(
        backgroundColor: Colors.white,
        enableMultiSelection: true,
        primaryXAxis: CategoryAxis(
          axisLine: const AxisLine(color: Colors.transparent),
          labelRotation: -45,
          tickPosition: TickPosition.outside,
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          placeLabelsNearAxisLine: false,
          labelPlacement: LabelPlacement.betweenTicks,
          labelStyle: TextStyle(fontFamily: Constants.primaryFontFamilyAdad),
          isVisible: true,

          //autoScrollingDelta: 2,
        ),
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          labelStyle: TextStyle(
              fontFamily: Constants.primaryFontFamilyAdad, fontSize: 15.sp),
          anchorRangeToVisiblePoints: true,
          isVisible: false,
          autoScrollingMode: AutoScrollingMode.end,
        ),
        series: <ChartSeries<ChartData, String>>[
          StackedColumnSeries<ChartData, String>(
            dataSource: calories,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            width: .5,
            isTrackVisible: true,
            trackColor: Constants.textFieldBg,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
                topLeft: Radius.circular(100)),
            gradient: const LinearGradient(
                colors: Constants.chartGradiant,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            enableTooltip: true,
            dataLabelSettings: DataLabelSettings(
              angle: 270,
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.bottom,
              textStyle: TextStyle(
                fontFamily: Constants.primaryFontFamilyAdad,
                fontSize: 10.sp,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ]);
  }

  _handleTabSelection() {
    controller.tabInit(int.parse(_controller!.index.toString()));
  }
}

//columnChart
//ColumnChartClass

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
