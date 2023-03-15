import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/plan/plan.dart';
import 'package:salamatiman/utils/constants.dart';

class DurationTile extends GetView<PlansGetx> {
  const DurationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final planDuration = controller.planDuration.value;
      return SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            controller.planDuration(planDuration);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
            padding: EdgeInsets.all(5),
            child: DropdownButton2(
              dropdownDecoration: BoxDecoration(
                border: Border.all(width: 0, color: Colors.transparent),
              ),
              buttonDecoration: BoxDecoration(
                border: Border.all(width: 0, color: Colors.transparent),
              ),
              buttonPadding: EdgeInsets.all(0),
              buttonHeight: 25,
              underline: Container(),
              isExpanded: true,
              value: Constants.planDuration[planDuration],
              items: Constants.planDuration
                  .map((item) => DropdownMenuItem<String>(
                        value: "$item",
                        child: Text(item.toString().toPersianDigit()),
                      ))
                  .toList(),
              onChanged: (val) {
                final indexOf = Constants.planDuration.indexOf(val.toString());
                controller.planDuration(indexOf);
              },
            ),
          ),
        ),
      );
    });
  }
}

/*
Obx(() {
      final planDuration = controller.planDuration.value;
      return SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            controller.planDuration(duration);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 7),
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  margin: const EdgeInsets.only(left: 7),
                  decoration: BoxDecoration(
                    color: planDuration == duration
                        ? const Color(0xFFe36436)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        Border.all(color: const Color(0xFFe36436), width: 1.2),
                  ),
                ),
                Text(
                  title.toString().toPersianDigit(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    })
* */
