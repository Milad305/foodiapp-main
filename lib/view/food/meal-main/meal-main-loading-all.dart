import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MealMainLoadingAll extends StatelessWidget {
  final onlySnack;
  MealMainLoadingAll({Key? key, required this.onlySnack}) : super(key: key);
  final Color baseColor = Color(0xFFDCDCDC);
  final Color highlightColor = Color(0xffc2c2c2);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if(onlySnack == false)...[
                    FoodTile(),
                    const SizedBox(height: 7),
                    FoodTile(),
                    const SizedBox(height: 7),
                    FoodTile(),
                    const SizedBox(height: 7),
                  ],

                  FoodTile(),
                  const SizedBox(height: 7),
                  FoodTile(),
                  const SizedBox(height: 7),
                  FoodTile(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: FoodsInfo(),
            ),
          ],
        ),
      ),
    );
  }

  FoodTile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.55,
          height: 60,
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 40,
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  FoodsInfo() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ShimmerBox(width: Get.width * 0.5, height: 25, radius: 4),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ShimmerBox(width: 70, height: 25, radius: 4),
                const SizedBox(width: 30),
                Column(
                  children: [
                    ShimmerBox(width: Get.width * 0.5, height: 12, radius: 4),
                    SizedBox(height: 3),
                    ShimmerBox(width: Get.width * 0.5, height: 15, radius: 4),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
                ShimmerBox(width: Get.width * 0.28, height: 15, radius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ShimmerBox({required width, required height, required radius}) {
    return SizedBox(
      width: double.parse(width.toString()),
      height: double.parse(height.toString()),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius:
                BorderRadius.circular(double.parse(radius.toString())),
          ),
        ),
      ),
    );
  }
}
