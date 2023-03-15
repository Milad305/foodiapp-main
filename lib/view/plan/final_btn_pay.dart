import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/repo/url_launcher.dart';
import 'package:salamatiman/utils/constants.dart';

class FinalBtnPay extends GetView<PlansGetx> {
  const FinalBtnPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final thisPlan = controller.plans[controller.planSelected.value];
      final price = thisPlan.price;
      final id = thisPlan.id;
      final coupon = controller.coupon.value;
      final finalPrice = price;
      return InkWell(
        key: const Key("btnPay"),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          decoration: BoxDecoration(
            color: controller.planPay.value == ""
                ? Colors.grey.shade200
                : Constants.successColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Text(
            "خرید اشتراک",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        onTap: controller.planPay.value == ""
            ? null
            : () async {
                final token = await GetStorage().read('UserToken');

                final url =
                    "https://salamatiman.ir/api/v2/plan/upgrade?amount=${controller.payPrice.value}&gateway=${controller.planPay.value}&plan_id=$id&sub_duration=${Constants.planDurationNum[controller.planDuration.value]}&off_code=${coupon}&token=$token";
                LaunchUrlExternal(url);
              },
      );
    });
  }
}
