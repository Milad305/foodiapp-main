import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../getx/bottom_navigation_bar.dart';


class ExitInApp extends StatelessWidget {
  final child;
  ExitInApp({Key? key, required this.child}) : super(key: key) {
    Get.put(BottomNavigationBarGetter());
  }
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      await Get.find<BottomNavigationBarGetter>().itemSelecter(0);
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;

        if (Get.find<BottomNavigationBarGetter>().itemSelecter == 0) {


          Fluttertoast.showToast(msg: "برای خروج دوباره فشار دهید");
          return Future.value(false);
        }
      }
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: child,
    );
  }
}
