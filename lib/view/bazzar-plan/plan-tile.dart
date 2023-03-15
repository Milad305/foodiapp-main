/* import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/bazzar-plan.dart';
import 'package:salamatiman/utils/constants.dart';

class PlanTile extends GetView<BazzarPlanGetter> {
  final plan, index;

  const PlanTile({
    Key? key,
    required this.plan,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final active = controller.itemActive.value == index ? true : false;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        child: GestureDetector(
          onTap: () {
            controller.itemActive(index);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 14.sp,
                      height: 14.sp,
                      margin: EdgeInsets.only(left: 4.sp),
                      decoration: BoxDecoration(
                          color: active
                              ? Constants.activeColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.sp),
                          border: Border.all(
                            color: active
                                ? Constants.activeColor
                                : Colors.grey.shade500,
                            width: 1.sp,
                          )),
                    ),
                    Text(
                      "پلن ${plan.title.toString()}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Constants.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.sp),
                Text(
                  plan.price.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 14.sp),
                Text(
                  plan.description.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
 */

//bazarme