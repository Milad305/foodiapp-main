import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/nutrient/nutrient.dart';
import 'package:salamatiman/utils/constants.dart';

class AllNutrient extends GetView<NutrientGetter> {
  final date, groupID;
  AllNutrient({Key? key, @required this.date, @required this.groupID})
      : super(key: key) {
    Get.put(NutrientGetter());
    controller.getNotrient(date: date, groupID: groupID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => controller.nutrient.isEmpty && controller.loading.value
          ? Center(
              child: SpinKitThreeBounce(
                color: Colors.black45,
                size: 17.sp,
              ),
            )
          : controller.nutrient.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("چیزی یافت نشد", style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Wrap(
                          children: [
                            Icon(
                              Icons.replay_sharp,
                              color: Constants.primaryColor2,
                            ),
                            GestureDetector(
                              onTap: () => controller.getNotrient(
                                  date: date, groupID: groupID),
                              child: Text(
                                "تلاش مجدد",
                                style: TextStyle(
                                    color: Constants.primaryColor2,
                                    fontSize: 19),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: controller.nutrient.length,
                      itemBuilder: (context, index) {
                        final myNutrient = controller.nutrient[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            index != 0 ? SizedBox(height: 40.sp) : Container(),
                            Header("${myNutrient[0]['type_fa']}"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: myNutrient.map<Widget>((item) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    NutrientProgress(
                                        percentage: item["percentage"],
                                        title: item["name"],
                                        value: item["value"],
                                        unit_name: item["unit_name"]),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: item['children']
                                          .map<Widget>((children) {
                                        return NutrientProgress(
                                            percentage: children["percentage"],
                                            title: children["name"],
                                            value: children["value"],
                                            unit_name: children["unit_name"]);
                                      }).toList(),
                                    )
                                  ],
                                );
                              }).toList(),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )),
    );
  }

  Header(title) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title.toString(),
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget NutrientProgress(
      {required percentage,
      required title,
      required value,
      required unit_name}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  (title.toString()).length > 25
                      ? (title.toString()).substring(0, 25) + "..."
                      : (title.toString()),
                  style: TextStyle(fontSize: 17),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text.rich(TextSpan(
                    text: value.toStringAsFixed(2).toString().toPersianDigit(),
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(text: " "),
                      TextSpan(
                          text: unit_name.toString(),
                          style: TextStyle(fontSize: 14))
                    ])),
              ],
            ),
          ),
          Container(
            height: 10,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: percentage / 100,
                valueColor: AlwaysStoppedAnimation<Color>(
                    percentage >= 100 ? Color(0xFF25a456) : Color(0xFFffa500)),
                backgroundColor: Color(0xffD6D6D6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
