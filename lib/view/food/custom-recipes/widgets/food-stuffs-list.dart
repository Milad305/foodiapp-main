import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';

class FoodStuffsList extends StatelessWidget {
  const FoodStuffsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Empty(),
    );
  }

  Widget Empty() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            width: Get.width * 0.30,
            child: Image.asset('assets/images/recipes.png'),
          ),
          SizedBox(height: 15.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Text(
              "هنوز مواد تشکیل دهنده غذاتو انتخاب نکردی برای افزودن مواد اولیه روی گزینه افزودن مواد اولیه در بخش مواد تشکیل دهنده کلیک کن",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Constants.textColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
