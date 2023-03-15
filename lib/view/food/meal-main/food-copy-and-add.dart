import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/food-category.dart';

class FoodCopyAndAdd extends StatelessWidget {
  final group, title;
  FoodCopyAndAdd({Key? key, @required this.group, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Get.height / 25,
          width: Get.width / 3.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Constants.shadeColor, blurRadius: 10)
              ]),
          child: GestureDetector(
            onTap: () {
              // foodOfferController.getHomeItems();
              //     myFavFoodController.getMyFavFoods();

              Get.to(() => FoodCategory(group: group, title: title));
            },
            child: Center(
              child: Text(
                "افزودن غذا",
                textAlign: TextAlign.center,
                style: TextStyle(color: Constants.textColor, fontSize: 13.sp),
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width / 17,
        ),
        Container(
          height: Get.height / 25,
          width: Get.width / 2.2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Constants.shadeColor, blurRadius: 10)
              ]),
          child: GestureDetector(
            onTap: () {
              Get.find<FoodGetter>().addFoodFromYesterday();
            },
            child: Center(
              child: Text(
                "کپی غذای دیروز برای امروز",
                textAlign: TextAlign.center,
                style: TextStyle(color: Constants.textColor, fontSize: 13.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
