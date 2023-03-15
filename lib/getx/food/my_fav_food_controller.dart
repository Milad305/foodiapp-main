import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/food/food-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/dio_service.dart';
import 'package:salamatiman/service/foods/foods.dart';

import '../../utils/constants.dart';

class MyFavFoodController extends GetxController {
  RxList<FoodModel> favFoodList = RxList();
  int id = Constants.userInfo["id"];

  getMyFavFoods() async {
    try {
      var res = await Foods.getMyFavFoods();
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        favFoodList.clear();
        json.map((e) => favFoodList.add(FoodModel.fromJson(e))).toList();
      } else {
        favFoodList.value = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getMyFavFoods222() async {
    favFoodList.clear();
    var response = await DioService().getMethod(
        "https://salamatiman.ir/api/pub/calculate/getFavoriteFoods?user_id=${id}");
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        favFoodList.add(FoodModel.fromJson(element));
      });
    }
  }
}
