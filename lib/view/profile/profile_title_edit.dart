import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class ProfileTitleEdit extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final edit;
  ProfileTitleEdit({Key? key, required this.title, this.onTap, this.edit})
      : super(key: key);

  var user = GetStorage().read('UserInfo');
  AuthGetter authGetter = Get.put(AuthGetter());
  @override
  Widget build(BuildContext context) {
    final birth_date = user['birth_date'].toString().toPersianDate();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height / 15,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Constants.shadeColor, blurRadius: 10)
            ]),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${title}",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              birth_date.toString().split("/")[2].toString(),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey.shade500,
              ),
            ),
            VerticalDivider(
              color: Constants.shadeColor,
              indent: Get.height / 100,
              endIndent: Get.height / 100,
              thickness: 1,
            ),
            Text(
              birth_date.toString().split("/")[1].toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
              ),
            ),
            VerticalDivider(
              color: Constants.shadeColor,
              thickness: 1,
              indent: Get.height / 100,
              endIndent: Get.height / 100,
            ),
            Text(
              birth_date.toString().split("/")[0].toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
              ),
            ),
            if (edit) ...[Icon(Icons.edit, color: Colors.grey.shade300)]
          ],
        ),
      ),
    );
  }
}
