import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/widgets/exit_in_app.dart';

import '../../utils/constants.dart';
import 'get_the_number.dart';

class AuthMain extends StatelessWidget {
  AuthMain({Key? key}) : super(key: key) {
    Get.put(AuthGetter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ExitInApp(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: Get.width * 0.33,
                ),
                SizedBox(height: 25.sp),
                Text(
                  "به سلامتی من خوش آمدید",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 40.sp),
                GestureDetector(
                  onTap: () => Get.to(() => GetTheNumber()),
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      borderRadius: BorderRadius.circular(50.sp),
                    ),
                    child: Text(
                      "جهت عضویت‌/ورود کلیک کن",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
