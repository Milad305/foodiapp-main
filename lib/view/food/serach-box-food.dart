import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';

class FoodSearchBox extends GetView<FoodGetter> {
  FoodSearchBox({Key? key}) : super(key: key);
  Timer? _debounce;
  String? txtSearch;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        controller: controller.controllerTxt,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        onChanged: (val) {
          txtSearch = val.toString();

          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(const Duration(milliseconds: 1500), () async {
            if (val != "") {
              await controller.getFoodSearch(text: val);
              FocusScope.of(context).unfocus();
            }
          });
        },
        onEditingComplete: () {
          controller.getFoodSearch(text: txtSearch);
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: GestureDetector(
            child: Icon(Icons.clear),
            onTap: () {
              controller.removeSerachBoxText();
              txtSearch = "";
              FocusScope.of(context).unfocus();
            },
          ),
          //
          suffixIcon: GestureDetector(
            child: ImageIcon(
              AssetImage("assets/images/search.png"),
              size: 30,
              color: Constants.secondaryColor,
            ),
            onTap: () {
              controller.getFoodSearch(text: controller.controllerSearch);
            },
          ),
          suffixIconColor: Colors.black45,
          fillColor: Colors.black45,
          focusColor: Colors.black45,
          hintText: "جستجو...",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15.sp),
        ),
        style: TextStyle(color: Colors.black45, fontSize: 15.sp),
        cursorColor: Colors.black45,
      ),
    );
  }
}
