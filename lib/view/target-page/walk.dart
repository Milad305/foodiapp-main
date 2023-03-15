import 'dart:math' as math;
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/pedometer_getter.dart';
import 'package:salamatiman/utils/awesome_notifications_init.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/get-date.dart';
import 'package:salamatiman/utils/pedometer-init.dart';
import 'package:salamatiman/widgets/custom-switch.dart';

class walkMain extends GetView<PedometerGetter> {
  final isActive;

  walkMain({Key? key, required this.isActive}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    double boxSelectDate = 180;
    Map<String, dynamic> personWalks = {
      "1400/03/23": 5500,
    };
    return Obx(() {
      final walkUpdate = controller.walkUpdate.value;
      if (controller.getWalking.isEmpty) {
        return Scaffold(
          body: Center(
            child: SpinKitThreeBounce(
              color: Colors.black45,
              size: 17.sp,
            ),
          ),
        );
      }

      return FutureBuilder(
          future: WalkIsActive(),
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return WalkNotActive();
            }
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      pinned: false,
                      floating: false,
                      forceElevated: innerBoxIsScrolled,
                      toolbarHeight: 70.sp,
                      surfaceTintColor: Constants.primaryColor,
                      backgroundColor: Constants.primaryColor,
                      leading: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ];
                },
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(top: 15.sp),
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            
                            decoration: BoxDecoration(
                              color: Constants.textFieldBg,
                            ),
                            width: double.infinity,
                            height: Get.height/15,
                            child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right :Get.width/25),
                                  child: Obx(() {
                                    final text =
                                        controller.pedometerActive.value
                                            ? "غیرفعال سازی قدم شمار"
                                            : "فعال سازی قدم شمار";
                                    return Text(
                                      text.toString(),
                                      style: TextStyle(fontSize: 16.sp),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  width: 50.sp,
                                  child: Obx(() {
                                    final pedometerActive =
                                        controller.pedometerActive.value;
                                    return CustomSwitch(
                                      value: pedometerActive ? true : false,
                                      onChanged: (val) async {
                                        int walkInitID = 100;
                                        if (GetStorage().read('walkBgS') ==
                                            null) {
                                          GetStorage().write('walkBgS', true);
                                          await AndroidAlarmManager.periodic(
                                              const Duration(minutes: 1),
                                              walkInitID,
                                              printHello);
                                        } else {
                                          if (GetStorage().read('walkBgS')) {
                                            GetStorage()
                                                .write('walkBgS', false);
                                            await AndroidAlarmManager.cancel(
                                                walkInitID);
                                            Get.find<PedometerGetter>()
                                                .pedometerActive(false);
                                            Get.find<PedometerGetter>()
                                                .UpdateDailyWalkingRecord();
                                          } else {
                                            await AndroidAlarmManager
                                                .periodic(
                                                    const Duration(
                                                        seconds: 15),
                                                    walkInitID,
                                                    printHello);
                                            GetStorage()
                                                .write('walkBgS', true);
                                          }
                                        }
                                        controller.pedometerActive(
                                            GetStorage().read('walkBgS'));
                                        if (GetStorage().read('walkBgS')) {
                                          await AwesomeNotificationsInit()
                                              .notificationWalk(walkInitID);
                                        } else {
                                          await AwesomeNotificationsInit()
                                              .notiCancel(walkInitID);
                                        }
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Image.asset("assets/images/target-type1.png"),
                          SizedBox(height: 20.sp),
                          Padding(
                            padding:  EdgeInsets.only(left:Get.width/60,right: Get.width/60),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,offset: Offset(0,5))]
                              ),
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                children: [
                                  //Text(controller.dateNumber.value.toString()),

                                  SizedBox(
                                    width: double.infinity,
                                    height: Get.height/7,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: Get.width/17,
                                          padding: EdgeInsets.all(10.sp),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.sp),
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 2.sp,
                                          child: Container(
                                            width: Get.width/18,
                                            height: Get.width/18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.sp),
                                              gradient: const LinearGradient(colors: Constants.primarygradiant,begin: Alignment.bottomCenter,end: Alignment.topCenter)
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        Container(
                                          height: 200.sp,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child:
                                                ListWheelScrollView.useDelegate(
                                              itemExtent: 40.sp,
                                              diameterRatio: 200.sp,
                                              physics:
                                                  FixedExtentScrollPhysics(),
                                              onSelectedItemChanged: (value) {
                                                controller.dateNumber.value =
                                                    value;
                                              },
                                              childDelegate:
                                                  ListWheelChildBuilderDelegate(
                                                childCount: 40,
                                                builder: (BuildContext context,
                                                    int itemIndex) {
                                                  return Row(
                                                    children: [
                                                      RotatedBox(
                                                        quarterTurns: -1,
                                                        child: Obx(() => Text(
                                                              GetDate.decrement(
                                                                      itemIndex)
                                                                  .toString()
                                                                  .toPersianDate()
                                                                  .split("/")[2]
                                                                  .toString()
                                                                  .toPersianDigit(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: controller
                                                                              .dateNumber.value ==
                                                                          itemIndex
                                                                      ? Colors
                                                                          .white
                                                                      : Constants.secondaryColor),
                                                            )),
                                                      ),
                                                      RotatedBox(
                                                        quarterTurns: -1,
                                                        child: Obx(() {
                                                          final thisDate =
                                                              GetDate.decrement(
                                                                  itemIndex);
                                                          final dateToPersian = thisDate
                                                              .toString()
                                                              .toPersianDate(
                                                                  digitType:
                                                                      NumStrLanguage
                                                                          .English);

                                                          final dateToPersianMap =
                                                              dateToPersian
                                                                  .split("/");
                                                          final thisDataMapM =
                                                              dateToPersianMap[
                                                                      1]
                                                                  .padLeft(
                                                                      2, '0');
                                                          final thisDataMapD =
                                                              dateToPersianMap[
                                                                      2]
                                                                  .padLeft(
                                                                      2, '0');
                                                          final finalDate =
                                                              "${dateToPersianMap[0] + "/" + thisDataMapM + "/" + thisDataMapD}";

                                                          double targetHeight =
                                                              8.0;
                                                          List personWalkskeys =
                                                              [];

                                                          personWalks = controller
                                                                  .getWalking[0]
                                                                      [
                                                                      "last_month_steps"]
                                                                  .isEmpty
                                                              ? {
                                                                  "1400/01/01":
                                                                      0
                                                                }
                                                              : controller
                                                                      .getWalking[0]
                                                                  [
                                                                  "last_month_steps"];
                                                          personWalks.keys
                                                              .map((e) =>
                                                                  personWalkskeys
                                                                      .add(e))
                                                              .toList();

                                                          if (personWalks[
                                                                  finalDate] !=
                                                              null) {
                                                            targetHeight = double
                                                                .parse(personWalks[
                                                                        finalDate]
                                                                    .toString());
                                                          }

                                                          final lineHeight = targetHeight >
                                                                  (boxSelectDate -
                                                                      35)
                                                              ? (boxSelectDate -
                                                                  50)
                                                              : targetHeight <
                                                                      8.0
                                                                  ? 8.0
                                                                  : targetHeight;

                                                          return Container(
                                                             );
                                                        }),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: (((Get.height/15 ) ) *
                                                  1)
                                              .sp,
                                          right: 0,
                                          left: 0,
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                            Text("-----------------------------------",style: TextStyle(
                                              fontSize: 25.sp,
                                              color: Constants.secondaryColor),)
                                          ],)
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(() {
                                    personWalks = controller
                                            .getWalking[0]["last_month_steps"]
                                            .isEmpty
                                        ? {"1400/01/01": 0}
                                        : controller.getWalking[0]
                                            ["last_month_steps"];

                                    final finalDate =
                                        dateformater(personWalks: personWalks);

                                    final dateSelected = GetDate.decrement(
                                            controller.dateNumber.value)
                                        .toString()
                                        .toPersianDate(
                                            digitType: NumStrLanguage.English)
                                        .toString()
                                        .split("/");

                                    final DateSelectedY =
                                        dateSelected[0].toString();
                                    final DateSelectedM = dateSelected[1]
                                        .toString()
                                        .padLeft(2, "0");
                                    final DateSelectedD = dateSelected[2]
                                        .toString()
                                        .padLeft(2, "0");

                                    final DateSelectedFormat = DateSelectedY +
                                        "/" +
                                        DateSelectedM +
                                        "/" +
                                        DateSelectedD;

                                    final date = GetDate.decrement(
                                                    controller.dateNumber.value)
                                                .toString()
                                                .split(" ")[0]
                                                .toString() ==
                                            GetDate.todayOnlyDate()
                                        ? "امروز"
                                        : GetDate.decrement(
                                                controller.dateNumber.value)
                                            .toString()
                                            .toPersianDate();

                                    return Column(
                                      children: [
                                        Text(
                                          date.toString(),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Obx(() {
                                          final walkUpdate =
                                              controller.walkUpdate.value;
                                          /////////////////////
                                          final pedometerCounterSlider =
                                              GetStorage().read(
                                                          'PedometerCounter') !=
                                                      null
                                                  ? GetStorage()
                                                      .read('PedometerCounter')
                                                  : [];
                                          ////////////////////////////
                                          int result = 0;
                                          //personWalks
                                          if (pedometerCounterSlider
                                              .isNotEmpty) {
                                            if (pedometerCounterSlider[
                                                    DateSelectedFormat] !=
                                                null) {
                                              result = pedometerCounterSlider[
                                                  DateSelectedFormat
                                                      .toString()];
                                            }
                                          } else if (personWalks[
                                                  DateSelectedFormat
                                                      .toString()] !=
                                              null) {
                                            result = personWalks[
                                                DateSelectedFormat.toString()];
                                          }

                                          return Text(
                                            "${result.toString().toPersianDigit()} قدم",
                                            style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),
                                          );
                                        }),
                                      ],
                                    );
                                  }),
                                  //Text(controller.myPedometer.value.toString()),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: Get.height/12,
                          ),
                          Align(alignment: Alignment.centerRight,
                            child: Padding(
                              padding:  EdgeInsets.only(right: Get.width/25),
                              child: Text(
                                "برای پیاده رویت هدف انتخاب کن",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ),
                          ////////////////////////////////////

                          SizedBox(
                            height: Get.height/70,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: Get.width/60,right: Get.width/60),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,offset: Offset(0,5))]                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height/100,),
                                  Obx(() => Text(
                                        "${controller.myPedometerTarget.value.toInt().toString().toPersianDigit()} قدم",
                                        style: TextStyle(fontSize: 17.sp),
                                      )),

                                      SizedBox(height:Get.height/80,),
                                  Obx(() => Text(
                                        "معادل ${(controller.myPedometerTarget.value.toInt() * (double.parse(controller.getWalking.value[0]["calories_for_1_step"].toString()))).toStringAsFixed(1).toPersianDigit()} کالری",
                                        style: TextStyle(fontSize: 15.sp),
                                      )),
                                  SizedBox(
                                    height: Get.height/200,
                                  ),
                                  Divider(color: Constants.shadeColor,indent: Get.width/17,endIndent: Get.width/17,thickness: 1,),
                                 
                                 SizedBox(height: Get.height/20,),
                                  Container(
                                    height: 60,
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 16.5,
                                          right: 0,
                                          left: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: FractionallySizedBox(
                                                widthFactor: 1,
                                                child: Container(
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color:
                                                        Colors.grey.shade200,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(() {
                                                    final seekbarSize =
                                                        ((controller.myPedometerTarget
                                                                    .value *
                                                                (Get.width -
                                                                    70)) /
                                                            20000);
                                                    final leftSize =
                                                        seekbarSize > 0
                                                            ? seekbarSize
                                                            : 0.0;
                                                    return Container(
                                                      width: leftSize,
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        gradient:
                                                             const LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end: Alignment
                                                              .bottomLeft,
                                                          colors: 
                                                           Constants.primarygradiant
                                                          ,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () {
                                            final seekbarSize = ((controller
                                                        .myPedometerTarget
                                                        .value *
                                                    (Get.width - 70)) /
                                                20000);
                                            final leftSize = seekbarSize > 0
                                                ? seekbarSize
                                                : 0.0;
                                            return Positioned(
                                              left: leftSize,
                                              top: Get.height/120,
                                              child: Column(
                                                children: [
                                                  Container(
                                                     
                                                    alignment: Alignment.center,
                                                    width: Get.width/15,
                                                    height: Get.width/15,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(colors: Constants.primarygradiant),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  ),
                                                    Text(controller.myPedometerTarget.value.toInt().toString().toPersianDigit(),style: TextStyle(color: Constants.secondaryColor),),

                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Opacity(
                                            opacity: 0,
                                            child: Obx(() {
                                              return RotatedBox(
                                                quarterTurns: 2,
                                                child: SliderTheme(
                                                  data:
                                                      SliderTheme.of(context)
                                                          .copyWith(
                                                    overlayShape:
                                                        SliderComponentShape
                                                            .noOverlay,
                                                  ),
                                                  child: Slider(
                                                    value: controller
                                                        .myPedometerTarget
                                                        .value
                                                        .toDouble(),
                                                    min: 400,
                                                    max: 20000,
                                                    onChanged: (val) {
                                                      controller
                                                          .myPedometerTarget
                                                          .value = val.toInt();
                                                    },
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //////////////////////////
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 70,
                child: Center(
                  child: SizedBox(
                    width: Get.width * .90,
                    height: 50,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 0,
                          lightSource: LightSource.topLeft,
                          color: Colors.grey.shade400),
                      child: GestureDetector(
                        onTap: () {
                          controller.saveWalkingTarget();
                        },
                        child: Container(
                          decoration: BoxDecoration(gradient: LinearGradient(colors: Constants.primarygradiant,end: Alignment.bottomCenter,begin: Alignment.topCenter)),
                          alignment: Alignment.center,
                          child: Text(
                            "ذخیره",
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }

  void printHello() {}

  dateformater({personWalks}) {
    final thisDate = GetDate.decrement(controller.dateNumber.value)
        .toString()
        .toPersianDate(digitType: NumStrLanguage.English);
    final thisDataMap = thisDate.split("/");
    final thisDataMapM = thisDataMap[1].padLeft(2, '0');
    final thisDataMapD = thisDataMap[2].padLeft(2, '0');
    final finalDate =
        "${thisDataMap[0] + "/" + thisDataMapM + "/" + thisDataMapD}";
    return finalDate;
  }

  Widget WalkNotActive() {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "قدم شمار فعال نیست",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                child: Text(
                  "فعال کردن",
                  style: TextStyle(color: Constants.secondaryColor),
                ),
                onTap: () async {
                  final res = PedometerInit().permissionActive();
                  res.then((val) {
                    print(val);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> WalkIsActive() async {
    if (await Permission.activityRecognition.request().isGranted) {
      controller.walkUpdate(0);
      return true;
    }
    controller.walkUpdate(0);
    return false;
  }
}
