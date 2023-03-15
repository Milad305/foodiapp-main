import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarGetter extends GetxController {
  RxInt itemSelecter = 0.obs;
  RxBool isOpenHomeAlertDialog = false.obs;
  RxBool btmNavActivity = true.obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  changeItemSelecter(index) {
    itemSelecter.value = int.parse(index.toString());
    update();
  }
}
