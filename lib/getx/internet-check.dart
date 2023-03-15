import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/home/home.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/auth/auth-main.dart';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:salamatiman/service/base.dart';
import 'package:salamatiman/service/foods/foods.dart';
import '../model/food/food-category.dart';
import '../model/food/food-model.dart';
import '../service/sql_helper.dart';
import '../utils/get-date.dart';
import 'food/foods.dart';

class InternetCHeck extends GetxController with GetSingleTickerProviderStateMixin {
  RxDouble fontSize = 2.0.obs;
  RxDouble containerSize = 1.5.obs;
  RxDouble textOpacity = 0.0.obs;
  RxDouble containerOpacity = 0.0.obs;
  RxBool loadfinished = false.obs;
  late AnimationController controller;
  late Animation<double> animation1;
  RxBool loading = false.obs;
  RxBool isInternet = false.obs;
  RxList<FoodCategoryModel> categorys = <FoodCategoryModel>[].obs;
  RxList<FoodModel> foods = <FoodModel>[].obs;
  int sFlag = 1;
  RxMap<dynamic, dynamic> allData = Map().obs;
  RxBool customRefreshLoading = false.obs;
  RxBool allDataLoading = true.obs;
  RxInt PageView1 = 1.obs;
  RxString dateSelected = GetDate.todayOnlyDate().toString().obs;
  RxString config = "".obs;
  RxList macro = [].obs;
  RxList micro = [].obs;
  RxString calories = "".obs;

  RxList foodStats = [].obs;


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
      final allData = Get.find<InternetCHeck>().allData;
      if (allData.containsKey("getWater")) {
        allData["getWater"] = json;
      } else {
        allData.addAll({"getWater": json});
      }
      //update();
    }
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
          
        } else {
          allData({});
          
          Get.to(() => AuthMain());
        }
      } else {
        allData({});
        
      }
    } else {
      
    }
  }

  getDataByDate([date]) async {
    Get.lazyPut(() => FoodGetter());
    date = date ?? dateSelected;
    dateSelected(date.toString());
    Get.find<FoodGetter>().dateSelected(date.toString());
    return getAllApi(date);
  }

  getFoods() async {
    try {
      var res = await Foods.getFoods();
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        json.map((e) => foods.add(FoodModel.fromJson(e))).toList();
      } else {
        foods.value = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getCategorysNoFood() async {
    if (categorys.isEmpty) {
      final result = await Foods.getCategorysNoFoods();
      if (result is Success) {
        try {
          final json = jsonDecode(result.response.toString());
          List<FoodCategoryModel> myList = [];
          json
              .map((category) =>
                  myList.add(FoodCategoryModel.fromJson(category)))
              .toList();
          categorys.addAll(myList);
        } catch (e) {}
      }
    }
  }

  insertSqlStaticRecords() {
    SQLHelper.addFood(foods);
    SQLHelper.addCategory(categorys);
  }

  checkStaticFlag() {
//getting the value of sFlag from server
  }
  
  updateFlag() {
    //changeing value of sFLag in server to 0
  }
  
  getSqlStaticRecords() async {
    categorys.value = SQLHelper.foodCategory;
    foods.value = SQLHelper.foods;
  }

  @override
  void onInit() {
    if (sFlag == 1) {
      checkStaticFlag();
    }

    if (sFlag == 1) {
      getCategorysNoFood();
      getFoods();
      insertSqlStaticRecords();
      updateFlag();
    } else {
      getSqlStaticRecords();
    }

    // TODO: implement onInit
    super.onInit();
    //hasInternet();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        textOpacity.value = 1.0;
      });

    controller.forward();
/* getFoods();
getCategorysNoFood();

SQLHelper.addFood(foods); */
    Timer(Duration(seconds: 2), () {
      fontSize.value = 1.06;
    });

    Timer(Duration(seconds: 2), () {
      containerSize.value = 2.0;
      containerOpacity.value = 1.0;
    });

    Timer(Duration(seconds: 4), () {
      // Get.to(MainApplication());
      loadfinished.value = true;
      // PageTransition(page());
    });
  }

  hasInternet() async {
    try {
      final response = await BaseService.post(
        path: "common/version",
        hasHeader: true,
        hasToken: true,
        body: {},
        loading: false,
      );
      if (response is Success) {
        isInternet(true);
        Get.back();
      } else if (response is Failure) {
        isInternet(false);
      }
    } catch (e) {
      isInternet(false);
    }
    update();
  }
}
