import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/base.dart';
import 'package:salamatiman/utils/constants.dart';

class TargetService extends BaseService {
  static setUserField({required value, required field, bool? loading}) async {
    var token = await GetStorage().read('UserToken');
    var myLoading = false;
    if (loading != null) {
      myLoading = loading;
    }
    var res = await BaseService.post(
        path: 'target/updateWeights',
        hasHeader: true,
        body: {"token": token, field: value},
        loading: myLoading);
    var userNewInfo = await BaseService.post(
        path: "user/get_userinfo_by_mobile",
        loading: true,
        body: {"mobile": Constants.userInfo["mobile"]});
    if (userNewInfo is Success) {
      var json = jsonDecode(userNewInfo.response.toString());
      GetStorage().write('UserToken', json["token"]);
      GetStorage().write('UserInfo', json);
    }
    return res;
  }

  static setUserTarget({required data}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: 'target/updateWeights',
        hasHeader: true,
        body: {
          "token": token,
          "weight": data["weight"],
          "weight_target": data["weight_target"],
          "weight_per_week": data["weight_per_week"],
          "weight_target_mode": data["weight_target_mode"],
        },
        loading: true);
    return res;
  }

  static getUserTarget({required data}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: 'report/getWeightChartInfo',
        hasHeader: true,
        body: {
          "token": token,
          data[0]: data[1],
        },
        loading: false);
    return res;
  }

  static saveWalkingTarget({required target}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: 'exercise/saveWalkingTarget',
        hasHeader: true,
        body: {
          "token": token,
          "target": target,
        },
        loading: true);
    return res;
  }

  static UpdateDailyWalkingRecord({required steps}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: 'exercise/UpdateDailyWalkingRecord',
        hasHeader: true,
        body: {
          "token": token,
          "steps": steps,
        },
        loading: true);
    return res;
  }

  static getWalkingInfo() async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: 'exercise/getWalkingInfo',
        hasHeader: true,
        body: {
          "token": token,
        },
        loading: true);
    return res;
  }
}
