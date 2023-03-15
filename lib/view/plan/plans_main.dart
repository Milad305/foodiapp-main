import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';

import 'buy_plan.dart';
import 'my_subscriptions/my_subscriptions_main.dart';
import 'transactions/transactions_main.dart';

class PlansMain extends GetView<PlansGetx> {
  PlansMain({Key? key}) : super(key: key) {
    Get.lazyPut(() => PlansGetx());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اشتراک سلامتی من"),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.sp),
              PlanListTile(
                child: ListTile(
                  contentPadding: EdgeInsets.all(2.sp),
                  onTap: () => Get.to(() => BuyPlan()),
                  title: Text(
                    "خرید اشتراک",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  leading: Container(
                    margin: EdgeInsets.only(left: 10.sp, right: 3.sp),
                    child: Image.asset(
                      "assets/images/plan/subscription.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 25.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              PlanListTile(
                  child: ListTile(
                contentPadding: EdgeInsets.all(2.sp),
                onTap: () => Get.to(() => MySubscriptionsMain()),
                title: Text(
                  "اشتراک های من",
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                leading: Container(
                  margin: EdgeInsets.only(left: 10.sp, right: 3.sp),
                  child: Image.asset(
                    "assets/images/plan/subscription1.png",
                    width: 50,
                    height: 50,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  size: 25.sp,
                ),
              )),
              if (Constants.forBazzar == false) ...[
                SizedBox(height: 10.sp),
                PlanListTile(
                    child: ListTile(
                  contentPadding: EdgeInsets.all(2.sp),
                  onTap: () => Get.to(() => TransactionsMain()),
                  title: Text(
                    "تاریخچه خرید",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  leading: Container(
                    margin: EdgeInsets.only(left: 10.sp, right: 3.sp),
                    child: Image.asset(
                      "assets/images/plan/calendar.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 25.sp,
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget PlanListTile({Widget? child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(7.sp)),
      child: child,
    );
  }
}
