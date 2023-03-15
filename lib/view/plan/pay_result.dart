import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/model/plan/transactions_model.dart';
import 'package:salamatiman/utils/constants.dart';

import 'transactions/transactions_tile.dart';

class PayResult extends GetView<PlansGetx> {
  final link;

  PayResult({Key? key, required this.link}) : super(key: key) {
    Get.lazyPut(() => PlansGetx());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final id = link.toString().split("/").last;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close)),
      ),
      body: Center(
        child: Obx(() {
          if (controller.plansLoding.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "لطفا صبر کنید",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                SpinKitThreeBounce(
                  color: Colors.black45,
                  size: 17,
                ),
              ],
            );
          }

          if (controller.transactions.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "خطا در دریافت نتیجه پرداخت \n لطفا با پشتیبانی تماس بگیر",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                        color: Constants.secondaryColor,
                      ),
                      Text(
                        "بازگشت",
                        style: TextStyle(
                            color: Constants.secondaryColor, fontSize: 19),
                      ),
                    ],
                  ),
                )
              ],
            );
          }

          final List<TransactionsModel> transactions = [];
          for (int i = 0; i < controller.transactions.length; i++) {
            if (controller.transactions[i].id.toString() == id.toString()) {
              transactions.add(controller.transactions[i]);
              break;
            }
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (transactions.isNotEmpty) ...[
                  TransactionsTile(
                    transactions: transactions[0],
                  ),
                ],
                if (transactions.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "خطا در دریافت نتیجه پرداخت \n لطفا با پشتیبانی تماس بگیر",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                        color: Constants.secondaryColor,
                      ),
                      Text(
                        "بازگشت",
                        style: TextStyle(
                            color: Constants.secondaryColor, fontSize: 19),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
