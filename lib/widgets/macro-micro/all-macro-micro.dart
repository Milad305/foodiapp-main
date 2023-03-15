import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/utils/constants.dart';

import 'progress_bar_macro.dart';

double sizeW = Get.width;

class AllMacroMicro extends StatelessWidget {
  final data;
  final name;
  final deleteList;
  const AllMacroMicro(
      {Key? key,
      required this.name,
      required this.data,
      required this.deleteList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = data.toList();
    Map<String, dynamic> nutrients = {};
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final name = item["type_fa"].toString();
      if (nutrients.containsKey(name)) {
        List listNutrient = nutrients[name];
        listNutrient.add(item);
        nutrients[name] = listNutrient;
      } else {
        nutrients.addAll({
          name: [item]
        });
      }
    }
    List listKeys = nutrients.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        elevation: 0.0,
        toolbarHeight: 100,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 30.sp),
          child: SingleChildScrollView(
            child: Column(
              children: listKeys.map<Widget>((e) {
                final index = listKeys.indexOf(e);
                final nutrientsList = nutrients[e.toString()];
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        e.toString(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        children: nutrientsList.map<Widget>((item) {

                          return Column(
                            children: [
                              progress(
                                name: item["name"],
                                percentage: item["percentage"],
                                value: item["value"],
                                max: item["max"],
                              ),
                              SizedBox(height: 10.sp),
                              for (int i = 0;
                                  i < item["children"].length;
                                  i++) ...[
                                progress(
                                  name: item["children"][i]["name"],
                                  percentage: item["children"][i]["percentage"],
                                  value: item["children"][i]["value"],
                                  max: item["children"][i]["max"],
                                ),
                                SizedBox(height: 10.sp),
                              ],
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 40.sp)
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget progress({name, percentage, max, value}) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Text(
                "${name}",
                style: TextStyle(fontSize: 17.sp),
                maxLines: 1,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              alignment: Alignment.centerLeft,
              child: Text(
                "%${percentage}".toPersianDigit(),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.sp),
              ),
            )
          ],
        ),
        FractionallySizedBox(
          widthFactor: 1,
          alignment: Alignment.center,
          child: ProgressBarMacroMicro(
            width: ((sizeW) * 0.5 - 20),
            progress: percentage,
            color: percentage >= 99
                ? max != null
                    ? max < value
                        ? Colors.red
                        : Color(0xFF25a456)
                    : Color(0xFF25a456)
                : Color(0xFFf9c925),
          ),
        ),
      ],
    );
  }
}
