import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

import 'nutrients/all-nutrients.dart';

class CalorieProgress3 extends StatelessWidget {
  final nutrient, date, groupId;
  const CalorieProgress3(
      {Key? key,
      @required this.nutrient,
      @required this.date,
      @required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Wrap(
              children: nutrient.map<Widget>((nutrientItem) {
                final myNnutrient = {
                  "name": nutrientItem["name"],
                  "unitName": nutrientItem["unit_name"],
                  "value": nutrientItem["value"],
                  "target": nutrientItem["target"],
                  "percentage": nutrientItem["percentage"],
                  "color": nutrientItem["color"]
                };
                return Container(
                  width: Get.width * 0.45,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: FractionallySizedBox(
                    widthFactor: 0.97,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${myNnutrient['name'].toString().split("(")[0]}",
                                style: TextStyle(fontSize: 16.sp),
                                textAlign: TextAlign.right,
                              ),
                              Text.rich(TextSpan(
                                  text: "${myNnutrient['percentage']}%"
                                      .toString()
                                      .toPersianDigit(),
                                  children: [])),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: Container(
                              height: 10,
                              alignment: Alignment.centerRight,
                              color: Colors.grey.shade300,
                              child: FractionallySizedBox(
                                widthFactor: myNnutrient['percentage'] / 100,
                                child: Container(
                                  height: 10,
                                  color: myNnutrient["percentage"] >= 99
                                      ? myNnutrient["max"] != null
                                          ? myNnutrient["max"] <
                                                  myNnutrient["value"]
                                              ? Colors.red
                                              : Color(0xFF25a456)
                                          : Color(0xFF25a456)
                                      : Color(0xFFf9c925),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 7,
                  children: [
                    Text(
                      "مشاهده همه",
                      style: TextStyle(color: Constants.primaryColor2),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Constants.primaryColor2,
                      size: 17,
                    )
                  ],
                ),
                onTap: () => Get.to(
                  () => AllNutrient(date: date, groupID: groupId),
                  transition: Transition.leftToRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  // final myNnutrient = {
  //   "name": nutrient[index]["name"],
  //   "unitName": nutrient[index]["unit_name"],
  //   "value": nutrient[index]["value"],
  //   "target": nutrient[index]["target"],
  //   "color": nutrient[index]["color"]
  // };
  // MyTable({required List nutrients}) {
  //   List myNutrients = [];
  //   nutrients.map((nutrient) {
  //     myNutrients.add(nutrient);
  //     nutrient['children']
  //         .map((children) => myNutrients.add(children))
  //         .toList();
  //   }).toList();
  //   return Table(
  //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  //     columnWidths: const <int, TableColumnWidth>{
  //       0: IntrinsicColumnWidth(),
  //       1: FlexColumnWidth(),
  //     },
  //     children: myNutrients.map<TableRow>((nutrientItem) {
  //       return MyTableRow(nutrient: nutrientItem);
  //     }).toList(),
  //   );
  // }

  MyTableRow({required nutrient}) {
    Color color = Color(
        int.parse(nutrient['color'].replaceAll('#', ''), radix: 16) +
            0xFF000000);
    return TableRow(
      children: [
        Container(
            width: 80,
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "${nutrient['name']}",
              style: TextStyle(fontSize: 17),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: FractionallySizedBox(
            widthFactor: 0.97,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${nutrient['percentage']}%",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text.rich(TextSpan(
                          text: nutrient['value']
                              .toStringAsFixed(1)
                              .toString()
                              .toPersianDigit(),
                          children: [
                            TextSpan(
                              text: "${nutrient['unitName']}",
                            ),
                          ])),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      height: 10,
                      alignment: Alignment.centerRight,
                      color: Colors.grey.shade300,
                      child: FractionallySizedBox(
                        widthFactor: nutrient['percentage'] / 100,
                        child: Container(
                          height: 10,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
