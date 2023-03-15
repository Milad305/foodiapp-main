import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';

class PaySelect extends GetView<PlansGetx> {
  const PaySelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            "درگاه پرداخت را انتخاب کن",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              for (var z = 0; z < Constants.planPay.length; z++) ...[
                Obx(() {
                  return Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(
                      bottom: 15,
                      right: 5,
                      left: 5,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          color:
                              controller.planPay.value == Constants.planPay[z]
                                  ? Constants.successColor
                                  : Colors.grey.shade400,
                          width: 1.2),
                    ),
                    child: InkWell(
                      key: Key("payPlan$z"),
                      child: Image.asset(
                          "assets/images/pay/${Constants.planPay[z]}.png"),
                      onTap: () {
                        controller.planPay(Constants.planPay[z].toString());
                      },
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
