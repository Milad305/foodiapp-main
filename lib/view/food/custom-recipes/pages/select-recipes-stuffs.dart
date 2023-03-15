import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/model/food/food-category.dart';
import 'package:salamatiman/view/food/custom-recipes/widgets/food-list.dart';
import 'package:salamatiman/view/food/food-tile%20copy.dart';
import 'package:salamatiman/view/food/serach-box-food.dart';
import 'package:salamatiman/widgets/rotation.dart';

import '../../food-tile.dart';

class SelectRecipesStuffs extends GetView<FoodGetter> {
  final group,title ;
  SelectRecipesStuffs({required this.group,required this.title, Key? key}) : super(key: key) {
    Get.lazyPut(() => FoodGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.getCategorys();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
            final textSearch = controller.controllerSearch.value;
        final cCategorys = controller.categorys;
        if (GetStorage().read('RecipesCategory') == null ||
            cCategorys.isEmpty) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.black87,
              size: 16.sp,
            ),
          );
        }

        List<FoodCategoryModel> categorys = [];
        try {
          List<FoodCategoryModel> itamCategory = [];
          GetStorage()
              .read('RecipesCategory')
              .value
              .map((item) => itamCategory.add(item))
              .toList();
          categorys.addAll(itamCategory);
        } catch (e) {
          categorys = [];
        }
        return SafeArea(
          child: Column(
            children: [
              SizedBox(height: 15.sp),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FoodSearchBox(),
                )),
              Expanded(
                
                child:
                    controller.searchResult.isNotEmpty?
                         
                           ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.searchResult.length,
                              itemBuilder: (context, index) {
                                if (FocusScope.of(context).hasFocus) {
                                  //FocusScope.of(context).unfocus(); 
                                }
                                return FoodTile2(
                                    food: controller.searchResult[index],
                                    group: 1,
                                    groupTitle: "",
                                    isShowImage: true);
                              },
                            ):
                 ListView.builder(
                  itemCount: cCategorys.length,
                  itemBuilder: (context, index) {
                    final category = cCategorys[index];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.sp, horizontal: 10.sp),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final active =
                                  controller.recipesAccordionActive.value;
                              return GestureDetector(
                                onTap: () {
                                  if (active == index) {
                                    controller.recipesAccordionActive(-1);
                                  } else {
                                    controller.recipesAccordionActive(index);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(0.0, 2.0.sp),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.sp,
                                    horizontal: 10.sp,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width - 100,
                                        child: Text(
                                          '${category.title}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: TweenAnimationBuilder(
                                            duration:
                                                const Duration(milliseconds: 400),
                                            curve: Curves.easeOut,
                                            tween: Tween<double>(
                                                begin: 0,
                                                end: active == index
                                                    ? 0.25
                                                    : 0.75),
                                            builder:
                                                (context, dynamic value, child) {
                                              return RotationBox(
                                                child: const Icon(
                                                    Icons.arrow_forward_ios),
                                                rotation: value,
                                              );
                                            }),
                                        onPressed: () {
                                          if (active == index) {
                                            controller.recipesAccordionActive(-1);
                                          } else {
                                            controller
                                                .recipesAccordionActive(index);
                                          }
                                        },
                                        iconSize: 16.sp,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 4.sp),
                          FoodList(
                            index: index,
                            controller: controller,
                            category: category,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
