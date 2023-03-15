import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/bottom_navigation_bar.dart';
import 'package:salamatiman/utils/constants.dart';

class BottomNavigationBarWidget extends GetView<BottomNavigationBarGetter> {
  BottomNavigationBarWidget({Key? key}) : super(key: key);
  final iconList = <IconData>[
    BottomNavigationBarIcon.home,
    BottomNavigationBarIcon.chat,
    BottomNavigationBarIcon.chart,
    BottomNavigationBarIcon.doc,
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationBarGetter>(
        init: BottomNavigationBarGetter(),
        builder: (controller) {
          return Obx(() => Container(
            decoration: BoxDecoration(color: Color.fromARGB(0, 255, 255, 255)),
            child: AnimatedBottomNavigationBar(
                
                iconSize: 45,
                leftCornerRadius: 20,
                rightCornerRadius: 20,
                elevation: 20 ,
                icons: iconList,
                height: 55,
                activeIndex: controller.itemSelecter.value,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.softEdge,
                inactiveColor: Colors.grey.shade400,
                activeColor: Constants.secondaryColor,
                onTap: (index) => controller.itemSelecter.value = index),
          ));
        });
  }
}
 
class BottomNavigationBarIcon {
  BottomNavigationBarIcon._();

  static const _kFontFam = 'BottomNavigationBarIcon'; 
  static const String? _kFontPkg = null;

  static const IconData home =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData chat =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData chart =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData doc =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);

}