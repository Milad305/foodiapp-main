import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FoodShimmer extends StatelessWidget {
  const FoodShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.80,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(4),
              child: Container(
                width: Get.width * 0.4,
                margin: EdgeInsets.only(bottom: 40),
                child: Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 30,
                      bottom: 15,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white,
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
                                    child: Text("",
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
                    ),
                    Positioned(
                      top: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          color: Colors.white,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white,
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.concave,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(100)),
                                  depth: 8,
                                  lightSource: LightSource.topLeft,
                                  color: Colors.black54),
                              child: Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                child: Text(""),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
