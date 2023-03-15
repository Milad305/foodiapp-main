import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class AroundWrist extends GetView<AuthGetter> {
  const AroundWrist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .72,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Constants.shadowColor,
              blurStyle: BlurStyle.solid,
              offset: Offset(0, 0),
              blurRadius: 20,
            )
          ]),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right :12.0),
              child: Text("دور مچ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  )),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: RotatedBox(
              quarterTurns: -5,
              child: Container(
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.textFieldBg,
                ),
                child: 
                ListWheelScrollView.useDelegate(
                  itemExtent: 30,
                  diameterRatio: 200,
                  onSelectedItemChanged: (val) {
                    controller.aroundTheWrist(val + 10);
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 41,
                      builder: (context, index) {
                        return RotatedBox(
                          quarterTurns: 1,
                          child: Obx(() => Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      height:25,
                                      color: Colors.grey,
                                    ),
                                    controller.aroundTheWrist.value ==
                                            (index + 10)
                                        ? Container(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              (index + 10)
                                                  .toString()
                                                  .toPersianDigit(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Constants.secondaryColor,
                                              ),
                                            ),
                                          )
                                        : Text((index + 10)
                                            .toString()
                                            .toPersianDigit(),
                                             style: TextStyle(
                                                fontSize: 16,
                                                color: Constants.secondaryColor,)
                                            ),

                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              ),
            ),
          ),
        
        
        ],
      ),
    );
  }
}
