import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/report-card/food_gruops_controller.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/get-date.dart';
import 'package:shamsi_date/shamsi_date.dart';

WidgetSelectDateHome({required filed, required afterChange}) {

  void changeDateOnlyOneDay(incOrDec) {
    var date = filed.value == "" || filed.value == null
        ? GetDate.todayOnlyDate().toString()
        : filed.value;
    var res = GetDate.changeDateOnlyOneDay(date: date, incOrDec: incOrDec);
    filed(res.toString().split(" ")[0].toString());
    afterChange.getDataByDate(res);
  }

  return Container(
    width: Get.width * 0.55,
    decoration: BoxDecoration(
       gradient: const LinearGradient(
                colors: Constants.primarygradiant,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
      borderRadius: BorderRadius.circular(50),
    ),
    alignment: Alignment.center,
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 17.sp,
            color: Colors.white,
          ),
          onPressed: () {
            changeDateOnlyOneDay(-1);
            Get.find<FoodGroupsController>().date.value=filed.value.toString().split(" ")[0] ;
            Get.find<FoodGroupsController>().getFoodGroups2();
            print(filed.value.toString().split(" ")[0]);


          }, 
        ),
        Obx(() {
          return GestureDetector(
            onTap: () {
              filed(GetDate.todayOnlyDate().toString());
              afterChange.getDataByDate(GetDate.todayOnlyDate().toString());
                Get.find<FoodGroupsController>().date.value= GetDate.todayOnlyDate();
                      Get.find<FoodGroupsController>().getFoodGroups2();
            },
            child: Text(
              GetDate.getDateResult(filed.value.toString().split(" ")[0]),
              style: TextStyle(color: Colors.white, fontSize: 17.sp),
            ),
          );
        }),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_sharp,
            size: 17.sp,
            color: Colors.white,
          ),
          onPressed: () {
            changeDateOnlyOneDay(1);
               Get.find<FoodGroupsController>().date.value=filed.value.toString().split(" ")[0] ;
               Get.find<FoodGroupsController>().getFoodGroups2() ;
          },
        ),
      ],
    ),
  );
}
