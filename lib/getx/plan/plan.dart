import 'dart:convert';

import 'package:get/get.dart';
import 'package:salamatiman/model/plan/coupon_model.dart';
import 'package:salamatiman/model/plan/plan_model.dart';
import 'package:salamatiman/model/plan/subscriptions_model.dart';
import 'package:salamatiman/model/plan/transactions_model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/plans/plans.dart';

class PlansGetx extends GetxController {
  RxList<PlansModel> plans = <PlansModel>[].obs;
  RxList<SubscriptionsModel> subscriptions = <SubscriptionsModel>[].obs;
  RxList<TransactionsModel> transactions = <TransactionsModel>[].obs;
  RxBool plansLoding = false.obs;
  RxInt planSelected = 0.obs;
  RxInt planDuration = 1.obs;
  RxString planPay = "".obs;
  //coupon
  RxString coupon = "".obs;
  RxList<CouponModel> couponList = <CouponModel>[].obs;
  RxBool couponLoading = false.obs;
  RxBool showMsgCoupon = false.obs;

  RxList<CouponModel> successCoupon = <CouponModel>[].obs;

  RxDouble payPrice = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getPlans();
  }

  getUserSubscriptions() async {
    if (subscriptions.isEmpty) {
      plansLoding(true);
      final res = await PlanServer().getUserSubscriptions();
      if (res is Success) {
        final json = jsonDecode(res.response.toString());
        json
            .map((item) => subscriptions.add(SubscriptionsModel.fromJson(item)))
            .toList();
      }
      plansLoding(false);
    }
  }

  getUserTransactions() async {
    plansLoding(true);
    final res = await PlanServer().getUserTransactions();
    if (res is Success) {
      final json = jsonDecode(res.response.toString());
      json
          .map((item) => transactions.add(TransactionsModel.fromJson(item)))
          .toList();
    }
    plansLoding(false);
  }

  getPlans() async {
    if (plans.isEmpty) {
      plansLoding(true);
      final res = await PlanServer().getPlanList();
      if (res is Success) {
        final json = jsonDecode(res.response.toString());
        json.map((item) => plans.add(PlansModel.fromJson(item))).toList();
      }
      plansLoding(false);
    }
  }

  getPlanCoupon() async {
    successCoupon.clear();
    if (couponList.isEmpty) {
      couponLoading(true);
      final res = await PlanServer().getPlanCoupon();
      if (res is Success) {
        final json = jsonDecode(res.response.toString());
        json.map((item) => couponList.add(CouponModel.fromJson(item))).toList();
        for (int i = 0; i < couponList.length; i++) {
          if (couponList[i].code.toString() == coupon.value.toString()) {
            successCoupon.add(couponList[i]);
          }
        }
      }
      couponLoading(false);
    } else {
      for (int i = 0; i < couponList.length; i++) {
        if (couponList[i].code.toString() == coupon.value.toString()) {
          successCoupon.add(couponList[i]);
        }
      }
    }
    setShowMsgCoupon();
  }

  setShowMsgCoupon() async {
    showMsgCoupon(true);
    await Future.delayed(Duration(seconds: 3));
    showMsgCoupon(false);
  }
}
