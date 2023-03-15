import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/repo/url_launcher.dart';

import '../../getx/auth/auth-getter.dart';
import '../../getx/bottom_navigation_bar.dart';
import '../../utils/constants.dart';
import '../abute/abute_page.dart';
import '../profile/profile-main.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Constants.userInfo = await GetStorage().read('UserInfo');
    });
  }

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  BottomNavigationBarGetter bottomNavigationBarGetter =
      Get.put(BottomNavigationBarGetter());
  var myInfo = GetStorage().read('UserInfo');
  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      Get.back();
      return Future.value(false);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            ZoomDrawer.of(context)!.toggle();
                            Get.find<BottomNavigationBarGetter>()
                                .btmNavActivity
                                .value = true;
                          },
                          icon: const ImageIcon(
                            AssetImage("assets/images/Union.png"),
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.sp, horizontal: 10.sp),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Constants.shadeColor,
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.normal)
                                ],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: GetBuilder<AuthGetter>(
                                init: AuthGetter(),
                                assignId: true,
                                builder: (logic) {
                                  return Obx(() {
                                    final userInfo = logic.userInfo.isNotEmpty
                                        ? logic.userInfo
                                        : Constants.userInfo;
                                    if (myInfo.isEmpty) {
                                      return Container();
                                    }
                                    if (myInfo["avatar"] != null) {
                                      return CachedNetworkImage(
                                        imageUrl:
                                            "https://${Constants.BaseUrl}${myInfo["avatar"]}",
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                                color:
                                                    Constants.secondaryColor),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/profile.png"),
                                        fit: BoxFit.fill,
                                        height: 60,
                                        width: 60,
                                      );
                                    }
                                    return Container();
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5.sp),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => print(Constants.userInfo),
                                  child: Text(
                                    "${Constants.userInfo["name"]}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${Constants.userInfo["mobile"]}"
                                      .toPersianDigit(),
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                )
                                // GestureDetector(
                                //   onTap: () {
                                //     Get.to(() => PlansMain());
                                //   },
                                //   child: GetBuilder<PlansGetx>(
                                //       init: PlansGetx(),
                                //       builder: (logic) {
                                //         logic.getUserSubscriptions();
                                //         return Obx(() {
                                //           if (logic.plansLoding.value) {
                                //             return Wrap(
                                //               children: [
                                //                 const Text(
                                //                     "درحال دریافت داده ها"),
                                //                 SizedBox(
                                //                   width: 50,
                                //                   child: SpinKitThreeBounce(
                                //                     color: Colors.white,
                                //                     size: 15.sp,
                                //                   ),
                                //                 )
                                //               ],
                                //             );
                                //           }
                                //           List<SubscriptionsModel> subscription =
                                //               [];
                                //           if (logic.subscriptions.isNotEmpty) {
                                //             for (int i = 0;
                                //                 i < logic.subscriptions.length;
                                //                 i++) {
                                //               if (logic.subscriptions[i].status ==
                                //                   "active") {
                                //                 subscription
                                //                     .add(logic.subscriptions[i]);
                                //                 break;
                                //               }
                                //             }
                                //           }
                                //           if (Constants.forBazzar == false) {
                                //             return Text.rich(
                                //               TextSpan(
                                //                   text: "اشتراک شما",
                                //                   children: [
                                //                     const TextSpan(text: " "),
                                //                     TextSpan(
                                //                         text: subscription.isEmpty
                                //                             ? "پلن رایگان"
                                //                             : subscription[0]
                                //                                 .title,
                                //                         style: TextStyle(
                                //                             color: Constants
                                //                                 .activeColor)),
                                //                   ],
                                //                   style:
                                //                       TextStyle(fontSize: 16.sp)),
                                //             );
                                //           }
                                //           return const Text("");
                                //         });
                                //       }),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.sp),

                    ListTile(
                      onTap: () => Get.to(() => ProfileMain()),
                      leading: const ImageIcon(
                        AssetImage("assets/images/AcountsettingIcon.png"),
                        color: Colors.white,
                      ),
                      title: Text(
                        "حساب‌ کاربری",
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.white,
                      thickness: 1.5,
                      endIndent: 25,
                    ),
                    // ListTile(
                    //   onTap: () {
                    //     Get.back();
                    //     Get.find<BottomNavigationBarGetter>()
                    //         .changeItemSelecter(0);
                    //   },
                    //   leading: const Icon(Icons.dashboard_rounded),
                    //   title: Text(
                    //     "داشبورد",
                    //     style:
                    //         TextStyle(fontSize: 16.sp, color: Colors.white),
                    //   ),
                    // ),

                    // ListTile(
                    //   onTap: () {
                    //     Get.to(() => PlansMain());
                    //   },
                    //   leading: const ImageIcon(
                    //     AssetImage("assets/images/buyIcon.png"),
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     "خرید اشتراک",
                    //     style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    //   ),
                    // ),
                    // const Divider(
                    //   height: 1,
                    //   color: Colors.white,
                    //   thickness: 1.5,
                    //   endIndent: 25,
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.message_rounded),
                    //   title: Text(
                    //     "پیام‌ها",
                    //     style: TextStyle(fontSize: 16.sp),
                    //   ),
                    // ),

                    // ListTile(
                    //   leading: Icon(Icons.share_outlined),
                    //   title: Text(
                    //     "اشتراک‌گذاری",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ),
                    ListTile(
                      onTap: () => Get.to(() => const AbutePage()),
                      leading: const ImageIcon(
                          AssetImage("assets/images/aboutUsIcon.png"),
                          color: Colors.white),
                      title: Text(
                        "درباره ما",
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.white,
                      thickness: 1.5,
                      endIndent: 25,
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Constants.logout();
                      },
                      leading: const ImageIcon(
                        AssetImage("assets/images/logoutIcon.png"),
                        color: Colors.white,
                      ),
                      title: Text(
                        "خروج از حساب کاربری",
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      return LaunchUrlExternal('www.aparat.com/salamatiman.ir');
                    },
                    child: Image.asset(
                      "assets/images/social/aparat.png",
                      width: 35.sp,
                      height: 35.sp,
                    )),
                GestureDetector(
                    onTap: () {
                      return LaunchUrlExternal('instagram.com/salamatiman.ir');
                    },
                    child: Image.asset(
                      "assets/images/social/instagram.png",
                      width: 35.sp,
                      height: 35.sp,
                    )),
                GestureDetector(
                    onTap: () {
                      return LaunchUrlExternal('t.me/salamatimanir');
                    },
                    child: Image.asset(
                      "assets/images/social/telegram.png",
                      width: 35.sp,
                      height: 35.sp,
                    )),
                GestureDetector(
                    onTap: () {
                      return LaunchUrlExternal('youtu.be/tpJTJydob5M');
                    },
                    child: Image.asset(
                      "assets/images/social/youtube.png",
                      width: 35.sp,
                      height: 35.sp,
                    )),
              ],
            ),
          ),
          SizedBox(height: 30.sp),
          Text(
            "نسخه 1.0.0",
            style: TextStyle(fontSize: 17.sp, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
