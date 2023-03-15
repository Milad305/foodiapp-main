import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/internet-check.dart';
import 'package:salamatiman/getx/pedometer_getter.dart';
import 'package:salamatiman/getx/person-selector.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/food/meal-main/nutrients/meal_select_item.dart';
import 'package:salamatiman/view/home_page/apple_main.dart';
import 'package:salamatiman/widgets/body-water-widget/body-water-widget.dart';
import 'package:salamatiman/widgets/macro-micro/macro-micro.dart';
import 'package:salamatiman/widgets/pedometer_widget/pedometer_widget.dart';
import 'package:salamatiman/widgets/person-target/person-target.dart';
import 'appbar/appbar.dart';



class ChildrenHomePage extends GetView<InternetCHeck> {
  ChildrenHomePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => PersonSelector());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Constants.userInfo = await GetStorage().read('UserInfo');
      if (controller.allData.isEmpty) {
        await controller.getAllApi(controller.dateSelected.value);
      }

    });
  }
  Future<void> _refreshAllDateHome() async {
    controller.customRefreshLoading(true);
    await controller.getDataByDate();
    controller.customRefreshLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomRefreshIndicator(
        onRefresh: _refreshAllDateHome,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: HomePageAppBar(title: ""),
            ),
            centerTitle: true,
            elevation: 0,
            leadingWidth: 0,
            titleSpacing: 0,
            toolbarHeight: 90,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Obx(() {
              if (controller.allDataLoading.value) {
                return Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black45,
                    size: 17.sp,
                  ),
                );
              }


              if (controller.allData.isNotEmpty) {
                final userWaterData = controller.allData['getWater'];
                final getFoodStats = controller.allData['getFoodStats'];
                final pageID = controller.PageView1.value;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ExpandablePageView(
                          controller: PageController(initialPage: 1),
                          onPageChanged: (val) {
                            controller.PageView1(val);
                          },
                          children: [
                            SizedBox(
                              width: Get.width,
                              child: const MacroWidget(),
                            ),
                            //////////
                            AppleMain(allData: controller.allData),
                            //////////
                            SizedBox(
                              width: Get.width,
                              child: MicroWidget(onlySnack: false),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: double.infinity,
                        height: 17,
                        alignment: Alignment.center,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for (var i = 0; i < 3; i++) ...[
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    width: pageID == i ? 10 : 7,
                                    height: pageID == i ? 10 : 7,
                                    decoration: BoxDecoration(
                                      color: pageID == i
                                          ? Constants.secondaryColor
                                          : Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.5),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      MealSelectItem(foodStats: getFoodStats),
                      const SizedBox(
                        height: 10,
                      ),
                      /////
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: PersonTarget(defultAllData: controller.allData),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.sp),
                            child: BodyWaterWidget(
                                userWaterData: userWaterData,
                                controller: controller),
                          ),
                          GetBuilder<PedometerGetter>(
                            init: PedometerGetter(),
                            builder: (logic) {
                              return Obx(() {
                                final walkUpdate = logic.walkUpdate.value;
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  child: PedometerWidget(),
                                );
                              });
                            },
                          )
                        ],
                      ),

                      SizedBox(height: 40.sp),
                    ],
                  ),
                );
              }

              return SizedBox(
                height: Get.height,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "بارگذاری با خطا مواجه شد \n لطفا دوباره تلاش کنید ",
                          style: TextStyle(fontSize: 18.sp),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            controller.getDataByDate();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: Get.width * 0.5,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Constants.primaryColor2,
                              ),
                              child: Text(
                                "تلاش مجدد",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        builder: (context, child, controller) {
          return Stack(
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    child: SpinKitRotatingCircle(
                      color: Colors.black45,
                      size: 20.sp,
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(0.0, controller.value * 70.sp),
                    child: child,
                  );
                },
                animation: controller,
              ),
            ],
          );
        },
      ),
    );
  }
}
