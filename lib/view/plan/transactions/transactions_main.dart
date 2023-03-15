import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';

import 'transactions_tile.dart';

class TransactionsMain extends GetView<PlansGetx> {
  TransactionsMain({Key? key}) : super(key: key) {
    Get.lazyPut(() => PlansGetx());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        title: Text("تراکنش ها"),
        centerTitle: true,
        toolbarHeight: 110,
      ),
      body: Obx(() {
        if (controller.plansLoding.value) {
          return const Center(
            child: SpinKitThreeBounce(
              color: Colors.black45,
              size: 17,
            ),
          );
        }
        if (controller.transactions.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    " هنوز پرداختی ای نداشتی",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final transactions = controller.transactions[index];
                  return TransactionsTile(transactions: transactions);
                },
              )),
            ],
          ),
        );
      }),
    );
  }
}
