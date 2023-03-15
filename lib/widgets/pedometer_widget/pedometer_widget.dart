import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/pedometer_getter.dart';
import 'package:salamatiman/getx/person-selector.dart';
import 'package:salamatiman/utils/awesome_notifications_init.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/pedometer-init.dart';
import 'package:salamatiman/view/target-page/walk.dart';

class PedometerWidget extends GetView<PedometerGetter> {
  PedometerWidget({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.put(PedometerGetter());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final res = await PedometerInit().isPermissionActive();
          Get.to(() => walkMain(isActive: res));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      child: FractionallySizedBox(
        widthFactor: 0.49,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: 210.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFd7d7d7),
                    blurRadius: 15,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: -4,
                    offset: const Offset(0.0, 2.0)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "قدم",
                  style: TextStyle(fontSize: 24.sp),
                ),
                Obx(
                  () {
                    var active = controller.pedometerActive.value;
                    return SizedBox(
                      height: 90.sp,
                      child: InkWell(
                          onTap: () async {
                            active == false ? active = true : active = false;
                            int walkInitID = 100;
                            if (GetStorage().read('walkBgS') == null) {
                              GetStorage().write('walkBgS', true);
                              await AndroidAlarmManager.periodic(
                                  const Duration(minutes: 1),
                                  walkInitID,
                                  () {});
                            } else {
                              if (GetStorage().read('walkBgS')) {
                                GetStorage().write('walkBgS', false);
                                await AndroidAlarmManager.cancel(walkInitID);
                                Get.find<PedometerGetter>()
                                    .pedometerActive(false);
                                Get.find<PedometerGetter>()
                                    .UpdateDailyWalkingRecord();
                              } else {
                                await AndroidAlarmManager.periodic(
                                    const Duration(seconds: 15),
                                    walkInitID,
                                    () {});
                                GetStorage().write('walkBgS', true);
                              }
                            }
                            controller
                                .pedometerActive(GetStorage().read('walkBgS'));
                            if (GetStorage().read('walkBgS')) {
                              await AwesomeNotificationsInit()
                                  .notificationWalk(walkInitID);
                            } else {
                              await AwesomeNotificationsInit()
                                  .notiCancel(walkInitID);
                            }
                          },
                          child: Image.asset(
                            active == false
                                ? "assets/images/walkdeactive.png"
                                : "assets/images/walkactive.png",
                            scale: 0.5.sp,
                          )),
                    );
                  },
                ),
                SizedBox(
                  height: 20.sp,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final date = Get.find<PersonSelector>().date;

                    final dateFormat = date
                        .toString()
                        .toPersianDate(digitType: NumStrLanguage.English)
                        .split("/");
                    final y = dateFormat[0];
                    final m = dateFormat[1].toString().padLeft(2, '0');
                    final d = dateFormat[2].toString().padLeft(2, '0');
                    String dateText = "$y/" + "$m/" + "$d";

                    var walkCount;
                    if (GetStorage().read('PedometerCounter') != null) {
                      walkCount = GetStorage().read('PedometerCounter');
                    }
                    if (walkCount != null) {
                      final myWalkCount = walkCount["$dateText"];

                      return Obx(() {
                        if (controller.getWalking.isEmpty) {
                          return Container();
                        }

                        final size =
                            controller.getWalking[0]["calories_for_1_step"];
                        return Text(
                          myWalkCount == null
                              ? "".toString()
                              : (size * double.parse(myWalkCount.toString()))
                                      .toStringAsFixed(0)
                                      .toString()
                                      .toPersianDigit() +
                                  " کالری ",
                          style: TextStyle(fontSize: 17.sp),
                          maxLines: 1,
                        );
                      });
                    }
                    return Container();
                  },
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final date = Get.find<PersonSelector>().date;
                    final dateFormat = date
                        .toString()
                        .toPersianDate(digitType: NumStrLanguage.English)
                        .split("/");
                    final y = dateFormat[0];
                    final m = dateFormat[1].toString().padLeft(2, '0');
                    final d = dateFormat[2].toString().padLeft(2, '0');
                    String dateText = "$y/" + "$m/" + "$d";
                    String pedometerText = "امروز قدم نزدی";
                    final walkCount = GetStorage().read('PedometerCounter');
                    if (walkCount == null) {
                    } else if (walkCount.length == 1) {
                      if (walkCount["$dateText"] != null) {
                        pedometerText = "امروز " +
                            walkCount["$dateText"].toString().toPersianDigit() +
                            " قدم زدی ";
                      }
                    }
                    return Text(
                      pedometerText,
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 1,
                    );
                  },
                ),
                Divider(
                  color: Constants.shadowColor,
                  indent: 20.sp,
                  endIndent: 20.sp,
                  thickness: 1,
                ),
                Obx(
                  () => Text(
                    controller.pedometerActive.value == true
                        ? "فعال"
                        : "غیرفعال",
                    style: TextStyle(fontSize: 11.sp),
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
