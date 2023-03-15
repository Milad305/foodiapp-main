import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/model/food/food-category.dart';
import 'package:salamatiman/model/food/food-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/foods/foods.dart';
import 'package:salamatiman/utils/get-date.dart';

class FoodGetter extends GetxController {
  //for recipes
  RxInt recipesAccordionActive = 1000000.obs;
  RxBool isShow = false.obs;
  /////////////
  RxList<FoodModel> foods = <FoodModel>[].obs;
  RxList<FoodCategoryModel> categorys = <FoodCategoryModel>[].obs;
  RxDouble size = 1.0.obs;
  RxString portions = "".obs;

  RxList records = [].obs;
  RxMap allRecords = {}.obs;
  RxInt recordsLoad = 0.obs;

  RxInt groupId = 0.obs;
  RxInt tabBarnum = 0.obs;

  RxString dateSelected = GetDate.todayOnlyDate().toString().obs;
  RxString controllerSearch = "".obs;
  RxList<FoodModel> searchResult = <FoodModel>[].obs;
  TextEditingController controllerTxt = TextEditingController();

  RxBool selectForDelete = false.obs;
  RxList foodSelected = [].obs;

  RxList topNutrients = [].obs;
  RxList customNutrients = [].obs;

  RxList favorite = [].obs;

  RxList packages = [].obs;
  RxBool packagesLoading = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controllerTxt.dispose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getCategorys();
    controllerTxt = TextEditingController(text: "");
    controllerSearch("");
    searchResult([]);
  }

  getPackages(groupID) async {
    packagesLoading(true);
    try {
      packages.clear();
      var res = await Foods.getPackages(gid: groupID);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        json.map((item) {
          packages.add({
            'title': item["title"],
            'foods':
                item["foods"].map((food) => FoodModel.fromJson(food)).toList(),
          });
        }).toList();
        packagesLoading(false);
      } else {
        packages.value = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  removeSerachBoxText() {
    controllerTxt = TextEditingController(text: "");
    controllerSearch("");
    searchResult([]);
  }

  void onDispose() {}

  getDataByDate([date]) async {
    if (date != null) {
      dateSelected(date.toString().split(" ")[0].toString());
    }
    return await getFoodRecords();
  }

  getFoodRecords() async {
    recordsLoad(0);
    try {
      var res = await Foods.getRecord(
          dateSelected.value == ""
              ? GetDate.todayOnlyDate()
              : dateSelected.value,
          -1);
      if (res is Success) {
        records([]);
        topNutrients([]);
        allRecords({});
        var json = jsonDecode(res.response.toString());
        if (json.isNotEmpty) {
          allRecords(json);
          if (json[groupId.value.toString()] != Null) {
            if (groupId.value == -2) {
              try {
                allRecords.remove("6");
                allRecords.remove("4");
                allRecords.remove("2");
              } catch (e) {
                throw ("$e");
              }
            }
            List keys = json.keys.map((e) => e).toList();
            if (!keys.contains(groupId.toString())) {
              recordsLoad(2);
              return false;
            }
            if (groupId.value > 0 && keys.contains(groupId.toString())) {
              json[groupId.toString()].map((e) => records.add(e)).toList();
              getTopNutrients();
              recordsLoad(1);
            } else {
              recordsLoad(2);
              return false;
            }
          } else {
            recordsLoad(2);
          }
        } else {
          recordsLoad(2);
          return false;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    update();
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

  getFoodSearch({required text}) async {
    searchResult.value = [];
    var res = await Foods.getFoodsBySearch(text: text.toString());
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      List<FoodModel> myFoods = [];
      await json.map((e) => myFoods.add(FoodModel.fromJson(e))).toList();
      searchResult.addAll(myFoods);
    } else {
      searchResult.value = [];
    }
  }

  getCategorys() async {
    try {
      if (categorys.isEmpty) {
        var res = await Foods.getCategorys();
        if (res is Success) {
          var json = jsonDecode(res.response.toString());
          List<FoodCategoryModel> myCats = [];
          json.map((e) => myCats.add(FoodCategoryModel.fromJson(e))).toList();
          GetStorage().write('RecipesCategory', myCats);
          categorys.addAll(myCats);
        } else {
          categorys.value = [];
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    update();
  }

  addFoodFromYesterday() async {
    var res = await Foods.setFoodFromYesterday(
        date: dateSelected.value, gid: groupId.value);
    if (res is Success) {
      var json = jsonDecode(res.response.toString());
      if (json == 1 || json == "1") {
        await getFoodRecords();
      }
    } else {}
  }

  void getTopNutrients() async {
    try {
      topNutrients.value = [];
      topNutrients([]);
      var date = dateSelected.value == ""
          ? GetDate.todayOnlyDate()
          : dateSelected.value;
      var res = await Foods.getTopNutrients(date: date, gid: groupId.value);
      if (res is Success) {
        var json = jsonDecode(res.response.toString());
        if (json != null) {
          try {
            topNutrients([]);
            topNutrients.value = [];
            var nutrientKeys = json.keys.map((e) => e).toList();
            nutrientKeys.map((myKey) => topNutrients.add(json[myKey])).toList();
          } catch (e) {
            print(e);
          }
        }
      } else {
        topNutrients([]);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getNutrients({required gids}) async {
    final date =
        dateSelected.value == "" ? GetDate.todayOnlyDate() : dateSelected.value;
    try {
      final res = await Foods.getNutrients(date: date, gids: gids);
      if (res is Success) {
        final json = jsonDecode(res.response.toString());
        customNutrients([]);
        customNutrients.add(json);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteFood({required foodId}) async {
    try {
      var res = await Foods.deleteFood(foodId: foodId);
      if (res is Success) {
        if (res.response == 1 || res.response == "1") {
          Fluttertoast.showToast(msg: "غذاها با موفقیت حذف شدن");
          Get.back(canPop: true);
          topNutrients([]);
          getFoodRecords();
          getTopNutrients();
          await Get.find<HomeGetter>()
              .getAllApi(Get.find<HomeGetter>().dateSelected.value);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  addFoodToFavorites({required foodId}) async {
    if ((favorite.contains(foodId))) {
      favorite.remove(foodId);
    } else {
      favorite.add(foodId);
    }
    try {
      await Foods.addFoodToFavorite(foodId: foodId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  increment() {
    ++size.value;
  }

  decrement() {
    if (size.value > 1) --size.value;
  }
}
