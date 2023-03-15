import 'dart:convert';
import 'dart:ui' as ui;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/food/recipes.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/getx/internet-check.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/foods/foods.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/foot-tile-chart.dart';

abstract class SaveFoodBox extends StatelessWidget {
  const SaveFoodBox({Key? key}) : super(key: key);

  @override
  static show(
      {context,
      food,
      controller,
      forSaveRecipes = false,
      String btnTitle = "ذخیره غذا",
      String groupTitle = "",
      int group = 0}) {
    controller.portions("");
    controller.size(1.0);
    controller.portions.value = "";
    Get.find<FoodGetter>().portions.value = "";
    final portions = food.portions.length > 0 ? food.portions : [];
    List select = [];

    final paddingLeftRight = 10.0.sp;

    portions.map((e) => select.add(e)).toList();
    var titleToList = food.title.toString().split(" ");

    //date
    var date = DateTime.now();
    var newDate = DateTime(date.year, date.month, date.day);
    List dateSelected = [];
    var myDate;
    if (controller.dateSelected.value != "") {
      dateSelected = controller.dateSelected.value.split(' ');
      dateSelected = dateSelected[0].split('-');
      myDate = DateTime(int.parse(dateSelected[0]), int.parse(dateSelected[1]),
          int.parse(dateSelected[2]));
    }
    final personTimeSelected = dateSelected.isEmpty ? newDate : myDate;
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.only(
            bottom: 10,
            top: 15,
            left: paddingLeftRight,
            right: paddingLeftRight),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.sp),
                margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                child: Text.rich(
                  TextSpan(
                      text: titleToList[0].length > 0 ? "افزودن " : "افزودن ",
                      children: [
                        TextSpan(text: food.shortTitle.toString()),
                        forSaveRecipes
                            ? const TextSpan(text: "")
                            : const TextSpan(text: " "),
                        forSaveRecipes
                            ? const TextSpan(text: "")
                            : TextSpan(text: "به $groupTitle"),
                      ]),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 20.sp),
              Wrap(
                children: [
                  Container(
                    width: (Get.width * 0.6) - paddingLeftRight,
                    padding: EdgeInsets.all(7.sp),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7.sp),
                          bottomRight: Radius.circular(7.sp)),
                    ),
                    child: Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'انتخاب نوع',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: select
                                .map((item) => DropdownMenuItem(
                                      value: jsonEncode(item),
                                      child: SizedBox(
                                        width: (Get.width * 0.6) -
                                            paddingLeftRight -
                                            50,
                                        child: Text(
                                          item["modifier"].toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: controller.portions.value == ""
                                ? jsonEncode(select[0])
                                : controller.portions.value,
                            onChanged: (value) {
                              controller.portions.value = value.toString();
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            dropdownElevation: 8,
                          ),
                        )),
                  ),
                  FoodSizeNumberPicker(paddingLeftRight, controller),
                ],
              ),
              SizedBox(height: 20.sp),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: (paddingLeftRight + 10).sp,
                      right: (paddingLeftRight + 10).sp,
                    ),
                    padding: EdgeInsets.all(15.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: Constants.primarygradiant,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      btnTitle,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    SetNewFood(
                        controller: controller,
                        food: food,
                        group: group,
                        personTimeSelected: personTimeSelected,
                        forSaveRecipes: forSaveRecipes);
                  },
                ),
              ),
              SizedBox(height: 20.sp),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: FoodTileChart(food: food),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom / 3),
            ],
          ),
        ),
      ),
    );
  }

  static SetNewFood(
      {controller, group, food, personTimeSelected, forSaveRecipes}) async {
    if (controller.portions.value == "") {
      controller.portions(jsonEncode(food.portions[0]));
    }
    if (controller.size.value == 0.0) {
      Fluttertoast.showToast(
        msg: "لطفا تعداد رو وارد کن",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
    var portions = controller.portions.value;
    var size = controller.size.value;

    //time format
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hms().format(now);

    var timeOnlyDate = personTimeSelected.toString().split(' ')[0].split('-');
    var timeOnlyTime = formattedTime.split(':');

    var userDateSelected = DateTime(
        int.parse(timeOnlyDate[0]),
        int.parse(timeOnlyDate[1]),
        int.parse(timeOnlyDate[2]),
        int.parse(timeOnlyTime[0]),
        int.parse(timeOnlyTime[1]),
        int.parse(timeOnlyTime[2]));

    var timestamp = userDateSelected.microsecondsSinceEpoch
        .toString()
        .substring(
            0, userDateSelected.microsecondsSinceEpoch.toString().length - 6);
    // end time format

    ///Portions Format
    var myPortions = portions;
    myPortions = myPortions.replaceAll('{', '');
    myPortions = myPortions.replaceAll('}', '');
    var myPortionsList = myPortions.split(',');
    List myFinalPortionsList = [];
    myPortionsList.map((e) => myFinalPortionsList.add(e.split(':'))).toList();

    ///End Portions Format
    ///
    ///
    if (forSaveRecipes == false) {
      /// This Food Add Object
      var res = await Foods.addFoodRecord(
          data: jsonEncode({
        "portion_id": myFinalPortionsList[0][1],
        "count": size,
        "app_time": timestamp,
        "group": group,
        "food_id": food.id
      }));

      /// End This Food Add Object

      if (res is Success) {
        if (res.response == '1') {
          Fluttertoast.showToast(
            msg: "غذا با موفقیت اضافه شد",
            toastLength: Toast.LENGTH_SHORT,
          );
          Get.back();
          Get.find<InternetCHeck>().getDataByDate();
          Get.find<FoodGetter>().getFoodRecords();
        } else {
          Fluttertoast.showToast(
            msg: "خطا در ذخیره سازی",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else if (res is Failure) {
        Fluttertoast.showToast(
          msg: "خطا در ذخیره سازی",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Get.find<RecipesGetter>().foods.add({
        "portion": {
          "id": myFinalPortionsList[0][1],
          "amount": myFinalPortionsList[1][1],
          "modifier": myFinalPortionsList[2][1],
          "gram_weight": myFinalPortionsList[3][1],
        },
        "portion_id": myFinalPortionsList[0][1],
        "count": size,
        "app_time": timestamp,
        "group": group,
        "food_id": food.id,
        "food": food,
      });
      Fluttertoast.showToast(msg: "اضافه شد");
    }
  }

  static FoodSizeNumberPicker(paddingLeftRight, controller) {
    return Container(
        width: (Get.width * 0.30) - (paddingLeftRight + 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.sp),
              bottomLeft: Radius.circular(7.sp)),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Constants.primaryColor, width: 2),
            ),
          ),
          width: (Get.width * 0.4) - 80,
          alignment: Alignment.center,
          child: TextField(
              textDirection: ui.TextDirection.ltr,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "تعداد",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp)),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20.sp),
              textAlign: TextAlign.center,
              onChanged: (String val) {
                if (val.length < 5 && val.isNotEmpty) {
                  if (double.parse(val) > 0.0) {
                    controller.size(double.parse(val));
                  }
                } else {
                  if (double.parse(val) < 0.0) {
                    controller.size(double.parse(0.toString()));
                  }
                }
              }),
        ));
  }
}
