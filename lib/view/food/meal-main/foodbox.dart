import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/item-select/item-select.dart';

class FoodBox extends GetView<FoodGetter> {
  final Food;

  const FoodBox({Key? key, required this.Food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Obx(() {
        return FractionallySizedBox(
          widthFactor: 1,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              InkWell(
                onLongPress: () {
                  if (!controller.foodSelected.contains(Food['id'])) {
                    controller.foodSelected.add(Food['id']);
                  } else {
                    controller.foodSelected.remove(Food['id']);
                  }
                  if (controller.foodSelected.isEmpty) {
                    controller
                        .selectForDelete(!controller.selectForDelete.value);
                  }
                },
                child: Dismissible(
                  key: Key(Food["id"].toString()),
                  dragStartBehavior: DragStartBehavior.start,
                  confirmDismiss: (direction) => removeFoodAlert(
                      direction, context, Food["food"]["title"], Food["id"]),
                  behavior: HitTestBehavior.opaque,
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7)),
                    padding: EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      spacing: 4,
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          "حذف کردن",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Icon(Icons.delete_forever),
                  child:Center(
                    child: Container( 
                      height: Get.height/15,
                      width: Get.width/1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10)],

                      ),
                      child:
                       Padding(
                         padding:  EdgeInsets.only(right: Get.width/50),
                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           controller.foodSelected.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  if (controller.foodSelected.value
                                      .contains(Food["id"])) {
                                    controller.foodSelected.remove(Food["id"]);
                                  } else {
                                    controller.foodSelected.add(Food["id"]);
                                  }
                                },
                                child: Align(alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(100)),
                                    child: ItemSelected(
                                      isSelected: controller.foodSelected.value
                                              .contains(Food["id"])
                                          ? true
                                          : false,
                                      back: CheckedIconWidget(),
                                      front: FoodImage(),
                                    ),
                                  ),
                                ),
                              )
                            : FoodImage(),
                            Column(
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              
                              Text(Food["food"]["short_title"].toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 14.sp, color: Constants.textColor,fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl),
                            
                                Row(children: [Text(
                          Food["amount"]
                                  .toStringAsFixed(2)
                                  .toString()
                                  .toPersianDigit() +
                              " ${Food["unit"]}",
                          style: TextStyle(
                              fontSize: 10.sp, color: Constants.textColor),
                          overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 15.sp,),
                         Text(
                          Food["calories"]
                              .toStringAsFixed(2)
                              .toString()
                              .toPersianDigit() + "  کالری",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Constants.textColor),
                      ),
                      ],)
                            ],),
                            
                                   Obx(() {
          return controller.foodSelected.isEmpty
              ? Text("")
              : IconButton(
                  onPressed: () async {
                    return await showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                                title: Column(
                                  children: [
                                    Text(
                                      "حذف غذاها",
                                      style: TextStyle(
                                          fontFamily:
                                              Constants.primaryFontFamily),
                                    ),
                                    SizedBox(height: 15.sp),
                                  ],
                                ),
                                content: Text(
                                  "آیا از حذف غذاها مطمئنی؟",
                                  style: TextStyle(
                                      fontFamily: Constants.primaryFontFamily),
                                ),
                                actions: [
                                  CupertinoButton(
                                    child: Text(
                                      'بله',
                                      style: TextStyle(
                                          fontFamily:
                                              Constants.primaryFontFamily),
                                    ),
                                    onPressed: () async {
                                      if (controller.foodSelected.isNotEmpty) {
                                        var res = await controller.deleteFood(
                                            foodId: controller.foodSelected);
                                        if (res) {
                                          controller.foodSelected([]);
                                        } else {
                                          Get.back();
                                          Fluttertoast.showToast(
                                              msg: "خطا در حذف غذاها");
                                        }
                                      }
                                    },
                                  ),
                                  CupertinoButton(
                                      child: Text(
                                        'خیر',
                                        style: TextStyle(
                                            fontFamily:
                                                Constants.primaryFontFamily),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ],
                              ));
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Constants.dangerColor,
                  ),
                );
        })
                      ],),
                       ),
                    ),
                  )
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  CheckedIconWidget() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.lightBlue,
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  FoodImage() {
    return Food["food"]["img"] == null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/image-placeholder.jpg",
              width: 50,
              height: 50,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              imageUrl: Food["food"]["img"].toString(),
              placeholder: (context, url) =>
                  Image.asset("assets/images/image-placeholder.jpg"),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/image-placeholder.jpg"),
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            ),
          );
  }

  Future<bool> removeFoodAlert(
      DismissDirection direction, context, foodName, foodID) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(
              "آیا میخواهید ${foodName} را حذف کنید",
              style: TextStyle(
                fontFamily: Constants.primaryFontFamily,
                fontSize: 15.sp,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "بله",
                  style: TextStyle(fontFamily: Constants.primaryFontFamily),
                ),
                onPressed: () async {
                  var res = await controller.deleteFood(foodId: foodID);
                  if (res) {
                    Fluttertoast.showToast(msg: "غذا با موفقیت حذف شد");
                  } else {
                    Fluttertoast.showToast(msg: "خطا در حذف غذا");
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'خیر',
                  style: TextStyle(fontFamily: Constants.primaryFontFamily),
                ),
                onPressed: () {
                  // Dismiss the dialog but don't
                  // dismiss the swiped item
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }
}
