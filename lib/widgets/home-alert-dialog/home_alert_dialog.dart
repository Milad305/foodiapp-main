import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/bottom_navigation_bar.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/rotation.dart';

import '../../view/biometric/biometric_get.dart';
import '../../view/food/meal-main/meal-main-all.dart';
import '../../view/notes2/notes2_main.dart';
import '../../view/user-sport/sport_records.dart';

class HomeAlertDialog extends GetView<BottomNavigationBarGetter> {
  HomeAlertDialog({Key? key}) : super(key: key);
  final Duration? _duration = Duration(milliseconds: 400);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                 
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => MealMainAll(
                              group: -1,
                              title: "همه وعده های غذایی",
                              onlySnack: false),
                        );
                      },
                      child: ItemBox(
                          text: "افزودن غذا",
                          imageAddress:
                              "assets/images/quick-access/addfood.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => Notes2Main());
                      },
                      child: ItemBox(
                          text: "یادداشت",
                          imageAddress: "assets/images/quick-access/notes.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SportRecords());
                      },
                      child: ItemBox(
                          text: "ورزش",
                          imageAddress:
                              "assets/images/quick-access/sportRecord.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => BiometricGet());
                      },
                      child: ItemBox(
                          text: "بیومتریک",
                          imageAddress:
                              "assets/images/quick-access/biometric.png"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: 
        
        
        InkWell(
          onTap: () {
              controller.isOpenHomeAlertDialog(false);
              Get.back();
            },
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
             gradient: LinearGradient(colors: Constants.primarygradiant,begin: Alignment.topCenter,end: Alignment.bottomCenter),
               shape: BoxShape.circle  
        
            ),
            child: Obx(() => TweenAnimationBuilder(
                duration: _duration!,
                curve: Curves.easeOut,
                tween: Tween<double>(
                    begin: 0,
                    end: controller.isOpenHomeAlertDialog.value ? 0.13 : 0),
                builder: (context, dynamic value, child) {
                  return RotationBox(
                    child: const Icon(Icons.add,color: Colors.white,),
                    rotation: value,
                  );
                })),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: 55,
        ));
  }

  ItemBox({required text, required imageAddress}) {
    return Container(
      width: Get.width * 0.33,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              imageAddress,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${text}",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
