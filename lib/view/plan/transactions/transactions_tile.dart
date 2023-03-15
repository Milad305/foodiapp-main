import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/model/plan/transactions_model.dart';
import 'package:salamatiman/utils/constants.dart';

class TransactionsTile extends StatelessWidget {
  final TransactionsModel transactions;
  const TransactionsTile({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeW = Get.width * 0.90;
    final sizeH = 340.0;

    // time and date
    final createdAt = transactions.createdAt.toString().split("T");
    final date = createdAt[0];
    final time = createdAt[1].toString().split(".")[0];
    //gateway image and name
    final gatewayNameIndex =
        Constants.planPay.indexOf(transactions.gateway.toString());
    final gatewayEnName = transactions.gateway.toString();
    final gatewayFaName = Constants.planFaPay[gatewayNameIndex];
    return Center(
      child: Container(
        width: sizeW,
        height: sizeH,
        alignment: Alignment.center,
        decoration: BoxDecoration(),
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: sizeW - 50,
                height: sizeH - 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      child: Text(
                        transactions.status == "1"
                            ? "پرداخت موفق"
                            : "پرداخت ناموفق",
                        style: TextStyle(fontSize: 25.sp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 2),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "تاریخ",
                                      style: TextStyle(
                                          fontSize: 19.sp,
                                          color: Colors.black87),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "$date".toPersianDate(),
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "زمان",
                                      style: TextStyle(
                                          fontSize: 19.sp,
                                          color: Colors.black87),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "$time",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "پرداخت شده با",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: Colors.black87.withOpacity(0.7),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "پرداخت امن: ${gatewayFaName}",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: Colors.black54.withOpacity(0.4),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/images/pay/${gatewayEnName}.png',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: (sizeW / 2) - 25,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: transactions.status == "1"
                      ? Color(0xFF7fcd79)
                      : Color(0xFFf33d75),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 4, color: Colors.white),
                ),
                child: Icon(
                  transactions.status == "1" ? Icons.check : Icons.clear,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              top: (sizeH - 120) / 2,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "------------------------------------------------------------------------",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -25,
              top: (sizeH - 110) / 2,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned(
              right: -25,
              top: (sizeH - 110) / 2,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
