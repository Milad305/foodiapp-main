import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/accordion/accordion_getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/widgets/rotation.dart';

class CustomAccordion2 extends GetView<AccordionGetter> {
  final Widget title;
  List<Widget> children = const <Widget>[];
  final Decoration? titleDecoration;
  final Decoration? itemsDecoration;
  final GestureTapCallback? onTap;
  final index;

  CustomAccordion2(
      {Key? key,
      required this.title,
      required this.children,
      this.index,
      this.titleDecoration,
      this.itemsDecoration,
      this.onTap})
      : super(key: key) {
    Get.put(AccordionGetter());
  }

  @override
  Icon trailingIcon = Icon(
    Icons.keyboard_arrow_down_outlined,
    size: 25.sp,
    color: Constants.secondaryColor,
  );
  final Duration? _duration = const Duration(milliseconds: 400);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.sp, left: 10.sp),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: titleDecoration,
            margin: EdgeInsets.only(
              bottom: 0.sp,
              top: 5.sp,
            ),
            child: ListTile(
              dense: true,
              onTap: onTap,
              title: title,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.sp, horizontal: 7.sp),
              trailing: Obx(() {
                var isSelected =
                    int.parse(controller.ItemActive.value) == index;
                return TweenAnimationBuilder(
                    duration: _duration!,
                    curve: Curves.easeOut,
                    tween: Tween<double>(begin: 0, end: isSelected ? 0.5 : 0),
                    builder: (context, dynamic value, child) {
                      return RotationBox(
                        child: trailingIcon,
                        rotation: value,
                      );
                    });
              }),
            ),
          ),
          Obx(() {
            var isSelected = int.parse(controller.ItemActive.value) == 2;

            return AnimatedContainer(
              duration: _duration!,
              height: isSelected ? 280 : 0,
              margin: EdgeInsets.symmetric(horizontal: 0.sp),
              width: double.infinity,
              decoration: itemsDecoration,
              child: isSelected
                  ? Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: children,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: children,
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
