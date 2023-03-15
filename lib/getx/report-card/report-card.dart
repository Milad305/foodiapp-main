import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/person-selector.dart';
import 'package:salamatiman/model/weeks/weeks-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/report-card/report-card.dart';
import 'package:salamatiman/utils/get-date.dart';

import '../../service/base.dart';

class ReportCardApple extends GetxController {
  RxBool loading = false.obs;
  RxList calorieReport = [].obs;
  RxList getDayAverage = [].obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCalorieReport();
  }

  getCalorieReport() async {
    var date = Get.find<PersonSelector>().date.value == ""
        ? GetDate.todayOnlyDate()
        : GetDate.toDate(Get.find<PersonSelector>().date.value.toString());
    date = date.toString().split(" ")[0].toString();
    loading(true);
    try {
      var res = await ReportCard.getCalorieReportByDate(date: date);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        calorieReport([]);
        calorieReport.add(json);
        await getPfcDayAverage();
      }
    } catch (e) {
      print(e);
    }
    loading(false);
  }

  getPfcDayAverage() async {
    var date = Get.find<PersonSelector>().date.value == ""
        ? GetDate.todayOnlyDate()
        : GetDate.toDate(Get.find<PersonSelector>().date.value.toString());
    date = date.toString().split(" ")[0].toString();
    getDayAverage([]);
    loading(true);
    try {
      var res = await ReportCard.getPfcDayAverage(date: date);

      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        getDayAverage.add(json);
      }
    } catch (e) {
      print(e);
    }
    loading(false);
  }
}

class ReportCardHomePageGetter extends GetxController {
  RxList chartPointsHome = [].obs;
  RxBool loading = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var data = {"bid": 1, "unit": "kg", "weeks": "1"};
    await getChartPoints(data: data);
  }

  getChartPoints({data}) async {
    final bid = data["bid"];
    final unit = data["unit"];
    final weeks = data["weeks"];
    loading.value = true;
    chartPointsHome([]);
    try {
      var res =
          await ReportCard.getChartPoints(bid: bid, unit: unit, weeks: weeks);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        chartPointsHome.add(json);
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }
}

