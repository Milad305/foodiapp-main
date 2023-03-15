import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/biometric/biometric.dart';
import 'package:salamatiman/model/biometric/biometric_records.dart';
import 'package:salamatiman/utils/constants.dart';

class BiometricItemTile extends StatelessWidget {
  final BiometricRecordsModel item;
  final controller;
  const BiometricItemTile(
      {Key? key, required this.item, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map units = {
      "kg": "کیلو گرم",
      "cm": "سانتی متر",
      "bpm": "ضربان بر دقیقه",
      "mmol\/L": "میلی مول بر لیتر",
      "mg\/dL": "میلی گرم بر دسی لیتر",
      "°C": "سانتی گراد",
      "°F": "فارنهایت",
      "Kelvin": "کلوین",
      "%": "درصد",
      "minutes": "دقیقه"
    };
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12, right: 10, left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sp),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1.0,
            blurRadius: 5.0,
          )
        ],
      ),
      child: Dismissible(
        key: UniqueKey(),
        dragStartBehavior: DragStartBehavior.start,
        behavior: HitTestBehavior.opaque,
        direction: DismissDirection.startToEnd,
        background: slideRightBackground(),
        secondaryBackground: Icon(Icons.delete_forever),
        onDismissed: (DismissDirection direction) =>
            removeBiometricAlert(direction, context),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: WidgetIcon(title: item.description),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item.description} ${item.amount} ${units[item.unit]}"
                      .toPersianDigit(),
                  style: TextStyle(fontSize: 16.sp),
                ),
                Text(
                  "اضافه شده در: ${item.time}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> removeBiometricAlert(DismissDirection direction, context) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(
              "آیا میخوای حذف کنی؟",
              style: TextStyle(
                  fontFamily: Constants.primaryFontFamily, fontSize: 16.sp),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "بله",
                  style: TextStyle(fontFamily: Constants.primaryFontFamily),
                ),
                onPressed: () async {
                  final res = await Get.find<BiometricGetter>()
                      .biometricDeleteRecord(id: [item.id]);
                  if (res == 1) {
                    Navigator.of(context).pop(true);
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'خیر',
                  style: TextStyle(fontFamily: Constants.primaryFontFamily),
                ),
                onPressed: () {
                  // Dismiss the dialog but don't
                  // dismiss the swiped item
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.redAccent,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " حذف",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  WidgetIcon({title}) {
    switch (title) {
      case "وزن":
        return Image.asset(
          "assets/images/biometric/wheight.png",
          fit: BoxFit.fill,
        );
      case "قد":
        return Image.asset(
          "assets/images/biometric/height.png",
          fit: BoxFit.fill,
        );
      case "ضربان قلب":
        return Image.asset(
          "assets/images/biometric/heartbeat.png",
          fit: BoxFit.fill,
        );
      case "قند خون":
        return Image.asset(
          "assets/images/biometric/blood.png",
          fit: BoxFit.fill,
        );
      case "حرارت بدن":
        return Image.asset(
          "assets/images/biometric/thermometer.png",
          fit: BoxFit.fill,
        );
      case "چربی بدن":
        return Image.asset(
          "assets/images/biometric/blood-fat.png",
          fit: BoxFit.fill,
        );
      case "خواب":
        return Image.asset(
          "assets/images/biometric/sleep.png",
          fit: BoxFit.fill,
        );
      case "کتون":
        return Image.asset(
          "assets/images/biometric/keton.png",
          fit: BoxFit.fill,
        );
      default:
        return Text("$title");
    }
  }
}
