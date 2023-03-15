import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../getx/sport/sport-getter.dart';
import '../../utils/age-calculator.dart';
import '../../utils/constants.dart';

abstract class AddSportRecord extends StatelessWidget {
  final userInfo = Constants.userInfo;
  AddSportRecord({Key? key}) : super(key: key);

  static add(sport) {
    print(sport);
    final age =
        AgeCalculator.age(DateTime.parse(Constants.userInfo["birth_date"]));
    final stress = Constants.userInfo["stress"] ?? 1;
    final height = Constants.userInfo["height"] ?? 1;
    final weight = Constants.userInfo["weight"] ?? 1;
    final gender = Constants.userInfo["gender"] ?? "male";
    Get.dialog(CupertinoAlertDialog(
      title: const Text('افزودن تمرین ورزشی',
          textAlign: TextAlign.center), // To display the title it is optional
      content: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 20,
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "ميزان فعاليت براساس دقیقه",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CupertinoTextField(
                        controller: TextEditingController(
                            text: sport.minutes.toString()),
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 1,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontFamily: Constants.primaryFontFamilyAdad),
                        onChanged: (val) {
                          if (val.toString().isNotEmpty) {
                            Get.find<SportGetter>()
                                .minute(int.parse(val.toString()));
                          } else {
                            Get.find<SportGetter>().minute(0);
                          }
                        },
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 15.sp),
            Obx(() {
              final minute = Get.find<SportGetter>().minute.value;
              return Text.rich(TextSpan(
                  text: "میزان کالری مصرفی",
                  children: [
                    TextSpan(text: " "),
                    TextSpan(
                        text: GetActivityCalories(
                                minutes: minute == 0 ? sport.minutes : minute,
                                stress: stress,
                                age: age.years,
                                weight: weight,
                                height: height,
                                gender: gender,
                                MET: sport.met)
                            .toInt()
                            .toString()
                            .toPersianDigit(),
                        style: TextStyle(
                            color: Constants.primaryColor2, fontSize: 24.sp)),
                  ],
                  style: TextStyle(fontSize: 17.sp)));
            }),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          child: Text("ذخیره"),
          onPressed: () async {
            var res = await Get.find<SportGetter>().addRecord(
                eid: sport.id,
                minutes: Get.find<SportGetter>().minute.value == 0
                    ? sport.minutes
                    : Get.find<SportGetter>().minute.value,
                calories: GetActivityCalories(
                        minutes: Get.find<SportGetter>().minute.value == 0
                            ? sport.minutes
                            : Get.find<SportGetter>().minute.value,
                        stress: stress,
                        age: age.years,
                        weight: weight,
                        height: height,
                        gender: gender,
                        MET: sport.met)
                    .toInt());
            if (res) {
              Get.back();
              Fluttertoast.showToast(msg: "تمرین ورزشی شما با موفقیت ذخیره شد");
              Get.find<SportGetter>().getSportRecords();
            } else {
              Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
            }
          },
        ),
        MaterialButton(
          child: Text("بستن"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ));
  }

  static double GetActivityCalories(
      {MET, minutes, gender, height, weight, age, stress}) {
    var result = BMR(
            gender: gender,
            height: height,
            weight: weight,
            age: age,
            stress: stress) *
        (MET / 24) *
        minutes /
        60;
    return result;
  }

  static double BMR({gender, height, weight, age, stress}) {
    if (gender == "male") {
      var result = 66.47 + 13.75 * weight + 5 * height - 6.76 * age * stress;
      return double.parse(result.toString());
    }
    var result = 655.1 + 9.56 * weight + 1.85 * height - 4.68 * stress;
    return double.parse(result.toString());
  }
}
