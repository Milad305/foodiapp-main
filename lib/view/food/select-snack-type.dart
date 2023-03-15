import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

import 'meal-main/meal-main.dart';

class SelectSnackType extends StatelessWidget {
  const SelectSnackType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Constants.primaryColor,
        backgroundColor: Constants.primaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: Get.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () => Get.to(
                      () => MealMain(group: 3, title: "میان‌وعده قبل ناهار"),
                      transition: Transition.downToUp),
                  leading: Image.asset("assets/images/vadeh/snaks.png"),
                  title: Text("میان‌وعده قبل ناهار"),
                  subtitle: Text("0".toPersianDigit()),
                ),
                ListTile(
                  onTap: () => Get.to(
                      () => MealMain(group: 5, title: "میان‌وعده بعد ناهار"),
                      transition: Transition.downToUp),
                  leading: Image.asset("assets/images/vadeh/snaks.png"),
                  title: Text("میان‌وعده بعد ناهار"),
                  subtitle: Text("0".toPersianDigit()),
                ),
                ListTile(
                  onTap: () => Get.to(
                      () => MealMain(group: 7, title: "میان‌وعده بعد شام"),
                      transition: Transition.downToUp),
                  leading: Image.asset("assets/images/vadeh/snaks.png"),
                  title: Text("میان‌وعده بعد شام"),
                  subtitle: Text("0".toPersianDigit()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SelectSnackTypeBox({title, number, boxColor, textColor}) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 3,
          lightSource: LightSource.topLeft,
          color: Colors.grey),
      child: InkWell(
        child: Container(
          width: Get.width * 0.7,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: boxColor, borderRadius: BorderRadius.circular(3)),
          child: Text(
            title.toString(),
            style: TextStyle(fontSize: 19, color: textColor),
          ),
        ),
        onTap: () => Get.to(
            () => MealMain(group: number, title: title.toString()),
            transition: Transition.downToUp),
      ),
    );
  }
}
