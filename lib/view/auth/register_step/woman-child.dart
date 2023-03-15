import 'package:flutter/material.dart';
import 'package:salamatiman/utils/constants.dart';

abstract class WomanChild {
  //برای بارداری
  static List<String> pregnancyItem = [
    'سه ماه اول',
    'سه ماه دوم',
    'سه ماه سوم'
  ];
  static Pregnancy(controller) => Container(
        height: 40,
        alignment: Alignment.center,
        child: DropdownButton<String>(
          isDense: true,
          borderRadius: BorderRadius.circular(7),
          value: controller.pregnancy.value.toString(),
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 0,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            controller.pregnancy(newValue);
            controller
                .pregnancyID(pregnancyItem.indexOf(newValue.toString()) + 1);
          },
          items: pregnancyItem.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toString(),
                style: TextStyle(
                    fontSize: 17, fontFamily: Constants.primaryFontFamily),
              ),
            );
          }).toList(),
        ),
      );

  //شیردهی
  static List<String> breastfeedingItem = ['شش ماه اول', 'شش ماه دوم'];
  static Breastfeeding(controller) => Container(
        height: 40,
        alignment: Alignment.center,
        child: DropdownButton<String>(
          isDense: true,
          borderRadius: BorderRadius.circular(7),
          value: controller.breastfeeding.value.toString(),
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 0,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            controller.breastfeeding(newValue);
            controller.breastfeedingID(
                breastfeedingItem.indexOf(newValue.toString()) + 1);
          },
          items:
              breastfeedingItem.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toString(),
                style: TextStyle(
                    fontSize: 17, fontFamily: Constants.primaryFontFamily),
              ),
            );
          }).toList(),
        ),
      );
}
