import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/custom-food/custom-food-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/foods/foods.dart';
import 'package:salamatiman/service/foods/save-food.dart';

class RecipesGetter extends GetxController {
  RxList foods = [].obs;

  RxString title = "".obs;
  RxInt category = 0.obs;

  RxList<FoodCategoryModel> categorys = <FoodCategoryModel>[].obs;
  RxInt categorySelected = 7.obs;

  RxInt servType = 0.obs;
  RxInt defaultFormValueType = 0.obs;

  RxList defaultFormValue = [
    {"title": "یک لیوان", "size": "3"}
  ].obs;

  RxString listFormField = "".obs;

  RxString protein = "".obs;
  RxString fat = "".obs;
  RxString carbohydrate = "".obs;
  RxString energy = "".obs;
  RxString foodID = "".obs;

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
      update();
    }
  }

  calories({food, portions, size}) {
    final proteinSize = (food.protein / 100);
    final fatSize = food.fat / 100;
    final carbohydrateSize = food.carbohydrate / 100;

    ///portions
    var portionSelected = portions;
    var amount = double.parse(portionSelected["amount"].toString());
    var gramWeight = double.parse(portionSelected["gram_weight"].toString());
    var thisGram = gramWeight / amount;
    var forProteinSize = (thisGram * proteinSize) * size;
    var forFatSize = (thisGram * fatSize) * size;
    var forCarbohydrateSize = (thisGram * carbohydrateSize) * size;

    final sum = forProteinSize + forFatSize + forCarbohydrateSize;

    final forCalories =
        (forProteinSize * 4) + (forFatSize * 9) + (forCarbohydrateSize * 4);
    return {
      "protein": forProteinSize,
      "fat": forFatSize,
      "carbohydrate": forCarbohydrateSize,
      "calories": forCalories,
      "sum": sum,
    };
  }

  saveRecipes(
      {ingredients,
      portions,
      weight_based,
      recipe_name,
      recipe_category}) async {
    final result = await SaveFood().SaveRecipes(
      ingredients: ingredients,
      portions: portions,
      weight_based: weight_based,
      recipe_name: recipe_name,
      recipe_category: recipe_category,
    );
    if (result is Success) {
      final json = jsonDecode(result.response.toString());
      print(json);
      protein('${json['protein'].toString()}');
      fat('${json['fat'].toString()}');
      carbohydrate('${json['carbohydrate'].toString()}');
      energy('${json['energy'].toString()}');
      foodID('${json['id'].toString()}');
      Fluttertoast.showToast(msg: 'غذای شخصی شما اضافه شد');
    } else if (result is Failure) {
      Fluttertoast.showToast(msg: 'خطا در ذخیره سازی . لطفا دوباره تلاش کنید');
      print(result.errorResponse);
    }
  }
}
