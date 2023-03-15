import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/person-selector.dart';
import 'package:salamatiman/model/food/food-model.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/utils/constants.dart';

import '../../service/foods/foods.dart';

class FoodBox extends GetView<FoodGetter> {
  final FoodModel food;
  final group;
  var personSelector;

  FoodBox({Key? key, required this.food, required this.group})
      : super(key: key) {
    personSelector = Get.put(PersonSelector());
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var newDate = DateTime(date.year, date.month, date.day);
    List dateSelected = [];
    var myDate;
    if (personSelector.date.value != "") {
      dateSelected = personSelector.date.value.split(' ');
      dateSelected = dateSelected[0].split('-');
      myDate = DateTime(int.parse(dateSelected[0]), int.parse(dateSelected[1]),
          int.parse(dateSelected[2]));
    }
    final personTimeSelected = dateSelected.isEmpty ? newDate : myDate;
    return Container(
      width: Get.width * 0.4,
      margin: const EdgeInsets.only(bottom: 40),
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 30,
            bottom: 15,
            right: 0,
            left: 0,
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  depth: 3,
                  lightSource: LightSource.top,
                  color: Colors.white),
              child: Container(
                color: Colors.white,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Container(
                        width: double.infinity,
                        height: 40,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(food.title.toString(),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(100)),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.black54),
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                child: food.img != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/image-placeholder.jpg",
                          image: food.img.toString(),
                          fit: BoxFit.fitHeight,
                          height: 80,
                          width: 80,
                        ),
                      )
                    : Image.asset(
                        "assets/images/image-placeholder.jpg",
                        fit: BoxFit.fitHeight,
                        height: 80,
                        width: 80,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () => FoodAddBottomSheet(
                          context, personTimeSelected, group),
                      child: Icon(Icons.add),
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: Color(0xFF007882),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      child: Icon(Icons.arrow_forward),
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: Color(0xFF007882),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  FoodAddBottomSheet(BuildContext context, personTimeSelected, group) {
    controller.portions("");
    controller.size(1);
    controller.portions.value = "";
    Get.find<FoodGetter>().portions.value = "";
    final portions = food.portions.length > 0 ? food.portions : [];
    List select = [
      {
        "id": 00,
        "fdc_id": 0,
        "amount": "0",
        "modifier": "انتخاب کنید",
        "gram_weight": "0"
      }
    ];

    portions.map((e) => select.add(e)).toList();
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 380,
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                child: Text("بستن"),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 10),
              ),
              onTap: () => Get.back(),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.all(10),
              child: Text(
                " افزودن " + food.title.toString(),
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    child: Text("میزان",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                  ),
                  Container(
                    width: Get.width - 120,
                    child: FoodSizeNumberPicker(),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    child: Text("نوع",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19)),
                  ),
                  Container(
                    width: Get.width - 94,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'انتخاب نوع',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: select
                                .map((item) => DropdownMenuItem(
                                      value: item.toString(),
                                      child: Text(
                                        item["modifier"].toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: controller.portions.value == ""
                                ? select[0].toString()
                                : controller.portions.value,
                            onChanged: (value) {
                              controller.portions.value = value.toString();
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            dropdownElevation: 8,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: SuccessButton(
                      title: "ذخیره غذا",
                      onPressed: () {
                        if (controller.portions.value == "" ||
                            controller.portions.value ==
                                "{id: 0, fdc_id: 0, amount: 0, modifier: انتخاب کنید, gram_weight: 0}") {
                          Fluttertoast.showToast(
                            msg: "لطفا نوع را انتخاب کنید",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else {
                          SetNewFood(personTimeSelected);
                        }
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FoodSizeNumberPicker() {
    return Container(
      width: double.infinity,
      child: Wrap(
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Constants.primaryColor2,
              onPressed: () => controller.increment(),
              child: Icon(Icons.add),
            ),
          ),
          Obx(() => Container(
                height: 40,
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  controller.size.value.toString().toPersianDigit(),
                  style: TextStyle(fontSize: 17),
                ),
              )),
          SizedBox(
            width: 35,
            height: 35,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Constants.dangerColor,
              onPressed: () => controller.decrement(),
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }

  void SetNewFood(personTimeSelected) async {
    var portions = controller.portions.value;
    var size = controller.size.value;

    //time format
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hms().format(now);

    var timeOnlyDate = personTimeSelected.toString().split(' ')[0].split('-');
    var timeOnlyTime = formattedTime.split(':');

    var userDateSelected = DateTime(
        int.parse(timeOnlyDate[0]),
        int.parse(timeOnlyDate[1]),
        int.parse(timeOnlyDate[2]),
        int.parse(timeOnlyTime[0]),
        int.parse(timeOnlyTime[1]),
        int.parse(timeOnlyTime[2]));

    var timestamp = userDateSelected.microsecondsSinceEpoch
        .toString()
        .substring(
            0, userDateSelected.microsecondsSinceEpoch.toString().length - 6);
    // end time format

    ///Portions Format
    var myPortions = portions;
    myPortions = myPortions.replaceAll('{', '');
    myPortions = myPortions.replaceAll('}', '');
    var myPortionsList = myPortions.split(',');
    List myFinalPortionsList = [];
    myPortionsList.map((e) => myFinalPortionsList.add(e.split(':'))).toList();

    ///End Portions Format

    /// This Food Add Object
    var res = await Foods.addFoodRecord(
        data: jsonEncode({
      "portions": {
        "id": myFinalPortionsList[0][1].toString(),
        "fdc_id": myFinalPortionsList[1][1].toString(),
        "amount": myFinalPortionsList[2][1].toString(),
        "count": size.toString(),
        "modifier": myFinalPortionsList[3][1].toString(),
        "gram_weight": myFinalPortionsList[4][1].toString()
      },
      "size": size,
      "time": timestamp,
      "group": group,
      "food": {"id": food.id, "title": food.title, "description": food.title}
    }));

    /// End This Food Add Object

    if (res is Success) {
      if (res.response == '1') {
        Get.back();
      } else if (res is Failure) {
        Fluttertoast.showToast(
          msg: "خطا در ذخیره سازی",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "خطا در ذخیره سازی",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
