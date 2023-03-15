import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salamatiman/model/sport/sport-category-model.dart';
import 'package:salamatiman/utils/constants.dart';

import 'select-sport.dart';

class SportCategoryTile extends StatelessWidget {
  final SportCategorysModel category;
  const SportCategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Get.width/150),
      child: Container(
       height: Get.height/10,
            width: Get.width/2.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10
              , offset: Offset(0,3))]
            ),
        child: Center(
          child: ListTile(
            onTap: () {
              Get.to(() => SelectSport(
                    id: category.id,
                    catTitle: category.title,
                  ));
            },
            leading: Container(
              width: 45.sp,
              height: 45.sp,
              decoration: BoxDecoration( boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10
              ,
              offset: Offset(0,5)
              )] ),
              child: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: ImageHolder(),
                ),
              ),
            ),
            title: Text(
              "${category.title}",
              style: TextStyle(
                color: Constants.secondaryColor,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ImageHolder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 100)]),
      child: CachedNetworkImage(
        imageUrl: "https://${Constants.BaseUrl}" + category.img.toString(),
        fit: BoxFit.fitHeight,
        height: 60,
        width: 60,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration( 
            color: Colors.white,
            boxShadow: <BoxShadow>[BoxShadow(color: Constants.shadeColor,blurRadius: 10,offset: Offset(0,10))],
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>
            Image.asset("assets/images/sport-placeholder.jpg"),
        errorWidget: (context, url, error) =>
            Image.asset("assets/images/sport-placeholder.jpg"),
      ),
    );
  }
}
