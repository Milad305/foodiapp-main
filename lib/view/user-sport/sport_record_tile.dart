import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/sport/sport-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class SportRecordTile extends StatelessWidget {
  final item;
  const SportRecordTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 15),
      child: Dismissible(
        key: UniqueKey(),
        dragStartBehavior: DragStartBehavior.start,
        behavior: HitTestBehavior.opaque,
        direction: DismissDirection.startToEnd,
        background: slideRightBackground(),
        secondaryBackground: Icon(Icons.delete_forever),
        onDismissed: (DismissDirection direction) =>
            removeBiometricAlert(direction, context),
        child: SizedBox(
          width: double.infinity,
          child: ListTile(
            style: ListTileStyle.list,
            minLeadingWidth: 60,
            leading: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Constants.secondaryColor,
              ),
              child: Text(
                "${Constants.nutrientsTranslate[item.type.toString()]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
                maxLines: 1,
              ),
            ),
            title: Text(
              item.description.toString(),
              style: TextStyle(
                fontSize: 14.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "در: ${item.time}".toPersianDigit() +
                  " به مدت " +
                  "${item.amount} ".toPersianDigit() +
                  "${Constants.biometricAllUnits[item.unit]}",
              maxLines: 1,
              style: TextStyle(
                fontSize: 13.5.sp,
                color: Colors.grey.shade500,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${item.calories != null ? item.calories.toString().replaceAll(RegExp('[^0-9]'), '') : 0}"
                      .toPersianDigit(),
                  style: TextStyle(
                      fontSize: 15.sp, color: Constants.secondaryColor),
                ),
                Text(
                  "کالری",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
          ),
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
                  final res =
                      await Get.find<SportGetter>().deleteRecord(id: [item.id]);
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
}
