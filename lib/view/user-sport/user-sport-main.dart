import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/sport/sport-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import 'search_sport.dart';
import 'sportcategory-tile.dart';

class UserSportMain extends GetView<SportGetter> {
  UserSportMain({Key? key}) : super(key: key) {
    Get.put(SportGetter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final loading = controller.loading.value;
          final categorys = controller.categorys;
          return loading
              ? Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black45,
                    size: 17.sp,
                  ),
                )
              : categorys.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: Get.height * 0.20,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Image.asset(
                                          "assets/images/sport-header.png",
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    
                                      Positioned(
                                        top: ((Get.height * 0.25) / 2) ,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "افزودن تمرین",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height/100,),
                              Padding(
                                padding:  EdgeInsets.fromLTRB(Get.width/30,Get.height/100,Get.width/30,0),
                                child: GestureDetector(
                                            onTap: () =>
                                                Get.to(() => SearchSport()),
                                            child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              padding: EdgeInsets.all(7.sp),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Constants.shadeColor,
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "جستجوی تمرین...",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 25.sp,
                                                    height: 25.sp,
                                                    child: Icon(
                                                      Icons.search,
                                                      color: Colors.grey.shade400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    child: Wrap(
                                      children:categorys
                                          .map(
                                              (category) => SportCategoryTile(
                                                    category: category,
                                                  ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const Center(
                      child: Text("خطا در دریافت داده ها"),
                    );
        }),
      ),
    );
  }
}
