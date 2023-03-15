import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import '../auth/register_step/activity/list-activity.dart';

class ProfileUserAvtivity extends GetView<AuthGetter> {
  var user;
  final Color primaryColor;

  ProfileUserAvtivity(
      {Key? key, required this.user, required this.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.userInfo.isNotEmpty) {
        user = controller.userInfo[0];
      }
      final AvtivityList = Avtivity.listActivity;
      final userActivity = user["activity"];
      return Container(
        width: double.infinity,
        height: Get.height/6,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AvtivityList.length,
          itemBuilder: (context, index) {
            final isActive = userActivity == ((index + 1) * 100);
            return GestureDetector(
              onTap: () {
                controller.changeProfileField(
                    name: "activity", val: ((index + 1) * 100), isBack: false);
              },
              child: Padding(
                padding:  EdgeInsets.only(right: Get.width/40,top: 5),
                child: Container(
                   height: Get.height/17,
                  width:  Get.width/7,
                  alignment: Alignment.center,
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                  height: Get.width/7,
                  width:  Get.width/7,     
                        decoration:  BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                 boxShadow: <BoxShadow>[BoxShadow(
                       color: Constants.shadeColor,
                       blurRadius: 10

                 )]
                 ),
                        child: Image.asset(
                          "assets/images/activity/${index + 1}.png",
                          width: 35,
                          height: 35,
                          fit: BoxFit.fill,
                          color: isActive ? primaryColor : Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(height: Get.height/100),
                      FittedBox(
                        child: Text(
                          AvtivityList[index]["title"],
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w100,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
