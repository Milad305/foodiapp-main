import 'dart:async';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/pedometer_getter.dart';
import 'package:salamatiman/utils/get-date.dart';

class PedometerInit {
  StreamSubscription<ActivityEvent>? activityStreamSubscription;
  List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition();

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  var controller = Get.put(PedometerGetter());

  var PedometerCounter = GetStorage().read("PedometerCounter");

  /////
  PedometerInit() {
    StartPedometer();
  }
  ///////
  StartPedometer() async {
    if ((await Permission.activityRecognition.isGranted == true)) {
      return true;
    } else {
      permissionActive();
    }
    return false;
  }

  StopPedometer() {}

  Future<bool> isPermissionActive() async {
    try {
      if (await Permission.activityRecognition.isGranted) {
        initPlatformState();
        GetStorage().write('isPermissionActive', true);
        return true;
      } else {
        GetStorage().write('isPermissionActive', false);
        return false;
      }
    } catch (e) {
      print(e);
      GetStorage().write('isPermissionActive', false);
      return false;
    }
  }

  Future<bool> permissionActive() async {
    try {
      var res = await Permission.activityRecognition.request().isGranted;
      if (res == true) {
        initPlatformState();
        return true;
      } else {
        var status = await Permission.activityRecognition.status;
        if (status.isDenied) {
          return openAppSettings();
        }
      }
    } catch (e) {
      controller.changeActive(false);
    }
    return false;
  }

  void initPlatformState() async {
    try {
      if (await Permission.activityRecognition.isGranted) {
        _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
        _pedestrianStatusStream
            .listen(onPedestrianStatusChanged)
            .onError(onPedestrianStatusError);

        _stepCountStream = Pedometer.stepCountStream;
        _stepCountStream.listen(onStepCount).onError(onStepCountError);
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  void onStepCount(StepCount event) {
    final dateToPersianMap = GetDate.todayOnlyDate()
        .toString()
        .toPersianDate(digitType: NumStrLanguage.English)
        .split("/");
    final thisDataMapM = dateToPersianMap[1].padLeft(2, '0');
    final thisDataMapD = dateToPersianMap[2].padLeft(2, '0');
    final today =
        "${dateToPersianMap[0] + "/" + thisDataMapM + "/" + thisDataMapD}";

    final pedometerCounter = GetStorage().read("PedometerCounter");
    Map<String, dynamic> counter = {"$today": 0};
    if (GetStorage().read('walkBgS') == true) {
      if (GetStorage().read("PedometerCounter") == null) {
        if (pedometerCounter == null) {
          if (GetStorage().read('walkBgS') == true) {
            GetStorage().write("PedometerCounter", counter);
          }
        } else {
          if (pedometerCounter.keys.contains(today)) {
            if (GetStorage().read('walkBgS') == true) {
              pedometerCounter[today] = pedometerCounter[today] + 1;
              GetStorage().write("PedometerCounter", pedometerCounter);
            }
          } else {
            if (GetStorage().read('walkBgS') == true) {
              GetStorage().write("PedometerCounter", counter);
            }
          }
        }
      } else {
        if (pedometerCounter.keys.contains(today)) {
          if (GetStorage().read('walkBgS') == true) {
            pedometerCounter[today] = pedometerCounter[today] + 1;
            GetStorage().write("PedometerCounter", pedometerCounter);
          }
        } else {
          if (GetStorage().read('walkBgS') == true) {
            pedometerCounter.addAll(counter);
            GetStorage().write("PedometerCounter", pedometerCounter);
          }
        }
      }
    }
    controller.walkUpdate(event.steps);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    try {
      controller.status(event.status);
    } catch (e) {}
  }

  void onPedestrianStatusError(error) {
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
  }
}
