/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/bazzar-plan.dart';
import 'package:salamatiman/view/plan/my_subscriptions/my_subscriptions_tile.dart';

class BazzarSubscriptionsMain extends GetView<BazzarPlanGetter> {
  BazzarSubscriptionsMain({Key? key}) : super(key: key) {
    Get.lazyPut(() => BazzarPlanGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (controller.planList.isEmpty) {
        controller.getPlans();
      }
      controller.getPurchasedProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.purchasedProductsList.isEmpty) {
        return const Text("");
      }
      List purchasedProductsList = controller.purchasedProductsList;
      return ListView.builder(
        itemCount: purchasedProductsList.length,
        itemBuilder: (context, index) {
          final name = findPlanName(
              planList: controller.planList.toList(),
              sku: purchasedProductsList[index].productId);
          return MySubscriptionTile(
            subscription: purchasedProductsList[index],
            name: name,
          );
          //return MySubscriptionTile(
          //               subscription: purchasedProductsList[index]);
        },
      );
    });
  }

  findPlanName({planList, sku}) {
    for (int i = 0; i < planList.length; i++) {
      if (planList[i].sku == sku) {
        return planList[i].title.toString();
      }
    }
    return sku.toString();
  }
}
 */
//bazarme