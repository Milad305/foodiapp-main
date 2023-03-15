import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/model/food/food-model.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/save-food/save-food.dart';

import '../../getx/food/my_fav_food_controller.dart';

class FoodTile extends GetView<FoodGetter> {
  final FoodModel food;
  final group;
  final groupTitle;
  final isShowImage;
  FoodTile(
      {Key? key,
      required this.food,
      required this.group,
      required this.groupTitle,
      this.isShowImage})
      : super(key: key) {
    if (food.favorite) {
      controller.favorite.add(food.id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 2.sp,
        bottom: 7.sp,
        left: 5.sp,
        right: 5.sp,
      ),
      child: GestureDetector(
        onTap: () {
          SaveFoodBox.show(
              context: context,
              food: food,
              controller: controller,
              forSaveRecipes: false,
              groupTitle: groupTitle,
              group: group);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.sp),
              child: food.img != "" && food.img != null ?
                   CachedNetworkImage(
                      imageUrl: food.img,
                      fit: BoxFit.fitHeight,
                      height: 60,
                      width: 60,
                      
                      placeholder: (context, url) => const CircularProgressIndicator(),/* (context, url) =>
                          Image.asset("assets/images/image-placeholder.jpg"), */
                      errorWidget: (context, url,error) => const CircularProgressIndicator()/* (context, url, error) =>
                          Image.asset("assets/images/image-placeholder.jpg") */,
                    )
                  : Image.asset("assets/images/image-placeholder.jpg") ,
            ),
          ),
          title: Text(
            food.shortTitle.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: Constants.textColor,
              fontWeight: FontWeight.w700,
            ),  
          ),
          trailing: Container(
            width: 30,
            height: 30,
            alignment: Alignment.centerLeft,
            child: IconButton( 
                onPressed: () async {
                  print(food.id);  
                  print(food.img.toString());
                  print(food.title);
                  await controller.addFoodToFavorites(foodId: food.id);
                  Get.find<MyFavFoodController>().getMyFavFoods();                
                },
                icon: Obx(
                  () => Icon(
                    (controller.favorite.contains(food.id))
                        ? Icons.star
                        : Icons.star_outline_outlined,
                    color: Constants.secondaryColor,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
   