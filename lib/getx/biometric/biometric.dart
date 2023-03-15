import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/biometric-model.dart';
import 'package:salamatiman/model/biometric/biometric_records.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/biometric/biometric-service.dart';
import 'package:salamatiman/utils/get-date.dart';

import '../home/home-getter.dart';
import '../target/target-getter.dart';

class BiometricGetter extends GetxController {
  RxInt selected = 0.obs;
  RxList<BiometricModel> biometricList = <BiometricModel>[].obs;
  RxList<BiometricRecordsModel> biometricRecords =
      <BiometricRecordsModel>[].obs;
  RxBool loading = false.obs;
  RxBool errorData = false.obs;

  RxBool loadingBtn = false.obs;

  RxString unitSelected = "".obs;

  RxString dateSelected = GetDate.todayOnlyDate().toString().obs;

  TextEditingController textEditingController = TextEditingController();

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBiometricList();
  }

  getBiometricList() async {
    loading.value = true;
    errorData.value = false;
    if (biometricList.isEmpty) {
      try {
        var res = await BiometricService().getBiometricList();
        if (res is Success) {
          var json = jsonDecode(res.response.toString());
          json
              .map((item) => biometricList.add(BiometricModel.fromJson(item)))
              .toList();
          errorData.value = false;
        } else {
          errorData.value = true;
        }
      } catch (e) {
        errorData.value = true;
      }
    }
    loading.value = false;
  }

  getBiometricRecords() async {
    loading(true);
    try {
      var res = await BiometricService().getBiometricRecord(date: dateSelected);
      if (res is Success) {
        biometricRecords([]);
        var json = jsonDecode(res.response.toString());

        json
            .map((item) =>
                biometricRecords.add(BiometricRecordsModel.fromJson(item)))
            .toList();
      } else {
        errorData.value = true;
      }
    } catch (e) {
      throw (e);
    }
    loading(false);
    update();
  }

  setBiometricAddRecord({
    required int? bid,
    required int? amount,
    required String? unit,
  }) async {
    loadingBtn.value = true;
    try {
      loadingBtn.value = true;
      var res = await BiometricService().setBiometricAddRecord(
          bid: bid,
          amount: amount,
          unit: unit,
          appTime: dateSelected.value.toString());

      if (res is Success) {
        print(res.response);
        loadingBtn.value = false;
        Fluttertoast.showToast(msg: "ذخیره شد");
        getBiometricRecords();
      } else {
        loadingBtn.value = false;
        Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
      }
    } catch (e) {
      print(e);
    }
    loadingBtn.value = false;
  }

  biometricDeleteRecord({required id}) async {
    try {
      loadingBtn.value = true;
      var res = await BiometricService().getBiometricDeleteRecord(id: id);

      if (res is Success) {
        Fluttertoast.showToast(msg: "بایومتریک با موفقیت حذف شد");
        //biometricRecords.removeWhere((element) => element.id == id);
        for (int i = 0; i < biometricRecords.length; i++) {
          if (biometricRecords[i].id == id[0]) {
            biometricRecords.remove(biometricRecords[i]);
            break;
          }
        }
        Get.find<PersonTargetGeter>().me();
        Get.find<PersonTargetGeter>().getUserTarget(["days", 1]);
        Get.find<HomeGetter>()
            .getAllApi(Get.find<HomeGetter>().dateSelected.value);
        update();
        return 1;
      } else {
        Fluttertoast.showToast(msg: "خطا در حذف بایومتریک");
      }
    } catch (e) {
      print(e);
    }
    update();
    return 0;
  }

  getDataByDate([date]) async {
    if (date != null) {
      dateSelected(date.toString().split(" ")[0].toString());
    }
    await getBiometricRecords();
  }


}
