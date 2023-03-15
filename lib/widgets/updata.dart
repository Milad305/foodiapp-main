import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdataApp extends StatelessWidget {
  const UpdataApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "اپلیکیشن شما نسخه قدیمی می باشد لطفا به نسخه بروزتر بروزرسانی کنید",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
