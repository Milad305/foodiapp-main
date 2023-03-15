import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/bazzar-plan/bazzar-subscriptions-main.dart';
import 'package:salamatiman/view/plan/buy_plan.dart';

import 'my_subscriptions_tile.dart';

class MySubscriptionsMain extends GetView<PlansGetx> {
  MySubscriptionsMain({Key? key}) : super(key: key) {
    Get.lazyPut(() => PlansGetx());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Constants.forBazzar == false) {
        controller.getUserSubscriptions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
      ),
      body: Constants.forBazzar
          ? Padding(
              padding: const EdgeInsets.all(10.0),
             // child: BazzarSubscriptionsMain(),  bazarme
            )
          : Obx(() {
              if (controller.plansLoding.value) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black45,
                    size: 17,
                  ),
                );
              }
              if (controller.subscriptions.isEmpty) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty.png"),
                        const SizedBox(
                          height: 20,
                        ),
                         Text(
                          " هنوز اشتراکی تهیه نکردی!",
                          style: TextStyle(
                            fontSize: 24.sp,
                          ),
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => BuyPlan());
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children:  [
                              const Icon(Icons.arrow_forward, color: Colors.blue),
                              const SizedBox(width: 5),
                              Text(
                                "خرید اشتراک",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "اشتراک‌های من",
                      style: TextStyle(
                        fontSize: 24.sp,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: controller.subscriptions.length,
                          itemBuilder: (context, index) {
                            final subscription =
                                controller.subscriptions[index];
                            return MySubscriptionTile(
                                subscription: subscription);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
    );
  }
}
