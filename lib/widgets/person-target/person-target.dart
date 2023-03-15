import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/target-page/target-main.dart';
import 'package:salamatiman/widgets/home-list-tile/home-list-tile.dart';

class PersonTarget extends GetView<PersonTargetGeter> {
  final defultAllData;
  PersonTarget({Key? key, required this.defultAllData}) : super(key: key) {
    Get.put(PersonTargetGeter());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.myTargetLoading.value == false &&
          controller.myTarget.isNotEmpty) {
        final myTarget = controller.myTarget[0]["weight_target_mode"];
        var myTargetTranslate = "";
        if (myTarget == "reduce") {
          myTargetTranslate = "کاهش";
        } else if (myTarget == "increase") {
          myTargetTranslate = "افزایش";
        } else if (myTarget == "fixed") {
          myTargetTranslate = "تثبیت";
        }
        final weightInitial = controller.myTarget[0]["weight"];
        final weightTarget = controller.myTarget[0]["weight_target"];
        var weight;

        var myWeightMap;
        if (controller.myTarget[0]["values"].isNotEmpty) {
          myWeightMap = controller.myTarget[0]["values"].toString().split(",");
          weight = myWeightMap[0].toString().split(":")[1];
        }

        return controller.myTargetLoading.value == false
            ? GestureDetector(
                onTap: () {
                  Get.to(
                    () => TargetMain(),
                    transition: Transition.native,
                  );
                },
                child: HomeListTile(
                  title: myTarget == "" || myTarget == "null"
                      ? Text(
                          "بدون هدف",
                          style: TextStyle(fontSize: 12.sp),
                        )
                      : Text(
                          " هدف من : ${myTargetTranslate} وزن ",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                  subtitle: myTarget == "" || myTarget == "null"
                      ? Text("برای تعیین هدف کلیک کنید")
                      : Text.rich(
                          TextSpan(text: " وزن فعلی :", children: [
                            const TextSpan(text: " "),
                            TextSpan(
                                text: weightInitial
                                    .toStringAsFixed(1)
                                    .toString()
                                    .toPersianDigit(),
                                style:
                                    TextStyle(color: Constants.textBtnColor)),
                            const TextSpan(text: " "),
                            const TextSpan(text: "   وزن هدف :"),
                            const TextSpan(text: " "),
                            const TextSpan(text: " "),
                            TextSpan(
                                text: weightTarget.toString().toPersianDigit(),
                                style: TextStyle(color: Constants.secondaryColor)),
                          ]),
                          style: TextStyle(fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                  icon: Image.asset(
                    "assets/images/target-icon.png",
                    width: 45,
                  ),
                ),
              )
            : const Text("");
      }
      return GestureDetector(
        onTap: () {
          Get.to(
            () => TargetMain(),
            transition: Transition.native,
          );
        },
        child: HomeListTile(
          title: Text(
            "بدون هدف",
            style: TextStyle(fontSize: 12.sp),
          ),
          subtitle: Text("برای تعیین هدف کلیک کنید"),
          icon: Image.asset(
            "assets/images/target-icon.png",
            width: 45,
          ),
        ),
      );
    });
  }
}
