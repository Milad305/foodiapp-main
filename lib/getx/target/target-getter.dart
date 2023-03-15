import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/auth.dart';
import 'package:salamatiman/service/target/target-service.dart';
import '../home/home-getter.dart';


class PersonTargetGeter extends GetxController {
    TextEditingController myTargetWeight = TextEditingController();

  RxInt targetType = 0.obs;
  RxInt targetWeightType = 0.obs;
  RxDouble weight = 1.0.obs;
  RxDouble targetWeight = 1.0.obs;
  RxInt obesitySlimmingSelected = 0.obs;
  List obesitySlimmingSelectedType = [0.2, 0.5, 0.7, 0.9];
  RxList myTarget = [].obs;
  RxBool myTargetLoading = true.obs;
  RxDouble myWeight =
      double.parse(GetStorage().read('UserInfo')["weight"].toString()).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserTarget(["days", 10]);
  }

  getUserTarget(data) async {
    myTarget.value = [];
    myTargetLoading(true);
    try {
      var res = await TargetService.getUserTarget(data: data);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        myTarget.add(json);
      }
    } catch (e) {
      print(e);
    }
    myTargetLoading(false);
    update();
  }

  setUserTarget() async {
    var weight_target_mode = "reduce";
    if (targetWeightType.value == 1) {
      weight_target_mode = "increase";
    } else if (targetWeightType.value == 2) {
      weight_target_mode = "reduce";
    } else {
      weight_target_mode = "fixed";
    }
    var data = {
      "weight": weight.value,
      "weight_target": targetWeight.value,
      "weight_target_mode": weight_target_mode,
      "weight_per_week":
          obesitySlimmingSelectedType[obesitySlimmingSelected.value]
    };

    var res = await TargetService.setUserTarget(data: data);
    if (res is Success) {
      getUserTarget(["days", 10]);
      Get.find<HomeGetter>()
          .getAllApi(Get.find<HomeGetter>().dateSelected.value);
    }
    if (res is Failure) {
      Fluttertoast.showToast(msg: "خطا در ذخیره سازی");

    }
  }

  me() async {
    var res = await AuthUser.me();
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      await GetStorage().write('UserToken', json["token"]);
      await GetStorage().write('UserInfo', json);
      myWeight.value =
          double.parse(GetStorage().read('UserInfo')["weight"].toString());
      update();
    }
  }
}


