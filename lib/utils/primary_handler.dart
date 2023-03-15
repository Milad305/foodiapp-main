import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/plan/buy_plan.dart';

class PrimaryHandler extends GetView<PlansGetx> {
  final pageName;
  final Widget child;

  PrimaryHandler({Key? key, required this.pageName, required this.child})
      : super(key: key) {
    Get.lazyPut(() => PlansGetx());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subscriptions = controller.subscriptions.value;
      final user = GetStorage().read('UserInfo');
      final List prohibited =
          user["prohibited"] == null ? [] : user["prohibited"];
      final isActive = prohibited.contains(pageName);
      return LayoutBuilder(
        builder: (context, constraints) {
          if (Constants.forBazzar) {
            if (Constants.bazzarStatus) {
              return child;
            }
          }
          if (isActive==false) {
            return PrimaryPage();
          }
          return child;
        },
      );
    });
  }

  Widget PrimaryPage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Text(
            "شما دسترسی کامل برای مشاهده این بخش را نداری",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            "برای مشاهده باید اشتراک تهیه کنی",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            child: Text(
              "خرید اشتراک",
              style: TextStyle(color: Colors.black87),
            ),
            onPressed: () {
              Get.to(() => BuyPlan());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
