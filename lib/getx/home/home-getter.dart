import 'dart:convert';
import 'package:get/get.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/home/home.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/get-date.dart';
import 'package:salamatiman/view/auth/auth-main.dart';
import '../food/foods.dart';

class HomeGetter extends GetxController {
  RxMap<dynamic, dynamic> allData = Map().obs;
  RxString dateSelected = GetDate.todayOnlyDate().toString().obs;
  RxBool allDataLoading = true.obs;
  RxString config = "".obs;
  RxList macro = [].obs;
  RxList micro = [].obs;
  RxString calories = "".obs;

  RxList foodStats = [].obs;

  RxInt PageView1 = 1.obs;

  RxBool customRefreshLoading = false.obs;

  getAllData() async {
    await getAllApi('');
  }

  getAllApi(data) async {
    if (customRefreshLoading.isFalse) {
      allDataLoading(true);
    }

    var res = await HomePageService.getAllApis(data);
    if (res is Success) {
      if (res.code == 200) {
        var json = await jsonDecode(res.response.toString());
        if (json["common/config"]["original"] == null) {
          Constants.config = jsonEncode(json["common/config"]);
          var keys = json.keys.toList();
          Map myApiRes = {};
          allData.value = {};
          for (var i = 0; i < keys.length; i++) {
            final thisKey = await keys[i].split('/').last;
            myApiRes.addAll({thisKey: json[keys[i]]});
          }
          allData.value = myApiRes;
          print('all data has remaining${allData['GetCalorieReport']}');
          PageView1.value = 1;
          allDataLoading(false);
        } else {
          allData({});
          allDataLoading(false);
          Get.to(() => AuthMain());
        }
      } else {
        allData({});
        allDataLoading(false);
      }
    } else {
      allDataLoading(false);
    }
  }

  setBodyWater({required count, required groupID}) async {
    var datetime = dateSelected.toString().split(" ")[0].toString() +
        " " +
        DateTime.now()
            .toString()
            .split(" ")[1]
            .toString()
            .split('.')[0]
            .toString();
    var res = await HomePageService.setBodyWater(
        count: count, groupID: groupID, datetime: datetime);
    if (res is Success) {
      final json = jsonDecode(res.response.toString());
      final allData = Get.find<HomeGetter>().allData;
      if (allData.containsKey("getWater")) {
        allData["getWater"] = json;
      } else {
        allData.addAll({"getWater": json});
      }
      //update();
    }
  }
  // getFoodStats({date}) async {
  //   try {
  //     final res = await Foods.getFoodStats(date);
  //     if (res is Success) {
  //       final json = jsonDecode(res.response.toString());
  //       if (json.isNotEmpty) {
  //         foodStats.value = [];
  //         foodStats(json);
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  getDataByDate([date]) async {
    Get.lazyPut(() => FoodGetter());
    date = date ?? dateSelected;
    dateSelected(date.toString());
    Get.find<FoodGetter>().dateSelected(date.toString());
    return getAllApi(date);
  }
}
