import 'dart:async';
import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'getx/pedometer_getter.dart';
import 'main-application.dart';
import 'utils/awesome_notifications_init.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  try {
    await AndroidAlarmManager.initialize();
    await AwesomeNotificationsInit().init();
    await GetStorage.init();
  } catch (e) {}

  AwesomeNotifications().actionStream.listen((action) {
    if (action.buttonKeyPressed == "close") {
      GetStorage().write('walkBgS', false);
      Get.find<PedometerGetter>().pedometerActive(false);
      Get.find<PedometerGetter>().UpdateDailyWalkingRecord();
    }
  });

  const bool.fromEnvironment("forBazzar", defaultValue: true);

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child) {
   
        return MainApplication();  },
      )
  );
}
