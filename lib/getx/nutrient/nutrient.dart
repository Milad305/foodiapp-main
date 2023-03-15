import 'dart:convert';

import 'package:get/get.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/nutrient/nutrient.dart';

class NutrientGetter extends GetxController {
  RxList nutrient = [].obs;
  RxBool loading = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getNotrient(date: date, groupID: groupID);
  }

  void onDispose() {}

  getNotrient({date, groupID}) async {
    loading(true);
    nutrient([]);
    var res = await NotrientService.getNotrient(date: date, gid: groupID);
    if (res is Success) {
      loading(false);
      var json = jsonDecode(
          res.response.toString())["target/get_nutrients_daily_average"];
      if (json != null) {
        json.keys.map((itemKey) => nutrient.add(json[itemKey])).toList();
      }
    }
    update();
  }
}
