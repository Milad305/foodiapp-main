import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/utils/constants.dart';

import 'weeks-average-progress.dart';

class ReportVitaminsAll extends GetView<ReportCardGetter> {
  final myNutrients;
  ReportVitaminsAll({Key? key, required this.myNutrients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        title: Text(
          "${myNutrients[0]['name']}",
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        toolbarHeight: 80,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: myNutrients.length,
                itemBuilder: (context, index) {
                  final nutrients = myNutrients[index];
                  return Column(
                    children: [
                      WeeksAverageProgress(
                        nutrient: nutrients,
                        color: nutrients["percentage"] > 100
                            ? nutrients["value"] > 0
                                ? "25a456"
                                : "f9d02a"
                            : nutrients["percentage"] == 100
                                ? "25a456"
                                : "f9d02a",
                      ),
                      for (var i = 0;
                          i < myNutrients[index]["children"].length;
                          i++) ...[
                        WeeksAverageProgress(
                          nutrient: myNutrients[index]["children"][i],
                          color: myNutrients[index]["children"][i]
                                      ["percentage"] >
                                  100
                              ? myNutrients[index]["children"][i]["value"] > 0
                                  ? "25a456"
                                  : "f9d02a"
                              : myNutrients[index]["children"][i]
                                          ["percentage"] ==
                                      100
                                  ? "25a456"
                                  : "f9d02a",
                        ),
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