class ReportCardGetter extends GetxController {
  RxString ItemActive = "-1".obs;
  RxList<Map<String, dynamic>> PfcCalorieFake = [
    {
      GetDate.todayOnlyDate().toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      },
      GetDate.decrement(1).toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      },
      GetDate.decrement(2).toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      },
      GetDate.decrement(3).toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      },
      GetDate.decrement(4).toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      },
      GetDate.decrement(5).toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      },
      GetDate.decrement(6).toString().toPersianDate(): {
        "protein": 0,
        "carbohydrate": 0,
        "fat": 0,
        "calories": 0
      }
    }
  ].obs;
  RxInt biometricSelected = 0.obs;
  RxInt weekSelected = 0.obs;
  RxInt weekNutrientReportsSelected = 0.obs;
  RxInt unitSelected = 0.obs;

  RxBool loading = false.obs;
  RxList chartPoints = [].obs;
  RxList PfcCalorie = [].obs;
  RxList chartCalorie = [].obs;

  RxList nutrientScores = [].obs;
  RxList weeksAverage = [].obs;
  RxList calorieReport = [].obs;
  RxList nutrientsWeeksAverage = [].obs;

  RxInt pageView1 = 0.obs;

  RxInt tabInit = 0.obs;

  RxList<BiometricUnitModel> unit = <BiometricUnitModel>[].obs;

  //{dates: [1401/04/28, 1401/04/29, 1401/04/30, 1401/04/31, 1401/05/01, 1401/05/02, 1401/05/03], values: [65, 65, 65, 108, 81, 100, 100]}

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var data = {"bid": 1, "unit": "kg", "weeks": "1"};

    await getChartPoints(data: data);

    // not await
    getNutrientScores();
  }

  getChartPoints({data}) async {
    final bid = data["bid"];
    final unit = data["unit"];
    final weeks = data["weeks"];
    loading.value = true;
    chartPoints([]);
    try {
      var res =
          await ReportCard.getChartPoints(bid: bid, unit: unit, weeks: weeks);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        chartPoints.add(json);
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
    update();
  }

  getPfcChartPoints({weeks}) async {
    PfcCalorie.value = [];
    try {
      var res = await ReportCard.getPfcChartPoints(weeks: weeks);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        PfcCalorie.add(json);
      }
    } catch (e) {
      print(e);
    }
    update();
  }

  getCalorieChartPoints({weeks}) async {
    chartCalorie.value = [];
    try {
      var res = await ReportCard.getCalorieChartPoints(weeks: weeks);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        chartCalorie.add(json);
      }
    } catch (e) {
      print(e);
    }
  }

  getNutrientScores([week]) async {
    final userWeek = week == null
        ? 1
        : week == 0
            ? 1
            : week;

    await getPfcChartPoints(weeks: userWeek);

    final token = GetStorage().read('UserToken');
    nutrientScores.value = [];
    nutrientsWeeksAverage.value = [];
    weeksAverage.value = [];
    calorieReport.value = [];
    Future.wait([
      //api 1
      BaseService.post(
        path: 'target/GetNutrientScoresLight',
        hasHeader: true,
        body: {"token": token, "weeks": userWeek},
      ).then((value) {
        if (value is Success) {
          var json = jsonDecode(value.response.toString());
          nutrientScores.add(json);
          update();
        }
      }),
      //api 2
      BaseService.post(
        path: 'target/get_nutrients_daily_average',
        hasHeader: true,
        body: {
          "token": token,
          "weeks": userWeek,
          "mode": "all",
          "groupby": "category",
        },
      ).then((value) {
        if (value is Success) {
          var json = jsonDecode(value.response.toString());
          nutrientsWeeksAverage.add(json);
          update();
        }
      }),
      //api 3
      BaseService.post(
        path: 'target/get_pfc_daily_average',
        hasHeader: true,
        body: {
          "token": token,
          "weeks": userWeek,
          "mode": "all",
        },
        loading: false,
      ).then((value) {
        if (value is Success) {
          var json = jsonDecode(value.response.toString());
          weeksAverage.add(json);
          update();
        }
      }),
      //api 4
      BaseService.post(
        path: 'report/GetCalorieReport',
        hasHeader: true,
        body: {
          "token": token,
          "weeks": userWeek,
          "mode": "all",
        },
        loading: false,
      ).then((value) {
        if (value is Success) {
          var json = jsonDecode(value.response.toString());
          calorieReport.add(json);
          update();
        }
      }),
    ]);
  }

  getPfcWeeksAverage([week]) async {
    weeksAverage([]);
    loading(true);
    final userWeek = week != null
        ? week
        : weekNutrientReportsSelected == 0
            ? 1
            : weekNutrientReportsSelected;
    try {
      var res = await ReportCard.getPfcWeeksAverage(weeks: userWeek);

      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        weeksAverage.add(json);
      }
    } catch (e) {
      print(e);
    }
    loading(false);
    update();
  }

  getCalorieReport([week]) async {
    loading(true);
    final userWeek = week != null
        ? week
        : weekNutrientReportsSelected == 0
            ? 1
            : weekNutrientReportsSelected;
    try {
      var res = await ReportCard.getCalorieReport(weeks: userWeek);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        calorieReport([]);
        calorieReport.add(json);
      }
    } catch (e) {
      print(e);
    }
    loading(false);
    update();
  }

  getNutrientsWeeksAverage([week]) async {
    nutrientsWeeksAverage.value = [];
    final userWeek = week != null
        ? week
        : weekNutrientReportsSelected == 0
            ? 1
            : weekNutrientReportsSelected;
    loading(true);
    try {
      var res = await ReportCard.getNutrientsWeeksAverage(weeks: userWeek);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        nutrientsWeeksAverage.add(json);
      }
    } catch (e) {
      print(e);
    }
    loading(false);
    update();
  }
}
