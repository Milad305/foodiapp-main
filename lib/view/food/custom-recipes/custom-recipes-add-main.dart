import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/recipes.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/food-stuffs-list.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/food-stuffs.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/macro.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/recipes-title.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/serv.dart';

class CustomRecipesAddMain extends GetView<RecipesGetter> {
  CustomRecipesAddMain({Key? key}) : super(key: key) {
    Get.put(RecipesGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.getCategorysNoFood();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "افزودن دستور پخت شخصی",
          style: TextStyle(
            fontSize: 18.sp,
            color: Constants.textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Obx(() {
        if (controller.categorys.isEmpty) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.grey.shade700,
              size: 18.sp,
            ),
          );
        }
        return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.sp),
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
                      ]),
                  child: Column(children: [
                    SizedBox(height: 15.sp),
                    const RecipesTitle2(),
                    SizedBox(height: 10.sp),
                    Obx(() {
                      final categorys = controller.categorys;
                      if (categorys.isEmpty) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        width: Get.width / 1.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("دسته بندی"),
                            DropdownButton2(
                              icon: ImageIcon(
                                AssetImage("assets/images/sss.png"),
                                size: 15.sp,
                                color: Constants.secondaryColor,
                              ),
                              buttonWidth: Get.width / 2,
                              buttonPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              buttonDecoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Constants.shadeColor,
                                        blurRadius: 10,
                                        offset: Offset(0, 5))
                                  ]),
                              underline: Container(),
                              isExpanded: true,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              value: controller.categorySelected.value,
                              items: categorys.map((element) {
                                final index = categorys.indexOf(element);

                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    "${element.title}",
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                controller.category(
                                    categorys[int.parse(val.toString())].id);
                                controller.categorySelected(
                                    int.parse(val.toString()));
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 15.sp),
                  ]),
                ),

                //category

                SizedBox(height: 30.sp),
                //foodStuffs
                const FoodStuffs(),
                SizedBox(height: 30.sp),
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
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0.sp, top: 8.sp),
                          child: Text(
                            "ماکرو",
                            style: TextStyle(
                                fontSize: 16.sp, color: Constants.textColor),
                          ),
                        ),
                        Divider(
                          color: Constants.shadeColor,
                          indent: Get.width / 17,
                          endIndent: Get.width / 17,
                        ),
                        Macro(),
                      ],
                    )),
                // Obx(() {
                //   final protein = controller.protein.value;
                //   final fat = controller.fat.value;
                //   final carbohydrate = controller.carbohydrate.value;
                //   final energy = controller.energy.value;
                //   final foodID = controller.foodID.value;
                //   return Column(
                //     children: [
                //       Text('protein: ${protein}'),
                //       Text('fat: ${fat}'),
                //       Text('carbohydrate: ${carbohydrate}'),
                //       Text('energy: ${energy}'),
                //       Text('foodID: ${foodID}'),
                //     ],
                //   );
                // }),
                SizedBox(height: 40.sp),
                Obx(() {
                  if (controller.foods.isNotEmpty) {
                    return Container(
                      width: Get.width / 1.05,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Constants.shadeColor,
                                blurRadius: 10,
                                offset: Offset(0, 5))
                          ]),
                      child: Column(
                        children: [
                          SizedBox(height: 15.sp),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "میزان سرو",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                ServType(),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.sp),
                          ServWidget(),
                          SizedBox(height: 10.sp),
                          Padding(
                            padding: EdgeInsets.only(right: 15.sp),
                            child: GestureDetector(
                              onTap: () {
                                controller.defaultFormValue
                                    .add({"title": "عنوان مقیاس", "size": "0"});
                              },
                              child: Container(
                                width: Get.width / 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  gradient: LinearGradient(
                                      colors: Constants.primarygradiant,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: Center(
                                    child: Text(
                                  "افزودن+",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.sp),
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: [
                      const FoodStuffsList(),
                      SizedBox(height: 30.sp),
                    ],
                  );
                }),
                SizedBox(
                  height: 20.sp,
                )
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
        child: Obx(() {
          final foods = controller.foods;
          return FloatingActionButton(
            isExtended: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                gradient: LinearGradient(
                    colors: foods.isEmpty
                        ? Constants.disablegradiant
                        : Constants.primarygradiant,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              alignment: Alignment.center,
              child: Text(
                "ثبت دستور‌پخت",
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            onPressed: foods.isEmpty
                ? null
                : () {
                    if (controller.category.value == 0) {
                      Fluttertoast.showToast(
                          msg: 'لطفا دسته بندی را انتخاب کنید');
                    } else {
                      List caloriesList = [];
                      try {
                        for (int i = 0; i < foods.length; i++) {
                          caloriesList.add(controller.calories(
                            food: foods[i]['food'],
                            size: double.parse(foods[i]['count'].toString()),
                            portions: foods[i]['portion'],
                          ));
                        }
                      } catch (e) {}

                      ////////////////////////
                      final servingType = controller.servType.value;
                      final serving = controller.defaultFormValue;
                      /////////
                      final ingredients = foods.map((food) {
                        return {
                          "food_id": food['food_id'],
                          "portion_id": food['portion_id'],
                          "count": food['count'],
                        };
                      }).toList();
                      /////////////////////////////
                      final portions = serving.map((serv) {
                        return servingType == 1
                            ? {
                                "amount": 1,
                                "modifier": serv['title'],
                                "gram_weight": serv['size'],
                              }
                            : {
                                "amount": serv['size'],
                                "modifier": serv['title'],
                                "gram_weight": null,
                              };
                      }).toList();
                      print({
                        "ingredients": ingredients,
                        "portions": portions,
                        "weight_based": servingType,
                        "recipe_name": controller.title.value,
                        "recipe_category": controller.category.value,
                      });
                      controller.saveRecipes(
                        portions: portions,
                        ingredients: ingredients,
                        recipe_category: controller.category.value,
                        recipe_name: controller.title.value,
                        weight_based: servingType,
                      );
                    }
                  },
          );
        }),
      ),
    );
  }

  Widget ServType([defaultFormValue]) {
    return Container(
      width: Get.width / 2,
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 7.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 3.0.sp),
          )
        ],
      ),
      child: SizedBox(
        height: 40,
        child: Obx(() {
          return DropdownButton(
            key: defaultFormValue == null
                ? const Key("servDropdownRecipesDefaultFormValue")
                : const Key("servDropdownRecipes"),
            borderRadius: BorderRadius.circular(8),
            underline: Container(),
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 25.sp,
              color: Constants.secondaryColor,
            ),
            isExpanded: true,
            style: TextStyle(
                fontSize: 12.sp,
                color: Constants.textColor,
                fontFamily: Constants.primaryFontFamilyAdad),
            value: controller.servType.value,
            items: defaultFormValue == null
                ? [
                    const DropdownMenuItem(
                      value: 0,
                      child: Text("براساس میزان سروینگ"),
                    ),
                    const DropdownMenuItem(
                      value: 1,
                      child: Text("براساس وزن"),
                    ),
                  ]
                : [
                    for (int i = 0; i < defaultFormValue.length; i++) ...[
                      DropdownMenuItem(
                        value: i,
                        child: Text(defaultFormValue[i]['title'].toString()),
                      )
                    ],
                  ],
            onChanged: (val) {
              if (defaultFormValue == null) {
                controller.servType(int.parse(val.toString()));
              } else {
                controller.defaultFormValueType(int.parse(val.toString()));
              }
            },
          );
        }),
      ),
    );
  }
}
