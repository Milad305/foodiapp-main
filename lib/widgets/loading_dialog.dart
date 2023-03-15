import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

abstract class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  static show() {
    Get.dialog(
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Center(
            child: WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: Center(
                  child: SpinKitThreeBounce(
                    color: const Color(0xFFF7F7F7),
                    size: 35.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
        useSafeArea: true);
  }
}
