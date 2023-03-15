import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class ActivityItem extends GetView<AuthGetter> {
  final title;
  final icon;
  final content;
  final index;
  const ActivityItem({
    Key? key,
    this.title,
    this.content,
    required this.icon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemWidth = Get.width - 130;
    return GestureDetector(
      onTap: () {
        controller.personActivity(index);
      },
      child: Column(
        children: [
          Row(
            children: [
              Obx(() => Column(
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.only(right: 10, bottom: 5, top: 5),
                        child: RadioCustom(
                            isActive: controller.personActivity.value,
                            index: index,
                            Icon: Image.asset(
                              'assets/images/activity/${(index + 1)}.png',
                              fit: BoxFit.cover,
                              color: controller.personActivity.value == index
                                  ? Constants.secondaryColor
                                  : Constants.deActiveColor,
                            )),
                      ),
                      FittedBox(
                        child: Padding(
                          padding:  const EdgeInsets.only(right:8.0),
                          child: Text(
                            title.toString(),
                            style: TextStyle(
                              
                                fontWeight: FontWeight.bold, fontSize: 8.sp),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
       
        ],
      ),
    );
  }

  Widget RadioCustom(
      {required int isActive, required int index, required Icon}) {
    return DefaultTextStyle(
      style: TextStyle(
          color: isActive == index
              ? Constants.secondaryColor
              : Constants.deActiveColor),
      child: Container(
        width: 60,
        height: 60,
        child: DefaultTextStyle(
          child: Icon,
          style: TextStyle(
              color: isActive == index
                  ? Constants.secondaryColor
                  : Constants.deActiveColor),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Constants.shadeColor, blurRadius: 10)
            ]),
      ),
    );
  }
}
