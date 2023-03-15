import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/custom-recipes/pages/select-recipes-stuffs.dart';

class FoodStuffsAdd extends StatelessWidget {
  final group,title ;
  const FoodStuffsAdd({Key? key, this.group, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width/6,
      child: Empty(),
    );
  }

  Widget Empty() {
    return GestureDetector( 
            child: Container(
              width: Get.width/6,
              
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000),
              gradient: LinearGradient(colors: Constants.primarygradiant,begin: Alignment.topCenter,end: Alignment.bottomCenter)
              ),
              child: Center(
                child: Text(
                  "افزودن+ ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13.sp, 
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            onTap: () {
             Get.to(() => SelectRecipesStuffs(group: group,title: title,));
            },
          );
  }
}



          