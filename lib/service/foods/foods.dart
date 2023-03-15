import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class Foods extends BaseService {
  static getFoods() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/list",
        body: {"token": token},
        loading: false,
        hasToken: true,
        hasHeader: true);
  }

  static getPackages({required gid}) async {
    var token = await GetStorage().read('UserToken');
    print({"token": token, "gid": gid});
    return await BaseService.post(
        path: "user/packages",
        body: {"token": token, "gid": gid},
        loading: false,
        hasToken: true,
        hasHeader: true);
  }

  static getMyFavFoods() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "favorites/getFoods",
        body: {"token": token},
        loading: false,
        hasToken: true,
        hasHeader: true);
  }

  static setFoodFromYesterday({required date, required gid}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "record/copy_from_yesterday",
        body: {"token": token, "date": date, "gids": gid},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static getTopNutrients({required date, required gid}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "target/get_top_nutrients",
        body: {"token": token, "date": date, "gids": gid, "mode": "all"},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static getNutrients({required date, required gids}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "target/get_nutrients_daily_average",
        body: {"token": token, "date": date, "gids": gids, "mode": "all"},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static getFavoritesFoods() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "target/get_top_nutrients",
        body: {"token": token},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static getFoodsBySearch({required text}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/list",
        body: {"token": token, "search": text.toString()},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static deleteFood({required foodId}) async {
    List ids = [];
    if (foodId is int) {
      ids.add(foodId);
    } else {
      ids = foodId;
    }
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "record/deleteByIds",
        body: {"token": token, "rids": ids},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }

  static addFoodToFavorite({required foodId}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "favorites/toggleFood",
        body: {"token": token, "fid": foodId},
        loading: false,
        hasToken: true,
        hasHeader: true);
  }

  static getCategorys() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/categories_with_foods",
        body: {"token": token},
        loading: false,
        hasToken: true,
        hasHeader: true);
  }

  static getCategorysNoFoods() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/categories_with_foods",
        body: {"token": token},
        loading: false,
        hasToken: true,
        hasHeader: true,
        timeOut: 20);
  }

  static getFoodStats([date]) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "record/getFoodStats",
        body: {"token": token, "date": "$date"},
        loading: false,
        hasToken: true,
        hasHeader: true,
        timeOut: 20);
  }

  static getRecord(date, group) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "food/records",
        body: (group < 0)
            ? {"token": token, "mode": "all", "date": "$date"}
            : {
                "token": token,
                "mode": "all",
                "date": "$date",
                "group": group.toString()
              },
        /*loading: (group < 0) ? false : true,*/
        loading: false,
        hasToken: true,
        hasHeader: true,
        timeOut: 20);
  }

  static addFoodRecord({required data}) async {
    var token = await GetStorage().read('UserToken');
    var myData = jsonDecode(data);
    var body = {
      "token": token.toString(),
      "portion_id": myData["portion_id"],
      "count": myData["count"],
      "app_time": myData["app_time"],
      "group": myData["group"],
      "food_id": myData["food_id"]
    };
    var res = await BaseService.post(
        path: "food/addRecord",
        body: body,
        loading: true,
        hasToken: true,
        hasHeader: true);
    return res;
  }
}
