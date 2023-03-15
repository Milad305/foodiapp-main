import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import '../../utils/pedometer-init.dart';
import 'user-weight-type.dart';
import 'walk.dart';

class SelectTargetType extends GetView<PersonTargetGeter> {
  SelectTargetType({Key? key}) : super(key: key) {
    //Get.put(PersonTargetGeter());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "لطفا هدفتو انتخاب کن",
            style: TextStyle(fontSize: 20.sp),
          ),
          const SizedBox(
            height: 30
          ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.40,
                  child: GestureDetector(
                    onTap: () async {
                      controller.targetType(3);
                      Get.to(() => UserWeightType());
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200.sp,
                          child: Image.asset(
                            "assets/images/target-type2.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: Get.width/5.5,
                          height: Get.height/20,

                          alignment: Alignment.center,
                         
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: Constants.primarygradiant,end: Alignment.bottomCenter,begin: Alignment.topCenter),
                            borderRadius: BorderRadius.circular(50.sp),
                          ),
                          child: Text(
                            "وزن",
                            style: TextStyle(
                              fontSize: 14.sp,fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height/3,
                      width: 1.5,
                      color: Constants.shadeColor,
                    ),
                  ],
                ),
                SizedBox(
                  width: Get.width * 0.40,
                  child: GestureDetector(
                    onTap: () async {
                      final res = await PedometerInit().isPermissionActive();
                      Get.to(() => walkMain(isActive: res));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/images/target-type1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: Get.width/5.5,
                          height: Get.height/20,
                          alignment: Alignment.center,
                      
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: Constants.primarygradiant,end: Alignment.bottomCenter,begin: Alignment.topCenter),
                            borderRadius: BorderRadius.circular(50.sp),
                          ),
                          child: Text(
                            "قدم زدن",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.sp),
        ],
      ),
    );
  }
}
