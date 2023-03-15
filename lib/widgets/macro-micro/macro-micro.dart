import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/macro_micro/macro_micro_progress.dart';

import 'all-macro-micro.dart';

double sizeW = Get.width;

class MacroWidget extends GetView<HomeGetter> {
  const MacroWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.allData.containsKey('get_nutrients_daily_average')) {
        final macro = controller.allData['get_nutrients_daily_average'];
        return MacroMicroBuilder(
            controller: controller,
            filed: macro,
            title: "درشت‌ مغذی",
            isLink: false,
            child: Column(
              children: [
                MacroMicroProgress(
                    width: (sizeW - 50),
                    color: Constants.getColorFromHex(
                        controller.allData['config']["colors"]["energy"]),
                    title: macro[3]['name'].toString(),
                    progress: macro[3]["percentage"],
                    target: macro[3]['target']),
                MacroMicroProgress(
                    width: (sizeW - 50),
                    color: Constants.getColorFromHex(
                        controller.allData['config']["colors"]["protein"]),
                    title: macro[0]['name'].toString(),
                    progress: macro[0]["percentage"],
                    target: macro[0]['target']),
                MacroMicroProgress(
                    width: (sizeW - 50),
                    color: Constants.getColorFromHex(
                        controller.allData['config']["colors"]["carbohydrate"]),
                    title: macro[2]['name'].toString(),
                    progress: macro[2]["percentage"],
                    target: macro[2]['target']),
                MacroMicroProgress(
                    width: (sizeW - 50),
                    color: Constants.getColorFromHex(
                        controller.allData['config']["colors"]["fat"]),
                    title: macro[1]['name'].toString(),
                    progress: macro[1]["percentage"],
                    target: macro[1]['target']),
              ],
            ),
            onTap: () => null);
      }
      return Container();
    });
  }
}

class MicroWidget extends GetView<HomeGetter> {
  final onlySnack, onlyfood, gid;
  MicroWidget(
      {Key? key, this.onlySnack = false, this.onlyfood = false, this.gid = -1})
      : super(key: key) {
    if (onlySnack && onlyfood == false) {
      Get.put(FoodGetter());
      Get.find<FoodGetter>().getNutrients(gids: "3,5,7");
    }
    if (onlyfood) {
      Get.put(FoodGetter());
      Get.find<FoodGetter>().getNutrients(gids: gid.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final customNutrients = onlySnack
          ? Get.find<FoodGetter>().customNutrients.isNotEmpty
              ? Get.find<FoodGetter>().customNutrients[0]
              : []
          : controller.allData['get_nutrients_daily_average'];
      if (customNutrients.isEmpty) {
        return Container();
      }
      final micro = customNutrients;
      final List displayList = [
        "ویتامین C",
        "ویتامین A",
        "ویتامین ب9 (فولات)",
        "ویتامین ب۱۲ (کوبالامین)",
        "فیبر",
        "آهن",
        "کلسیم",
        "پتاسیم",
      ];
      List microList = [];
      for (int i = 0; i < displayList.length; i++) {
        for (int z = 0; z < micro.length; z++) {
          if (displayList[i] == micro[z]["name"]) {
            microList.add(micro[z]);
            break;
          }
        }
      }
      return MacroMicroBuilder(
        controller: controller,
        filed: onlySnack
            ? customNutrients
            : controller.allData['get_nutrients_daily_average'],
        title: "ریز مغذی",
        isLink: true,
        child: SizedBox(
          width: (sizeW - 50),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: microList.map((item) {
              return SizedBox(
                width: (sizeW - 20) * 0.44,
                child: MacroMicroProgress(
                  width: (sizeW - 20) * 0.44,
                  color: item["percentage"] >= 99
                      ? item["max"] != null
                          ? item["max"] < item["value"]
                              ? Colors.red
                              : Color(0xFF25a456)
                          : Color(0xFF25a456)
                      : Color(0xFFf9c925),
                  title: item["name"].toString().split("(")[0].toString(),
                  progress: item["percentage"],
                  target: item['percentage'],
                ),
              );
            }).toList(),
          ),
        ),
        onTap: () {
          final data = controller.allData["get_nutrients_daily_average"];
          List deleted = ["پروتئین", "چربی ها", "کربوهیدرات ها", "انرژی"];
          Get.to(() => AllMacroMicro(
                name: "ریز مغذی",
                data: data,
                deleteList: deleted,
              ));
        },
      );
    });
  }
}

Widget MacroMicroBuilder(
    {required String title,
    required controller,
    required filed,
    required GestureTapCallback onTap,
    required isLink,
    required Widget child}) {
  return Container(
    width: sizeW,
    child: Obx(() {
      if (controller.allData.isEmpty) return Text("");
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isLink) ...[
            SizedBox(
              width: sizeW - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 0),
                    child: Text(
                      "$title",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                  GestureDetector(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "مشاهده همه ",
                          style: TextStyle(
                              fontSize: 12.sp, color: Constants.secondaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 12.sp,
                          color: Constants.secondaryColor,
                        ),
                      ],
                    ),
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ],
          SizedBox(
            height: 10,
          ),
          child,
        ],
      );
    }),
  );
}
