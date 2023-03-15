import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';

class CouponPage extends GetView<PlansGetx> {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Obx(() {
                  final coupon = controller.coupon.value;
                  return TextFormField(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "کد تخفیف",
                      hintTextDirection: TextDirection.rtl,
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      controller.coupon(val.toString());
                    },
                  );
                }),
              ),
              SizedBox(width: 7),
              Container(
                child: Obx(() {
                  final coupon = controller.coupon.value;
                  final couponLoading = controller.couponLoading.value;
                  return InkWell(
                    onTap: couponLoading
                        ? null
                        : coupon == ""
                            ? null
                            : () {
                                controller.getPlanCoupon();
                              },
                    child: Container(
                      width: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: couponLoading
                            ? Colors.grey.shade200
                            : coupon == ""
                                ? Colors.grey.shade200
                                : Constants.activeColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: couponLoading == true
                          ? SpinKitThreeBounce(
                              color: Colors.black45,
                              size: 17,
                            )
                          : Text(
                              "بررسی",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: coupon == ""
                                      ? Colors.black87
                                      : Colors.white),
                            ),
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() {
            final showMsgCoupon = controller.showMsgCoupon.value;
            if (showMsgCoupon == false || controller.coupon.value == "") {
              return Container();
            }
            return Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                controller.successCoupon.isEmpty
                    ? "کد وارد شده وجود ندارد"
                    : "  کد تخفیف ${controller.successCoupon[0].percentage}درصدی برای شما اعمال شد  "
                        .toString()
                        .toPersianDigit(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
