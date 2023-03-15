import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/select-date/select-date.dart';

class FoodPageAppBar extends GetView<FoodGetter> {
  final title;
  final groupId;

  FoodPageAppBar({Key? key, required this.title, required this.groupId})
      : super(key: key) {
    Get.put(FoodGetter());
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
       
      title: Container(
        width: Get.width * 0.50,
        child: WidgetSelectDateHome(
            filed: controller.dateSelected,
            afterChange: Get.find<FoodGetter>()),
        decoration: BoxDecoration(
          color: Constants.secondaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 90,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      foregroundColor: Colors.black54,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
     
    );
  }
}
