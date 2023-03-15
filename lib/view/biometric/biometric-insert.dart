import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/biometric/biometric.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/getx/target/target-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/select-date/select-date.dart';

class BiometricInsert extends GetView<BiometricGetter> {
  BiometricInsert({Key? key}) : super(key: key) {
    Get.put(BiometricGetter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        surfaceTintColor: Constants.primaryColor,
        title: WidgetSelectDateHome(
            filed: controller.dateSelected,
            afterChange: Get.find<BiometricGetter>()),
        centerTitle: true,
        toolbarHeight: 80,
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        final loading = controller.loading.value;
        final errorData = controller.errorData.value;
        final biometricList = controller.biometricList.value;
        final loadingBtn = controller.loadingBtn.value;
        return loading
            ? Center(
                child: SpinKitThreeBounce(
                  color: Colors.black45,
                  size: 17,
                ),
              )
            : errorData
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "خطا در دریافت داده ها",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          child: Text(
                            "بارگذاری مجدد",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.sp),
                          ),
                          onPressed: () {
                            controller.getBiometricList();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Constants.primaryColor2,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 50),
                              child: Image.asset("assets/images/arrow-top.png"),
                            ),
                            Text(
                              "برای چه روزی میخوای؟",
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(
                                depth: 4,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(5),
                                width: Get.width * 0.9,
                                child: Obx(() {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(
                                        'انتخاب نوع بیومتریک',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: biometricList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: biometricList
                                                    .indexOf(item)
                                                    .toString(),
                                                child: Text(
                                                  item.title.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      offset: Offset(0.0, -12.0),
                                      dropdownDecoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      value:
                                          controller.selected.value.toString(),
                                      onChanged: (dynamic? value) {
                                        print(biometricList[0].title);
                                        controller.unitSelected.value = "";
                                        controller.selected.value =
                                            int.parse(value);
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 40,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: Get.width * 0.9,
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text.rich(
                                TextSpan(
                                    text: "مقدار برحسب",
                                    children: [
                                      TextSpan(text: " "),
                                      TextSpan(
                                          text:
                                              "${biometricList[controller.selected.value].unitFa} (${biometricList[controller.selected.value].unit})")
                                    ],
                                    style: TextStyle(fontSize: 15.sp)),
                              ),
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(
                                depth: 0.5,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                width: Get.width * 0.9,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Colors.black54,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                child: TextFormField(
                                  controller: controller.textEditingController,
                                  autofocus: true,
                                  // onEditingComplete: () {
                                  //   FocusScope.of(context).unfocus();
                                  //   sendData(biometricList);
                                  // },
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "مقدار",
                                      border: InputBorder.none,
                                      suffixIcon: Container(
                                        alignment: Alignment.centerLeft,
                                        child: UnitSelect(
                                            context: context,
                                            unitList: biometricList[
                                                    controller.selected.value]
                                                .unit,
                                            unitListFa: biometricList[
                                                    controller.selected.value]
                                                .unitFa),
                                        width: 170,
                                      ),
                                      contentPadding: EdgeInsets.all(10)),
                                ),
                              ),
                            ),
                            Container(
                                width: Get.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: Constants.primarygradiant,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                margin: EdgeInsets.only(top: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: MaterialButton(
                                    child: loadingBtn
                                        ? SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 17,
                                          )
                                        : Text(
                                            "ذخیره",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                    onPressed: loadingBtn
                                        ? () {}
                                        : () {
                                            sendData(biometricList);
                                          },
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
      }),
    );
  }

  Widget UnitSelect({context, unitList, unitListFa}) {
    final unit = unitList.toString().split("|");
    final unitFa = unitListFa.toString().split("|");
    if (unit.length <= 1) {
      controller.unitSelected.value = unit[0];
    }
    if (controller.unitSelected.value == "") {
      controller.unitSelected.value = unit[0];
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        color: Colors.grey.shade300,
        padding: EdgeInsets.only(right: 3),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'انتخاب نوع',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: unit
                .map((item) => DropdownMenuItem<String>(
                      value: item.toString(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Text(
                          item.toString(),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            offset: Offset(0.0, -12.0),
            dropdownDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            value: controller.unitSelected.value.toString() == ""
                ? unit[0]
                : controller.unitSelected.value.toString(),
            onChanged: (value) {
              controller.unitSelected.value = value.toString();
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      ),
    );
  }

  sendData(biometricList) async {
    if (controller.textEditingController.text.length > 0) {
      await controller.setBiometricAddRecord(
          unit: controller.unitSelected.value.toString(),
          bid: biometricList[controller.selected.value].id,
          amount: int.parse(controller.textEditingController.text.toString()));
      Get.find<PersonTargetGeter>().me();
      Get.find<PersonTargetGeter>().getUserTarget(["days", 1]);
      Get.find<HomeGetter>()
          .getAllApi(Get.find<HomeGetter>().dateSelected.value);
      Get.back();
    } else {
      Fluttertoast.showToast(msg: "لطفا مقدار را وارد کنید");
    }
  }
}
