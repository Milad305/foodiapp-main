import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/model/food/category-list.dart';

class BoxListCategory extends GetView<FoodGetter> {
  final title, group;
  const BoxListCategory({Key? key, required this.title, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final category = controller.categorys.value;
      return SizedBox(
        height: double.infinity,
        child: CategoryList(
            categorys: controller.categorys, title: title, group: group),
      );
    });
  }
}
