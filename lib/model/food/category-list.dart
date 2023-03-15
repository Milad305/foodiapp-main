import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/accordion/accordion_getter.dart';
import 'package:salamatiman/model/food/food-category.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/food-tile.dart';
import 'package:salamatiman/widgets/accordion/accordion.dart';

class CategoryList extends GetView<AccordionGetter> {
  final List<FoodCategoryModel> categorys;
  final title;
  final group;
  const CategoryList(
      {Key? key,
      required this.categorys,
      required this.title,
      required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categorys.length,
              itemBuilder: (context, index) {
                final categoryTitle = categorys[index].title;
                List foods = categorys[index].foods!;
                final List uniqueList = Set.from(foods).toList();
                return foods.isNotEmpty
                    ? CustomAccordion(
                        index: index,
                        title: Text(
                          categoryTitle.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Constants.textColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        children: foods.isNotEmpty
                            ? foods.map<Widget>((item) {
                                var indexFood = uniqueList.indexOf(item);
                                return Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: FoodTile(
                                      group: group,
                                      food: categorys[index].foods![indexFood],
                                      groupTitle: title,
                                      isShowImage: false),
                                );
                              }).toList()
                            : [Container()],
                        titleDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 0.0,
                              blurRadius: 5.0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (controller.ItemActive.value == "-1") {
                            controller.ItemActive(index.toString());
                          } else {
                            if (controller.ItemActive.value ==
                                index.toString()) {
                              controller.ItemActive("-1");
                            } else {
                              controller.ItemActive(index.toString());
                            }
                          }
                        },
                        itemsDecoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                      )
                    : Container();
              },
            ))
      ],
    );
  }
}
