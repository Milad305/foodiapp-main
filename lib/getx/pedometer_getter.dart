import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/auth.dart';
import 'package:salamatiman/service/target/target-service.dart';
import 'package:salamatiman/utils/get-date.dart';

class PedometerGetter extends GetxController {
  final String title = 'My Awesome View';
  RxInt myPedometer = 0.obs;
  RxInt myPedometerTarget = 6000.obs;
  RxBool pedometerActive = false.obs;
  RxString status = "stopped".obs;

  RxList getWalking = [].obs;

  RxInt dateNumber = 0.obs;

  RxInt walkUpdate = 0.obs;

  RxString userInfo = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (GetStorage().read('walkBgS') != null) {
      pedometerActive(GetStorage().read('walkBgS'));
    }
    getWalkingInfo();
  }

  getPedometerActive(res) {
    pedometerActive(res);
  }

  void updatemyPerdometer(val) {
    myPedometer.value = val;
    //GetStorage().write("myPedometerByDate", val);
    update();
  }

  void changeStatus(val) {
    status.value = val;
    update();
  }

  void changeActive(val) {
    pedometerActive.value = val;
    update();
  }

  changeDateNumber(value) {
    dateNumber.value = value;
    update();
  }

  saveWalkingTarget() async {
    var res =
        await TargetService.saveWalkingTarget(target: myPedometerTarget.value);
    if (res is Success) {
      Fluttertoast.showToast(msg: "هدف شما با موفقیت ذخیره شد");
      final user = await AuthUser.me();
      if (user is Success) {
        final json = jsonDecode(user.response.toString());
        GetStorage().write('UserInfo', json);
        GetStorage().write('UserToken', json["token"]);
        userInfo(user.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "خطا در ذخیره سازی هدف");
    }
  }

  getWalkingInfo() async {
    //if (getWalking.value.isEmpty) {
    try {
      var res = await TargetService.getWalkingInfo();
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        getWalking.add(json);
        update();
      }
    } catch (e) {
      print(e);
    }
    update();
  }
  //}

  UpdateDailyWalkingRecord() async {
    final today = GetDate.todayOnlyDate()
        .toString()
        .toPersianDate(digitType: NumStrLanguage.English);
    final todayConvert = today.toString().split("/");
    final todayConvertY = todayConvert[0];
    final todayConvertM = todayConvert[1].padLeft(2, '0');
    final todayConvertD = todayConvert[2].padLeft(2, '0');

    final finalDate = todayConvertY + "/" + todayConvertM + "/" + todayConvertD;

    int steps = 0;
    final pedometerCounterSlider = GetStorage().read('PedometerCounter');
    final phoneStorage = pedometerCounterSlider == null
        ? 0
        : pedometerCounterSlider.keys.contains(finalDate)
            ? pedometerCounterSlider[finalDate]
            : 0;

    await TargetService.UpdateDailyWalkingRecord(steps: phoneStorage);
  }
}
