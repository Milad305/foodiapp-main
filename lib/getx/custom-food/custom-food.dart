import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/custom-food/custom-food-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/foods/foods.dart';
import 'package:salamatiman/service/foods/save-food.dart';

class CustomFood extends GetxController {
  RxString foodTitle = "".obs;
  RxInt servType = 1.obs;
  RxString listFormField = "".obs;
  RxInt categorySelected = 0.obs;
  RxInt macroTypeSelected = 0.obs;
  RxList<FoodCategoryModel> category = <FoodCategoryModel>[].obs;
  RxInt customSize = 1.obs;
  RxBool btnLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getFoodCategory();
  }

  getFoodCategory() async {
    if (category.isEmpty) {
      try {
        var res = await Foods.getCategorysNoFoods();
        if (res is Success) {
          var json = jsonDecode(res.response.toString());
          json
              .map((item) => category.add(FoodCategoryModel.fromJson(item)))
              .toList();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  saveFood({food, portions, nutrients}) async {
    print(portions);
    btnLoading(true);
    var res = await SaveFood()
        .SaveMyFood(food: food, nutrients: nutrients, portions: portions);
    if (res is Success) {
      //final json = jsonDecode(res.response.toString());
      Fluttertoast.showToast(msg: "غذا با موفقیت اضافه شد");
    } else if (res is Failure) {
      Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
      print(res.errorResponse);
    }
    btnLoading(false);
  }
}
