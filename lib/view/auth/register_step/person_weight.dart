import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

class PersonWeight extends GetView<AuthGetter> {
  final customDecoratedBox;
  PersonWeight({Key? key, required this.customDecoratedBox}) : super(key: key);
  @override
  List<String> personByGeram = [
    '0',
    '100',
    '200',
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: Get.width,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: customDecoratedBox,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "وزن",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 96,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Constants.textSelected.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Obx(() => Text(
                            (controller.personWeightKilo.value)
                                .toString()
                                .toPersianDigit(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'کیلو گرم',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, right: 0),
                  child: Container(
                    width: 75,
                    padding:
                        EdgeInsets.only(left: 5, right: 15, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 234, 239, 250),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: personByGeram.length > 0
                        ? Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('گرم'),
                                DropdownButton<String>(
                                  isDense: true,
                                  borderRadius: BorderRadius.circular(7),
                                  value: controller.personWeight.value,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    controller.personWeight(newValue);
                                  },
                                  items: personByGeram
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ))
                        : Text(""),
                  ),
                ),
                Container(
                  width: Get.width - 150,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 234, 239, 250),
                      borderRadius: BorderRadius.circular(9)),
                  height: 60,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 30,
                      diameterRatio: 200,
                      onSelectedItemChanged: (val) {
                        controller.personWeightKilo(val + 1);
                      },
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 200,
                          builder: (context, index) {
                            return RotatedBox(
                              quarterTurns: 1,
                              child: Obx(() => Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 2,
                                          height: 25,
                                          color: Colors.grey,
                                        ),
                                        controller.personWeightKilo.value ==
                                                (index + 1)
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(top: 8),
                                                child: Text(
                                                  (index + 1)
                                                      .toString()
                                                      .toPersianDigit(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Constants.textSelected,
                                                  ),
                                                ),
                                              )
                                            : Text((index + 1)
                                                .toString()
                                                .toPersianDigit()),
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
