import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/bottom_navigation_bar.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/getx/person-selector.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/select-date/select-date.dart';

class HomePageAppBar extends GetView<PersonSelector> {
  final title;
  HomePageAppBar({Key? key, required this.title}) : super(key: key) {
    //Get.put(BottomNavigationBarGetter());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: AppBar(
        title: Container(
          width: Get.width * 0.50,
          decoration: BoxDecoration(
            color: Constants.secondaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: WidgetSelectDateHome(
              filed: controller.date, afterChange: Get.find<HomeGetter>()),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left:11.0),
            child: InkWell(
              child: Image.asset("assets/images/menu.png"),
              onTap: () {
                ZoomDrawer.of(context)!.toggle();
                Get.find<BottomNavigationBarGetter>().btmNavActivity.value =
                    false;
              },
            ),
          )
        ],
      ),
    );
  }
}
