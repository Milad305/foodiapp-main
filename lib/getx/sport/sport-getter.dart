import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/getx/internet-check.dart';
import 'package:salamatiman/model/sport/sport-category-model.dart';
import 'package:salamatiman/model/sport/sport-model.dart';
import 'package:salamatiman/model/sport/sport_records_model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/biometric/biometric-service.dart';
import 'package:salamatiman/service/sport/sport-service.dart';
import 'package:salamatiman/utils/get-date.dart';

class SportGetter extends GetxController {
  RxList<SportCategorysModel> categorys = <SportCategorysModel>[].obs;
  RxList<SportRecordsModel> records = <SportRecordsModel>[].obs;
  RxList<SportModel> sport = <SportModel>[].obs;
  RxList<SportModel> sportSearch = <SportModel>[].obs;
  RxBool loading = false.obs;
  RxBool loadingSport = false.obs;
  RxInt minute = 0.obs;
  RxString dateSelected = GetDate.todayOnlyDate().toString().obs;
  RxString searchText = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSportCategories();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getSportCategories() async {
    if (categorys.isEmpty) {
      loading.value = true;
      try {
        var res = await SportService.getSportCategories();
        if (res is Success) {
          var json = jsonDecode(res.response.toString());
          json
              .map((item) => categorys.add(SportCategorysModel.fromJson(item)))
              .toList();
        }
      } catch (e) {
        print(e);
      }
      loading.value = false;
    }
  }

  getSportRecords() async {
    loading.value = true;
    try {
      var res =
          await SportService.getSportRecords(date: dateSelected.toString());
      if (res is Success) {
        records([]);
        var json = jsonDecode(res.response.toString());
        json
            .map((item) => records.add(SportRecordsModel.fromJson(item)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }

  deleteRecord({required id}) async {
    try {
      var res = await BiometricService().getBiometricDeleteRecord(id: id);
      if (res is Success) {
        Fluttertoast.showToast(msg: "تمرین با موفقیت حذف شد");
        //biometricRecords.removeWhere((element) => element.id == id);
        for (int i = 0; i < records.length; i++) {
          if (records[i].id == id[0]) {
            records.remove(records[i]);
            break;
          }
        }
        update();
        return 1;
      } else {
        Fluttertoast.showToast(msg: "خطا در حذف تمرین");
      }
    } catch (e) {
      print(e);
    }
    update();
    return 0;
  }

  getSport({required int? categoryID}) async {
    loadingSport.value = true;
    sport([]);
    try {
      var res = await SportService.getSport(categoryID: categoryID);
      if (res is Success) {
        var jsonSport = jsonDecode(res.response.toString());
        jsonSport.map((item) => sport.add(SportModel.fromJson(item))).toList();
      }
    } catch (e) {
      print(e);
    }
    loadingSport.value = false;
  }

  exerciseSearch({required String? search}) async {
    loadingSport.value = true;
    sportSearch([]);
    try {
      var res = await SportService.exerciseSearch(search: search);
      if (res is Success) {
        var jsonSport = jsonDecode(res.response.toString());
        jsonSport
            .map((item) => sportSearch.add(SportModel.fromJson(item)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    loadingSport.value = false;
  }

  addRecord({required int? eid, required minutes, required calories}) async {
    try {
      var res = await SportService.addRecord(
          eid: eid,
          minutes: minutes,
          calories: calories,
          date: dateSelected.value);
      if (res is Success) {
        await Get.find<InternetCHeck>().getDataByDate();
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  getDataByDate([date]) async {
    if (date != null) {
      dateSelected(date.toString().split(" ")[0].toString());
    }
    await getSportRecords();
  }
}
