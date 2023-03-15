import 'package:flutter/material.dart';
import 'package:salamatiman/widgets/datepicker/flutter_datepicker.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/select_date_getter.dart';

abstract class SelectDate extends GetView<SelectDateGetter> {
  const SelectDate({Key? key}) : super(key: key);

  static show() {
    Get.dialog(
        GetBuilder<SelectDateGetter>(
            init: SelectDateGetter(),
            builder: (controller) {
              return Container(
                width: Get.width,
                height: Get.height,
                padding: EdgeInsets.all(10),
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: Get.width * 0.8,
                    height: 350,
                    child: Column(
                      children: [
                        Center(
                          child: WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              content: Center(
                                  child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: LinearDatePicker(
                                  isJalaali: true,
                                  showDay: true,
                                  showMonthName: true,
                                  labelStyle: TextStyle(color: Colors.red),
                                  dateChangeListener: (String selectedDate) {
                                    ///controller.dateSelected.value = selectedDate;
                                  },
                                ),
                              )),
                            ),
                          ),
                        ),
                        MaterialButton(
                          child: Text("تایید"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        barrierDismissible: false,
        useSafeArea: true);
  }
}
