import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/view/food/save-food/save-food.dart';

class FoodList extends GetView<FoodGetter> {
  final index, controller, category;

  const FoodList({
    Key? key,
    required this.index,
    required this.controller,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final active = controller.recipesAccordionActive.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        constraints: BoxConstraints(
          maxHeight: active == index ? 250.sp : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.sp),
          boxShadow: active == index
              ? [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 2.0.sp),
                  ),
                ]
              : [],
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            right: 5.sp,
            left: 5.sp,
            top: 3.sp,
            bottom: 3.sp,
          ),
          child: Scrollbar(
            trackVisibility: true,
            interactive: true,
            scrollbarOrientation: ScrollbarOrientation.right,
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < category.foods!.length; i++) ...[
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                final food = category.foods![i];
                                SaveFoodBox.show(
                                  context: context,
                                  food: food,
                                  controller: controller,
                                  forSaveRecipes: true,
                                  groupTitle: "",
                                  btnTitle: "افزودن",
                                );
                              },
                              child: DottedBorder(
                                customPath: category.foods!.length != i
                                    ? i == 0
                                        ? (size) => Path()
                                        : (size) => Path()..lineTo(4000, 0)
                                    : (size) => Path(),
                                strokeCap: StrokeCap.butt,
                                borderType: BorderType.RRect,
                                dashPattern: const [5, 6],
                                color: Colors.grey.shade600,
                                child: Container(
                                  width: double.infinity,
                                  height: 45.sp,
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width - 110.sp,
                                        child: Text(
                                          "${category.foods![i].shortTitle}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: category.foods![i].favorite
                                              ? Icon(Icons.favorite)
                                              : Icon(Icons.favorite_border))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
