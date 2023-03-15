import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/exit_in_app.dart';

import '../getx/internet-check.dart';

class NoInternet extends StatelessWidget {
  NoInternet({Key? key}) : super(key: key) {
    Get.put(InternetCHeck());
  }

  @override
  Widget build(BuildContext context) {
    return ExitInApp(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: Get.height / 5.7,
                    left: 20,
                    right: 20,
                    child: Image.asset(
                      "assets/images/no-internet.png",
                    ),
                  ),
                  Positioned(
                    bottom: 80.sp,
                    child: Column(
                      children: [
                        SizedBox(height: 40.sp),
                        Text(
                          "عدم اتصال به اینترنت",
                          style: TextStyle(
                            fontSize: 25.sp,
                            color: Constants.textColor,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        Text(
                          "اتصال به اینترنت را بررسی کنید",
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Constants.textColor,
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        InkWell(
                          onTap: () async {
                            Get.put(() => InternetCHeck());
                            await Get.find<InternetCHeck>().hasInternet();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7.sp, horizontal: 20.sp),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: Constants.primarygradiant,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    offset: Offset(3, 4))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.sp),
                            ),
                            child: Text(
                              " برای تلاش مجدد کلیک کنید",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
