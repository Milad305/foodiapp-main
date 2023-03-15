import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';

import 'coupon_input.dart';
import 'duration_tile.dart';
import 'final_btn_pay.dart';
import 'pay_select.dart';

class PlanSelectDialog extends GetView<PlansGetx> {
  const PlanSelectDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.plans.isEmpty) {
        return Container();
      }
      final thisPlan = controller.plans[controller.planSelected.value];
      final price = thisPlan.price;
      final id = thisPlan.id;

      final enable = price != 0.0 ? true : false;

      return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: enable
              ? () async {
                  controller.coupon("");
                  controller.successCoupon.clear();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Directionality(
                        textDirection: ui.TextDirection.rtl,
                        child: AlertDialog(
                          titlePadding: const EdgeInsets.all(5),
                          contentPadding: const EdgeInsets.all(5),
                          title: Container(
                            width: Get.width,
                            padding: EdgeInsets.only(bottom: 10, top: 7),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            )),
                            child: Text(
                              " پلن انتخابی ${thisPlan.title} ",
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xFFe36436),
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          content: Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Table(
                                    columnWidths: const {
                                      0: IntrinsicColumnWidth(),
                                      1: FlexColumnWidth(2.5),
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      TableRow(children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'مدت زمان: ',
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                                textDirection:
                                                    TextDirection.rtl,
                                              )
                                            ]),
                                        Column(children: const [
                                          DurationTile(),
                                        ]),
                                      ]),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const CouponPage(),
                                  const SizedBox(height: 20),
                                  const PaySelect(),
                                  const SizedBox(height: 15),
                                  Obx(() {
                                    double thisPricec =
                                        double.parse(price.toString());

                                    double coupon = 0.0;

                                    //coupon
                                    if (controller.successCoupon.isNotEmpty) {
                                      final dPrice =
                                          double.parse(price.toString());
                                      final dPercentage = double.parse(
                                          controller
                                              .successCoupon.value[0].percentage
                                              .toString());
                                      thisPricec = dPrice -
                                          ((dPrice * dPercentage) / 100);
                                      coupon = double.parse(
                                          ((dPrice * dPercentage) / 100)
                                              .toString());
                                    }

                                    //price duration
                                    final planDuration =
                                        controller.planDuration.value;
                                    final planDurationMonth =
                                        Constants.planDurationNum[planDuration];

                                    //format price
                                    var formatPrice =
                                        intl.NumberFormat('#,###', 'en_US');
                                    final thisPricecFormat = formatPrice
                                        .format(thisPricec * planDurationMonth);
                                    ////////////

                                    controller.payPrice(double.parse(
                                        (thisPricec * planDurationMonth)
                                            .toString()));
                                    return Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (coupon > 0.0) ...[
                                            Text.rich(
                                              TextSpan(
                                                  text: "تخفیف: ",
                                                  children: [
                                                    TextSpan(
                                                        text: formatPrice
                                                                .format(coupon)
                                                                .toString()
                                                                .toPersianDigit() +
                                                            " هزار تومان "),
                                                  ]),
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                          if (coupon > 0.0) ...[
                                            SizedBox(height: 15),
                                          ],
                                          Text.rich(
                                            TextSpan(
                                                text: "مبلغ قابل پرداخت:\n ",
                                                children: [
                                                  TextSpan(
                                                      text: thisPricecFormat
                                                              .toString()
                                                              .toPersianDigit() +
                                                          " هزار تومان ",
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ]),
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          actions: const [
                            Center(child: FinalBtnPay()),
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      );
                    },
                  );
                }
              : null,
          child: Container(
            width: double.infinity,
            height: 47,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: enable ? Constants.warningColor : Constants.disabledColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "خرید اشتراک",
              style: TextStyle(color: Colors.black87, fontSize: 17),
            ),
          ),
        ),
      );
    });
  }
}
