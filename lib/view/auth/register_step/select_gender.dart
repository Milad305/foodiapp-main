import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';

class SelectGender extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const SelectGender({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          children: [
            Wrap(
              children: [
                SizedBox(
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      controller.gender(0);
                    },
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.all(2),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Constants.textBtnColor),
                            groupValue: controller.gender.value,
                            value: 0,
                            onChanged: (val) {
                              controller.gender(val);
                            },
                          ),
                          const Text('مرد',
                              style: TextStyle(
                                  color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      controller.gender(1);
                    },
                    child: SizedBox(
                      width: 80,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Constants.textBtnColor),
                            groupValue: controller.gender.value,
                            value: 1,
                            onChanged: (val) {
                              controller.gender(val);
                            },
                          ),
                          const Text(
                            'زن',
                            style: TextStyle(
                                color:Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        //////
        Obx(() => controller.gender.value >= 1
            ? Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.gender(2);
                  },
                  child: Container(
                    width: 85,
                    padding: EdgeInsets.all(2),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Constants.textBtnColor),
                          groupValue: controller.gender.value,
                          value: 2,
                          onChanged: (val) {
                            controller.gender(val);
                          },
                        ),
                        const Text('باردار',
                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 15))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.gender(3);
                  },
                  child: Container(
                    width: 90,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Constants.textBtnColor),
                          groupValue: controller.gender.value,
                          value: 3,
                          onChanged: (val) {
                            controller.gender(val);
                          },
                        ),
                        const Text(
                          'شیرده',
                          style: TextStyle(
                              color:  Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
            : Text('')),
      ],
    ));
  }
}
