import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/home_page/children.dart';
import 'package:salamatiman/view/home_page/drawer_screen.dart';
import 'package:salamatiman/widgets/exit_in_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ExitInApp(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: Constants.primarygradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: MyZoomDrawer(),
      ),
    ));
  }

  Widget MyZoomDrawer() {
    return ZoomDrawer(
      menuScreen: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: Constants.primarygradiant,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: DrawerScreen()),
      mainScreen: ChildrenHomePage(),
      borderRadius: 30,
      showShadow: true,
      angle: 0,
      isRtl: true,
      disableDragGesture: true,
      style: DrawerStyle.defaultStyle,
    );
  }
}
