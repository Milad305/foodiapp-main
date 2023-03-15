/* import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/bazzar-plan.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/bazzar-plan/plan-tile.dart';

class BuyPlanBazzar extends GetView<BazzarPlanGetter> {
  BuyPlanBazzar({Key? key}) : super(key: key) {
    Get.lazyPut(() => BazzarPlanGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.connect();
      if (controller.isBazzarConnected.value) {
        controller.getPlans();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return SpinKitThreeBounce(
          color: Colors.black87,
          size: 17.sp,
        );
      }
      final plans = controller.planList;
      if (plans.isEmpty) {
        return Center(
          child: Text(
            "پلنی یافت نشد",
            style: TextStyle(
              fontSize: 17.sp,
            ),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return PlanTile(
                    plan: plans[index],
                    index: index,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.purchase(planSku: plans[controller.itemActive.value].sku.toString());
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                padding: EdgeInsets.symmetric(vertical: 12.sp),
                decoration: BoxDecoration(
                  color: Constants.secondaryColor,
                  borderRadius: BorderRadius.circular(7.sp),
                ),
                alignment: Alignment.center,
                child: Text(
                  "خرید اشتراک",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
 */
//bazarme