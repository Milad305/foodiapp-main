import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

class MySubscriptionTile extends StatelessWidget {
  String name = "";
  final subscription;

  MySubscriptionTile({Key? key, required this.subscription, this.name = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forBazzar = Constants.forBazzar;

    final active = forBazzar
        ? true
        : subscription.status == "active"
            ? true
            : false;

    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 115.sp,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: active ? Colors.green.shade300 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      active
                          ? "اشتراک فعال ${forBazzar ? name : subscription.title}"
                          : "اشتراک غیرفعال ${forBazzar ? name : subscription.title}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "فعال سازی در: ${forBazzar ? new DateTime.fromMicrosecondsSinceEpoch(subscription.purchaseTime * 1000).toPersianDate().toString() : subscription.startedAt.toString().split(" ")[0].toPersianDate()}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (forBazzar == false) ...[
            Positioned(
              top: 0,
              left: 5,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: active ? Colors.green.shade200 : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${subscription.duration}".toPersianDigit(),
                        style: TextStyle(fontSize: 25)),
                    Text("ماه", style: TextStyle(fontSize: 17))
                  ],
                )),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
