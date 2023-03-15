import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/report-card/food_gruops_controller.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/get-date.dart';
import 'package:salamatiman/view/food/meal-main/meal-main-all.dart';
import 'package:salamatiman/view/food/meal-main/meal-main.dart';

class MealSelectItem extends StatelessWidget {
  final foodStats;
   MealSelectItem({Key? key, required this.foodStats}) : super(key: key);
 FoodGroupsController foodGroupsController = Get.put(FoodGroupsController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Map<String, dynamic> foodStatsMap = {};
        if (foodStats.isNotEmpty) {
          foodStats
              .map((element) =>
                  foodStatsMap.addAll({element["group"].toString(): element}))
              .toList();
        }

        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Item(
                      onTap: () =>
                          Get.to(() => MealMain(group: 2, title: "صبحانه")),
                      title: "صبحانه",
                      color: const Color(0xFF047c84),
                      imgUrl: "assets/images/vadeh/breakfast.png",
                      size: foodStatsMap.containsKey("2")
                          ? foodStatsMap["2"]
                          : null,
                    ),
                    Item(
                      onTap: () =>
                          Get.to(() => MealMain(group: 4, title: "ناهار")),
                      title: "ناهار",
                      color: const Color(0xFFef990e),
                      imgUrl: "assets/images/vadeh/lunch.png",
                      size: foodStatsMap.containsKey("4")
                          ? foodStatsMap["4"]
                          : null,
                    ),
                    Item(
                      onTap: () =>
                          Get.to(() => MealMain(group: 6, title: "شام")),
                      title: "شام",
                      color: const Color(0xFFe83636),
                      imgUrl: "assets/images/vadeh/dinner.png",
                      size: foodStatsMap.containsKey("6")
                          ? foodStatsMap["6"]
                          : null,
                    ),
                    Item(
                      onTap: () => Get.to(() => MealMainAll(
                          group: -2, title: "میان وعده", onlySnack: true)),
                      title: "میان وعده",
                      color: const Color(0xFF41ce4b),
                      imgUrl: "assets/images/vadeh/snaks.png",
                      size: foodStatsMap.containsKey("snack")
                          ? foodStatsMap["snack"]
                          : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.sp,),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      foodGroupsController.date.value= GetDate.todayOnlyDate();
                      foodGroupsController.getFoodGroups2();
                      Get.to(() => MealMainAll(
                        group: -1,
                        title: "همه وعده های غذایی",
                        onlySnack: false));} ,
                    child: Container(
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              "همه وعده های غذایی",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget Item(
      {required Function() onTap,
      required title,
      required imgUrl,
      required color,
      required size}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: ((Get.width * 0.23) - 8),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: Get.width * 0.18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white, //color
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                                width: 2, color: Colors.white), //Colors.white
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                //Colors.black12
                                spreadRadius: 0,
                                offset: Offset(-2, 3),
                                blurRadius: 7,
                                blurStyle: BlurStyle.normal,
                              )
                            ]),
                        child: Image.asset(imgUrl, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 5),
                      FittedBox(child: Text(title.toString(), style: TextStyle(fontSize: 12.sp))),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                // if (size != null) ...[
                //   Positioned(
                //     right: 0,
                //     top: 0,
                //     child: myNotiNumber(int.parse(size["count"].toString())),
                //   ),
                //   SizedBox(height: 7.sp),
                // ],
              ],
            ),
          ),
          if (size != null) ...[
            Container(
              alignment: Alignment.center,
              child: Text(
                size["total_calories"]
                        .toStringAsFixed(0)
                        .toString()
                        .toPersianDigit() +
                    " " +
                    "کالری",
                    style: TextStyle(fontSize: 12.sp),
                maxLines: 1,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget myNotiNumber(number) {
    String num = number.toString();
    if (number > 9) {
      num = "9+";
    }
    return Container(
      width: 25.sp,
      height: 25.sp,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 2.sp),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(50.sp),
      ),
      child: Text(
        "$num".toPersianDigit(),
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
