import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/bottom_navigation_bar.dart';
import 'package:salamatiman/getx/home/home-getter.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/blog/blog-main.dart';
import 'package:salamatiman/view/chat/chat-main.dart';
import 'package:salamatiman/view/home_page/home_page.dart';
import 'package:salamatiman/view/report-card/report-card.dart';
import 'package:salamatiman/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:salamatiman/widgets/exit_in_app.dart';
import 'package:salamatiman/widgets/home-alert-dialog/home_alert_dialog.dart';
import 'package:salamatiman/widgets/rotation.dart';

import '../../getx/pedometer_getter.dart';

class AppMain extends GetView<BottomNavigationBarGetter> {
  AppMain({Key? key}) : super(key: key) {
    Get.put(BottomNavigationBarGetter());
    Get.put(PedometerGetter());
    Get.put(HomeGetter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Constants.userInfo = await GetStorage().read('UserInfo');
    });
  }

  final Duration? _duration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    print(GetStorage().read('UserToken'));
    return ExitInApp(
      child: Obx(() {
        return Scaffold(
          body: SafeArea(
            child: Obx(
              () => GetPage(controller.itemSelecter.value),
            ),
          ),
          // ignore: unrelated_type_equality_checks
          floatingActionButton: controller.btmNavActivity == true
              ? GestureDetector(
                  onTap: () {
                    controller.isOpenHomeAlertDialog(true);
                    Get.dialog(HomeAlertDialog());
                  },
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: Constants.primarygradiant,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: TweenAnimationBuilder(
                        duration: _duration!,
                        curve: Curves.easeOut,
                        tween: Tween<double>(
                            begin: 0,
                            end: controller.isOpenHomeAlertDialog.value
                                ? 0.13
                                : 0),
                        builder: (context, dynamic value, child) {
                          return RotationBox(
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            rotation: value,
                          );
                        }),
                  ),
                )
              : Container(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // ignore: unrelated_type_equality_checks
          bottomNavigationBar: controller.btmNavActivity == true
              ? BottomNavigationBarWidget()
              : Container(
                  height: 0,
                ),
        );
      }),
    );
  }

  // ignore: non_constant_identifier_names
  GetPage(int pageID) {
    switch (pageID) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatMain();
      case 2:
        return ReportCard();
      case 3:
        return BlogMain();
      default:
        return const HomePage();
    }
  }
}
