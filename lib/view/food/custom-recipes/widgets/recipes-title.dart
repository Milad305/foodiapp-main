import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/recipes.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/recipes-tile.dart';

class RecipesTitle2 extends StatelessWidget {
  const RecipesTitle2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width/1.1,
      child: TextFormField(
        decoration: InputDecoration(
               hintText: "عنوان غذا...",
               hintStyle: TextStyle(color: Constants.shadeColor,fontSize: 14.sp),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  
                  color: Constants.shadeColor, width: 1),
                borderRadius: BorderRadius.circular(7),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.shadeColor, width: 1),
                borderRadius: BorderRadius.circular(7),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                gapPadding: 0,
              ),
            ),
        onChanged: (value) {
          Get.find<RecipesGetter>().title(value.toString());
        },
      ),
    );
  }
}
