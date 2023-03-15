import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/food/foodOffer.dart';
import 'package:salamatiman/getx/food/foods.dart';
import 'package:salamatiman/getx/food/my_fav_food_controller.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/food-tile.dart';

import 'box-list-category.dart';
import 'custom-food/add-custom-food.dart';
import 'custom-recipes/custom-recipes-add-main.dart';
import 'save-food/save-food.dart';
import 'serach-box-food.dart';

class FoodCategory extends GetView<FoodGetter> {
  final group, title;
  FoodCategory({Key? key, required this.group, required this.title})
      : super(key: key) {
    //Get.put(()=>FoodGetter());
    controller.getCategorys();
    controller.removeSerachBoxText();
    myFavFoodController.getMyFavFoods();
  }

  MyFavFoodController myFavFoodController = Get.put(MyFavFoodController());
  FoodOfferController foodOfferController = Get.put(FoodOfferController());
  @override
  Widget build(BuildContext context) {
    final category = controller.categorys;
    final textSearch = controller.controllerSearch.value;
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.height * 0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.sp),
                        bottomRight: Radius.circular(30.sp),
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/vadeh/add-food-header.png"),
                        fit: BoxFit.cover,
                      )),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 20.sp,
                        child: Text(
                          " افزودن $title",
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                  color: Colors.grey.shade800,
                                  blurRadius: 20.0),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.sp,
                        child: SizedBox(
                          width: Get.width * 0.85,
                          child: FoodSearchBox(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.sp),
                Container(
                  height: Get.width / 8,
                  width: Get.width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Constants.shadeColor, blurRadius: 10)
                      ]),
                  child: Center(
                    child: TabBar(
                        unselectedLabelColor: Constants.textColor,
                        labelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        onTap: (int val) {
                          controller.getPackages(group);
                        },
                        indicator: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: Constants.primarygradiant,
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter),
                            borderRadius: BorderRadius.circular(1000)),
                        tabs: [
                          Tab(
                              child: Text("همه",
                                  style: TextStyle(fontSize: 12.sp))),
                          Tab(
                              child: Text("منتخب",
                                  style: TextStyle(fontSize: 12.sp))),
                          Tab(
                              child: Text(
                            "رژیم غذایی",
                            style: TextStyle(fontSize: 11.sp),
                          )),
                          Tab(
                              child: Text("شخصی",
                                  style: TextStyle(fontSize: 12.sp))),
                        ]),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    // همه

                    controller.searchResult.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.searchResult.length,
                            itemBuilder: (context, index) {
                              if (FocusScope.of(context).hasFocus) {
                                //FocusScope.of(context).unfocus();
                              }
                              return FoodTile(
                                  food: controller.searchResult[index],
                                  group: group,
                                  groupTitle: title,
                                  isShowImage: true); 
                                 
                            },
                          )
                        : category.isEmpty
                            ? SpinKitThreeBounce(
                                color: Colors.black45,
                                size: 17.sp,
                              )
                            : Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: BoxListCategory(
                                  group: group,
                                  title: title,
                                ),
                              ),

                    Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: ListView.builder(
                        itemCount: myFavFoodController.favFoodList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              SaveFoodBox.show(
                                  context: context,
                                  food: myFavFoodController.favFoodList[index],
                                  controller: controller,
                                  forSaveRecipes: false,
                                  groupTitle: title,
                                  group: group);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: Container(
                                width: Get.width / 1.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 5,
                                          offset: Offset(5, 10))
                                    ],
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 5.sp,
                                              ),
                                              SizedBox(
                                                width: 50.sp,
                                                height: 50.sp,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.sp),
                                                  child: myFavFoodController
                                                              .favFoodList[
                                                                  index]
                                                              .img !=
                                                          ""
                                                      ? CachedNetworkImage(
                                                          imageUrl:
                                                              myFavFoodController
                                                                  .favFoodList[
                                                                      index]
                                                                  .img,
                                                          fit: BoxFit.fitHeight,
                                                          height: 60,
                                                          width: 60,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Image.asset(
                                                                  "assets/images/image-placeholder.jpg"),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                                  "assets/images/image-placeholder.jpg"),
                                                        )
                                                      : Image.asset(
                                                          "assets/images/image-placeholder.jpg"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.sp,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20.sp,
                                          ),
                                          Text(myFavFoodController
                                              .favFoodList[index].shortTitle),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await controller.addFoodToFavorites(
                                            foodId: myFavFoodController
                                                .favFoodList[index].id);

                                        myFavFoodController.getMyFavFoods();
                                      },
                                      icon: Icon(
                                        Icons.star,
                                        color: Constants.secondaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: Obx(() {
                        return controller.packagesLoading.value
                            ? Center(
                                child: Text("لطفا صبر کنید"),
                              )
                            : controller.packages.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "رژیمی ثبت نشده است",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: ListView.builder(
                                      itemCount: controller.packages.length,
                                      itemBuilder: (context, index) {
                                        final package =
                                            controller.packages[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              package["title"].toString(),
                                              style: TextStyle(fontSize: 19.sp),
                                            ),
                                            for (int i = 0;
                                                i < package["foods"].length;
                                                i++) ...[
                                              GestureDetector(
                                                onTap: () {
                                                  SaveFoodBox.show(
                                                      context: context,
                                                      food: package["foods"][i],
                                                      controller: controller,
                                                      forSaveRecipes: false,
                                                      groupTitle: title,
                                                      group: group);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Container(
                                                    width: Get.width / 1.1,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(5, 10))
                                                        ],
                                                        color: Colors.white),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 5.sp,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        5.sp,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        50.sp,
                                                                    height:
                                                                        50.sp,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.sp),
                                                                      child: package["foods"][i].img !=
                                                                              ""
                                                                          ? CachedNetworkImage(
                                                                              imageUrl: package["foods"][i].img,
                                                                              fit: BoxFit.fitHeight,
                                                                              height: 60,
                                                                              width: 60,
                                                                              imageBuilder: (context, imageProvider) => Container(
                                                                                decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                    image: imageProvider,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              placeholder: (context, url) => Image.asset("assets/images/image-placeholder.jpg"),
                                                                              errorWidget: (context, url, error) => Image.asset("assets/images/image-placeholder.jpg"),
                                                                            )
                                                                          : Image.asset(
                                                                              "assets/images/image-placeholder.jpg"),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        5.sp,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 20.sp,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(package[
                                                                          "foods"][i]
                                                                      .shortTitle),
                                                                  Wrap(
                                                                    children: [
                                                                      Text(package["foods"]
                                                                              [
                                                                              i]
                                                                          .portionAmount
                                                                          .toString()
                                                                          .toPersianDigit()),
                                                                      SizedBox(
                                                                          width:
                                                                              6.sp),
                                                                      Text(package["foods"]
                                                                              [
                                                                              i]
                                                                          .portionTitle
                                                                          .toString())
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            SizedBox(height: 15.sp),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                      }),
                    ),

                    Center(
                        child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: Get.height / 4,
                              width: Get.width / 1.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: Constants.primarygradiant,
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Constants.shadeColor,
                                        blurRadius: 10)
                                  ],
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/prov.jpg"),
                                      fit: BoxFit.fill)),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Constants.textFieldBg),
                                      child: Text(
                                        "  غذای تجاری  ",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Constants.secondaryColor),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Get.to(AddCustomFood()),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: const LinearGradient(
                                                    colors: Constants
                                                        .primarygradiant,
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter)),
                                            child: Text(
                                              "  افزودن  ",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.sp,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Container(
                              height: Get.height / 4,
                              width: Get.width / 1.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Constants.shadeColor,
                                        blurRadius: 10)
                                  ],
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/custum.jpg"),
                                      fit: BoxFit.fill)),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Constants.textFieldBg),
                                      child: Text(
                                        "  دستور پخت  ",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Constants.secondaryColor),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              Get.to(CustomRecipesAddMain()),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: const LinearGradient(
                                                    colors: Constants
                                                        .primarygradiant,
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter)),
                                            child: Text(
                                              "  افزودن  ",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.sp,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
