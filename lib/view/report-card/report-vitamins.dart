import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/accordion/accordion_getter.dart';
import 'package:salamatiman/getx/report-card/report-card.dart';
import 'package:salamatiman/utils/constants.dart';

import '../../widgets/accordion/accordion.dart';
import 'report-vitamins-all.dart';
import 'weeks-average-progress.dart';

class ReportVitamins extends GetView<ReportCardGetter> {
  ReportVitamins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List nutrientsWeeksAveragekeys =
        controller.nutrientsWeeksAverage[0].keys.map((e) => e).toList();
    List myNutrients = [];
    for (var i = 0; i < nutrientsWeeksAveragekeys.length; i++) {
      final key = nutrientsWeeksAveragekeys[i];
      final val =
          controller.nutrientsWeeksAverage[0][nutrientsWeeksAveragekeys[i]];
      final slugKay = controller.nutrientsWeeksAverage[0]
          [nutrientsWeeksAveragekeys[i]][0]["type"];
      myNutrients.add(val);
    }
    return Column(
      children: [ ListView.builder(
         physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: myNutrients.length,
          itemBuilder: (context, index) {
           
          return
           Column(
             children: [
               CustomAccordion(
                
                  index: index,
                  title: Text(
                    "${myNutrients[index][0]["type_fa"]}" ,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16.sp,
                    ),
                  ),
                  
                  children: [  
                    
                         Column(
                           children: [
                             Padding(
                               padding:  EdgeInsets.fromLTRB(Get.width/20,Get.width/40,Get.width/20,0),
                               child: LayoutBuilder(
                builder: (context, constraints) {
                  var lastNutrients = [];
                  if (myNutrients[index].length > 3) {
                    lastNutrients.add(myNutrients[index][0]);
                    lastNutrients.add(myNutrients[index][1]);
                    lastNutrients.add(myNutrients[index][2]);
                    lastNutrients.add(myNutrients[index][3]);
                  } else {
                    lastNutrients.add(myNutrients[index][0]);
                    lastNutrients.add(myNutrients[index][0]["children"][0]);
                    lastNutrients.add(myNutrients[index][0]["children"][1]);
                    lastNutrients.add(myNutrients[index][0]["children"][2]);
                  }

                  List listWidgetWeeksAverageProgress = [];
                  lastNutrients.map((e) {
                    return listWidgetWeeksAverageProgress
                        .add(WeeksAverageProgress(
                      nutrient: e,
                      color: e["percentage"] > 100
                                ? e["value"] > 0
                                    ? "25a456"
                                    : "f9d02a"
                                : e["percentage"] == 100
                                    ? "25a456"
                                    : "f9d02a",
                    ));
                  }).toList();
                  return Column(children: [
                    for (var i = 0;
                        i < listWidgetWeeksAverageProgress.length;
                        i++) ...[listWidgetWeeksAverageProgress[i]]
                  ]);
                },
          ),
                             ),
                           GestureDetector(
                            onTap: () {
                              Get.to(() => ReportVitaminsAll(
                                    myNutrients: myNutrients[index],
                                  ));
                            },
                            child: Text("مشاهده بیشتر",style: TextStyle(color: Colors.blue),))
                           ],
                         ),]
                      
                      ,
                  titleDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 0.0,
                        blurRadius: 5.0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  onTap: () {
                    print(myNutrients[index][0]);
                    if (Get.find<AccordionGetter>().ItemActive.value == "-1") {
                      Get.find<AccordionGetter>().ItemActive(index.toString());
                    } else {
                      if (Get.find<AccordionGetter>().ItemActive.value ==
                          index.toString()) {
                        Get.find<AccordionGetter>().ItemActive("-1");
                      } else {
                        Get.find<AccordionGetter>().ItemActive(index.toString());
                      }
                    }
                  },
                  itemsDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.sp),
                  ),
                )]);
             
           
          
          },
            ),
            SizedBox(height: Get.height/10,)
            ]
    );
  }
}
