import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';
import 'package:salamatiman/utils/constants.dart';

abstract class HomePageService extends BaseService {
  static getAllApis(myDate) async {
    var token = await GetStorage().read('UserToken');
    //"/api/v2/ads/app"
    var body = {
      'apis': [
        "/api/v2/common/config",
        "/api/v2/target/get_nutrients_daily_average",
        "/api/v2/target/get_pfc_daily_average",
        "/api/v2/report/GetCalorieReport",
        "/api/v2/report/getFirstPageStats",
        "/api/v2/record/getFoodStats",
        "/api/v2/food/getWater",
      ],
      'token': token,
      "mode": "all",
      "date": myDate.toString().split(" ")[0].toString()
    };
    return await BaseService.post(
        path: "common/get_together",
        body: body,
        loading: false,
        hasToken: true,
        hasHeader: true,
        timeOut: 20);
  }

  static getConfig() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "common/config",
        body: {'token': token},
        loading: true,
        hasToken: true);
  }

  static setBodyWater(
      {required count, required groupID, required String? datetime}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/saveWater",
        body: {
          'token': token,
          'count': count,
          "group": groupID,
          "datetime": datetime.toString(),
        },
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static getMacro({required String date}) async {
    return await BaseService.post(
        path: "target/get_pfc_daily_average",
        body: {'mode': 'all', 'date': date, 'token': Constants.userToken},
        loading: true,
        hasToken: true);
  }

  static getMicro({required String date}) async {
    return await BaseService.post(
        path: "target/get_nutrients_daily_average",
        body: {'mode': 'all', 'date': date, 'token': Constants.userToken},
        loading: true,
        hasToken: true);
  }

  static getCalories({required String date}) async {
    return await BaseService.post(
        path: "report/GetCalorieReport",
        body: {'mode': 'all', 'date': date, 'token': Constants.userToken},
        loading: true,
        hasToken: true);
  }
}
