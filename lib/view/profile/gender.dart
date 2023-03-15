import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';

class ProfileGenderSelect extends StatelessWidget {
  final Color primaryColor;
  final String title;
  final IconData icon;
  final String gender;
  const ProfileGenderSelect(
      {Key? key,
      required this.title,
      required this.gender,
      required this.icon,
      required this.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryColor.withOpacity(0.2),
      ),
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          Get.find<AuthGetter>()
              .changeProfileField(name: "gender", val: gender, isBack: true);
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: primaryColor,
              ),
              Text("$title",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
