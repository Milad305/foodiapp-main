import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class ReportCard extends BaseService {
  static getChartPoints({required bid, required unit, required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'biometric/getChartPoints',
      hasHeader: true,
      body: {
        "token": token,
        "bid": bid,
        "unit": unit,
        "weeks": weeks,
        "mode": "none_empty"
      },
      loading: false,
    );
    return res;
  }

  static getPfcChartPoints({required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'report/getPfcChartPoints',
      hasHeader: true,
      body: {"token": token, "weeks": weeks, "mode": "none_empty"},
      loading: false,
    );
    return res;
  }

  static getCalorieChartPoints({required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'report/getCalorieChartPoints',
      hasHeader: true,
      body: {"token": token, "weeks": weeks},
      loading: false,
    );
    return res;
  }

  static getNutrientScores({required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'target/GetNutrientScoresLight',
      hasHeader: true,
      body: {"token": token, "weeks": weeks},
      loading: false,
    );
    return res;
  }

  static getPfcWeeksAverage({required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'target/get_pfc_daily_average',
      hasHeader: true,
      body: {
        "token": token,
        "weeks": weeks,
        "mode": "all",
      },
      loading: false,
    );
    return res;
  }

  static getPfcDayAverage({required date}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'target/get_pfc_daily_average',
      hasHeader: true,
      body: {
        "token": token,
        "date": date,
        "mode": "all",
      },
      loading: false,
    );
    return res;
  }

  static getCalorieReport({required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'report/GetCalorieReport',
      hasHeader: true,
      body: {
        "token": token,
        "weeks": weeks,
        "mode": "all",
      },
      loading: false,
    );
    return res;
  }

  static getCalorieReportByDate({required date}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'report/GetCalorieReport',
      hasHeader: true,
      body: {
        "token": token,
        "date": date,
        "mode": "all",
      },
      loading: false,
    );
    return res;
  }

  static getNutrientsWeeksAverage({required weeks}) async {
    final token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'target/get_nutrients_daily_average',
      hasHeader: true,
      body: {
        "token": token,
        "weeks": weeks,
        "mode": "all",
        "groupby": "category",
      },
      loading: false,
    );
    return res;
  }
}
