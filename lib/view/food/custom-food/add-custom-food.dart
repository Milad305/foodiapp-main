import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/custom-food/custom-food.dart';
import 'package:salamatiman/utils/constants.dart';

class AddCustomFood extends GetView<CustomFood> {
  AddCustomFood({Key? key}) : super(key: key) {
    Get.put(CustomFood());
  }

  Map<String, dynamic> listFormField = {
    "0": [
      {"title": "یک لیوان", "size": "100"}
    ],
    "1": [
      {"title": "یک لیوان", "size": "100"}
    ]
  };

  List macroList = [
    {"id": 1008, "title": "انرژی", "slug": "energy", "size": "0"},
    {"id": 1005, "title": "کربوهیدرات", "slug": "sugar", "size": "0"},
    {"id": 1004, "title": "چربی", "slug": "fat", "size": "0"},
    {"id": 1003, "title": "پروتئین", "slug": "protein", "size": "0"},
  ];

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.category.isEmpty) {
        return const Scaffold(
          body: Center(
            child: SpinKitThreeBounce(
              color: Colors.black45,
              size: 17,
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(
            " غذای آماده",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: 18.sp, color: Constants.textColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.grey.shade50,
            height: double.infinity,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(7),
                    child: FractionallySizedBox(
                      widthFactor: 0.96,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            width: Get.width / 1.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Constants.shadeColor,
                                    blurRadius: 10,
                                    offset: Offset(0, 5))
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTile(child: Input()),
                                  SizedBox(height: 10.sp),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "دسته بندی",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Constants.textColor),
                                      ),
                                      CustomDropdownButton(),
                                    ],
                                  ),
                                  Obx(() {
                                    final listFormFieldString =
                                        controller.listFormField.value;
                                    return Padding(
                                      padding: EdgeInsets.only(top: 8.0.sp),
                                      child: amountCedar(),
                                    );
                                  }),
                                  SizedBox(
                                    height: 10.sp,
                                  )
                                ]),
                          ),
                          SizedBox(height: 20.sp),
                          Container(
                            width: Get.width / 1.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Constants.shadeColor,
                                    blurRadius: 10,
                                    offset: Offset(0, 5))
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(() {
                            final listFormFieldString2 =
                                controller.listFormField.value.toString();
                            return MyTile(child: MacroList());
                          }),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              if (controller.foodTitle.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "عنوان غذا یادت رفته");
                                scrollController.jumpTo(0.0);
                              } else {
                                final foodTitle = controller.foodTitle.value;
                                final thisCategory = controller.category[
                                    controller.categorySelected.value];
                                ///////
                                final servType = controller.servType.value;
                                final listserv = listFormField;

                                Map<String, dynamic> food = {
                                  "title": foodTitle.toString(),
                                  "category": thisCategory.id,
                                  "notes": "بدون یادداشت"
                                };

                                List portions = [
                                  // {
                                  //   "amount": 1,
                                  //   "modifier": "g",
                                  //   "gram_weight": 0
                                  // }
                                ];
                                //listserv.map( (e,v)=> portions.add(e) );
                                for (var i = 0; i < listserv.length; i++) {
                                  portions.add({
                                    "amount": 1,
                                    "modifier": listserv[i.toString()][i]
                                            ['title']
                                        .toString(),
                                    "gram_weight": double.parse(
                                        listserv[i.toString()][i]['size']
                                            .toString())
                                  });
                                }

                                List nutrients = [];
                                macroList
                                    .map((e) => nutrients.add(
                                        {"id": e["id"], "value": e["size"]}))
                                    .toList();
                                //macroList
                                controller.saveFood(
                                    food: food,
                                    portions: portions,
                                    nutrients: nutrients);
                              }
                            },
                            child: Obx(() {
                              return Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: Constants.primarygradiant,
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                alignment: Alignment.center,
                                child: controller.btnLoading.value == false
                                    ? Text(
                                        "ذخیره غذا",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19.sp),
                                      )
                                    : SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 19,
                                      ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget MyTile({required child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      child: child,
    );
  }

  Widget ServType() {
    return Container(
      width: Get.width / 2,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Constants.shadeColor, blurRadius: 10, offset: Offset(0, 5))
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        height: 40,
        child: Obx(() {
          return DropdownButton(
            key: Key("servDropdown"),
            borderRadius: BorderRadius.circular(8),
            underline: Container(),
            icon: ImageIcon(
              AssetImage("assets/images/sss.png"),
              size: 15,
              color: Constants.secondaryColor,
            ),
            isExpanded: true,
            style: TextStyle(
                fontSize: 12.sp,
                color: Constants.textColor,
                fontFamily: Constants.primaryFontFamilyAdad),
            value: controller.servType.value,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text("براساس میزان سروینگ"),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text("براساس وزن"),
              ),
            ],
            onChanged: (val) {
              controller.servType(int.parse(val.toString()));
            },
          );
        }),
      ),
    );
  }

  Widget WidgetTitle({required String title}) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Text(
        "$title",
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }

  Widget amountCedar() {
    return Obx(() {
      final servType = controller.servType.value;
      final listserv = listFormField[servType.toString()];
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "میزان سرو",
                style: TextStyle(fontSize: 13.sp),
              ),
              ServType(),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1,
                      color: Constants.shadeColor,
                      style: BorderStyle.solid)),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FixedColumnWidth(240),
                2: FixedColumnWidth(35),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              textBaseline: TextBaseline.ideographic,
              children: <TableRow>[
                TableRow(children: [
                  Column(children: [
                    Text('مقیاس',
                        style: TextStyle(
                            fontSize: 12.0.sp, color: Constants.textColor))
                  ]),
                  Column(children: [
                    Text(servType == 0 ? 'میزان در سرو' : 'گرم',
                        style: TextStyle(
                            fontSize: servType == 0 ? 12.0.sp : 12.0.sp))
                  ]),
                  Column(
                      children: [Text('', style: TextStyle(fontSize: 17.0))]),
                ]),
                for (var i = 0;
                    i < listFormField[servType.toString()].length;
                    i++) ...[
                  TableRow(children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 5),
                        child: CustomInputForLoop(
                            val: listserv[i]["title"],
                            index: i,
                            servType: servType,
                            type: "title"),
                      )
                    ]),
                    CustomInputForLoop(
                        val: listserv[i]["size"],
                        index: i,
                        servType: servType,
                        type: "size"),
                    Column(children: [
                      GestureDetector(
                        onTap: () {
                          if (i != 0) {
                            listFormField[servType.toString()]
                                .remove(listFormField[servType.toString()][i]);
                            controller.listFormField(listFormField.toString());
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      )
                    ]),
                  ]),
                ],
              ],
            ),
          ),
          SizedBox(height: 7),
          GestureDetector(
            child: Container(
              width: Get.width / 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  gradient: LinearGradient(
                      colors: Constants.primarygradiant,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Center(
                child: Text(
                  "افزودن+ ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            onTap: () {
              listFormField[servType.toString()]
                  .add({"title": "عنوان مقیاس", "size": "0"});
              controller.listFormField(listFormField.toString());
            },
          )
        ],
      );
    });
  }

  Widget CustomDropdownButton() {
    return Obx(() {
      return DropdownButton2(
        icon: ImageIcon(
          AssetImage("assets/images/sss.png"),
          size: 15,
          color: Constants.secondaryColor,
        ),
        buttonWidth: Get.width / 2,
        buttonPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        buttonDecoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Constants.shadeColor,
                blurRadius: 10,
                offset: Offset(0, 5))
          ],
          borderRadius: BorderRadius.circular(7),
        ),
        underline: Container(),
        isExpanded: true,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        value: controller.categorySelected.value,
        items: controller.category.map((element) {
          final index = controller.category.indexOf(element);
          return DropdownMenuItem(
            value: index,
            child: Text(
              "${element.title}",
              style: TextStyle(fontSize: 12.sp),
            ),
          );
        }).toList(),
        onChanged: (val) {
          controller.categorySelected(int.parse(val.toString()));
        },
      );
    });
  }

  Widget CustomInputForLoop(
      {required val, required index, required servType, required type}) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        border: InputBorder.none,
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 12.sp, fontFamily: Constants.primaryFontFamilyAdad),
      controller: TextEditingController(text: val),
      onChanged: (val) {
        try {
          if (val.toString().isNotEmpty) {
            listFormField[servType.toString()][index][type] = val.toString();
          } else {
            if (type == "size") {
              listFormField[servType.toString()][index][type] = 1.toString();
            }
          }
          //controller.listFormField(listFormField.toString());
        } catch (e) {}
      },
    );
  }

  Widget Input() {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textDirection: TextDirection.rtl,
            maxLines: 1,
            scrollPadding: EdgeInsets.all(0),
            decoration: InputDecoration(
              hintText: "عنوان غذا...",
              hintStyle:
                  TextStyle(color: Constants.shadeColor, fontSize: 14.sp),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.shadeColor, width: 1),
                borderRadius: BorderRadius.circular(7),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.shadeColor, width: 1),
                borderRadius: BorderRadius.circular(7),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                gapPadding: 0,
              ),
            ),
            style: TextStyle(
              color: Colors.black54,
            ),
            cursorColor: Colors.black54,
            onChanged: (val) {
              controller.foodTitle(val.toString());
            },
          ),
        ),
      ],
    );
  }

  Widget MacroList() {
    return Container(
      width: Get.width / 1.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Constants.shadeColor,
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
      child: Column(
        children: [
          WidgetTitle(title: 'ماکرو'),
          Divider(
            color: Constants.shadeColor,
            indent: Get.width / 17,
            endIndent: Get.width / 17,
            thickness: 1,
          ),
          SizedBox(
            height: Get.height / 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("مغذی‌ها در ",
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.right),
              Container(
                width: 0,
                /*
                width: 60,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.black54),
                  borderRadius: BorderRadius.circular(50),
                ),+*/
                child: /*TextFormField(
                  controller: TextEditingController(text: '1'),
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: Constants.primaryFontFamilyAdad),
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    isDense: true,
                  ),
                  onChanged: (val) {
                    if (val.length > 0) {
                      if (int.parse(val.toString()) < 1) {
                        controller.customSize(1);
                      } else {
                        controller.customSize(int.parse(val.toString()));
                      }
                    } else {
                      controller.customSize(1);
                    }
                  },
                )*/
                    Container(),
              ),
              Obx(() {
                final servType = controller.servType.value;
                final listserv = listFormField[servType.toString()];
                return Container(
                  width: Get.width / 2,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Constants.shadeColor,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ]),
                  child: DropdownButton(
                    icon: ImageIcon(
                      AssetImage("assets/images/sss.png"),
                      size: 15,
                      color: Constants.secondaryColor,
                    ),
                    key: Key("dropdownMacroList"),
                    borderRadius: BorderRadius.circular(8),
                    underline: Container(),
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: Constants.textColor,
                        fontFamily: Constants.primaryFontFamilyAdad),
                    value: controller.macroTypeSelected.value,
                    items: [
                      for (var i = 0; i < listserv.length; i++) ...[
                        DropdownMenuItem(
                          value: i,
                          child: Text(
                              "${listserv[i]["title"]}(${listserv[i]["size"]})"),
                        ),
                      ],
                      DropdownMenuItem(
                        value: listserv.length,
                        child: Text("g(1)"),
                      ),
                    ],
                    onChanged: (val) {
                      controller.macroTypeSelected(int.parse(val.toString()));
                    },
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.38,
                        alignment: Alignment.center,
                        child: Text(""),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.38,
                        alignment: Alignment.center,
                        child: Text(
                          "میزان",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.23,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                for (var i = 0; i < macroList.length; i++) ...[
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: i % 2 == 0
                          ? Colors.grey.shade100
                          : Colors.transparent,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.38,
                          child: Text(
                            "${macroList[i]["title"]}",
                            style: TextStyle(
                                fontSize: 13.sp, color: Constants.textColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.38,
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              child: TextFormField(
                                controller: TextEditingController(
                                    text: macroList[i]["size"].toString()),
                                textDirection: TextDirection.ltr,
                                textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none,
                                  fillColor: Colors.red,
                                  isDense: true,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: Constants.primaryFontFamilyAdad,
                                ),
                                scrollPadding: EdgeInsets.all(3),
                                maxLines: 1,
                                autofocus: false,
                                onChanged: (val) {
                                  if (val.length > 0) {
                                    if (int.parse(val.toString()) < 1) {
                                      macroList[i]["size"] = 1;
                                    } else {
                                      macroList[i]["size"] =
                                          int.parse(val.toString());
                                    }
                                  } else {
                                    macroList[i]["size"] = 1;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.23,
                          alignment: Alignment.centerLeft,
                          child: Obx(() {
                            final customSize = controller.customSize.value;
                            final servType = controller.servType.value;
                            final listserv = listFormField[servType.toString()];
                            final isGeram =
                                controller.macroTypeSelected.value ==
                                    listserv.length;

                            var listservSize = 0;
                            if (listserv.length >
                                controller.macroTypeSelected.value) {
                              listservSize = int.parse(
                                  listserv[controller.macroTypeSelected.value]
                                          ["size"]
                                      .toString());
                            } else {
                              listservSize = 1;
                            }

                            //controller.macroTypeSelected.value,listserv
                            final finalSize =
                                ((int.parse(macroList[i]["size"].toString())) *
                                        listservSize) /
                                    100;
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                "${finalSize.toString()}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: Constants.primaryFontFamilyAdad,
                                    fontSize: 18.sp),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
