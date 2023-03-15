import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/repo/strintcurrency.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/bazzar-plan/buy-plan-bazzar.dart';

import 'buy_plan_tile.dart';

class BuyPlan extends GetView<PlansGetx> {
  BuyPlan({Key? key}) : super(key: key) {
    Get.lazyPut(() => PlansGetx());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Constants.forBazzar == false) {
        controller.getPlans();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final strintcurrency = StrIntCurrency();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Constants.forBazzar
          ? Container()//BuyPlanBazzar() bazarme
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Obx(() {
                  final planLoding = controller.plansLoding.value;
                  if (planLoding) {
                    return const SpinKitThreeBounce(
                      color: Colors.black45,
                      size: 17,
                    );
                  }
                  if (controller.plans.isEmpty) {
                    return const Text("خطا در دریافت اشتراک ها");
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 30),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            "خرید اشتراک",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (int i = 0; i < controller.plans.length; i++) ...[
                          BuyPlanTile(plan: controller.plans[i], index: i),
                        ],
                      ],
                    ),
                  );
                }),
              ),
            ),
      //bottomNavigationBar: PlanSelectDialog(),
    );
  }
}
