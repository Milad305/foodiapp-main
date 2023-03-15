import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/getx/internet-check.dart';
import 'package:salamatiman/getx/plan/bazzar-plan.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/view/no-internet.dart';
import 'package:salamatiman/widgets/updata.dart';
import 'package:uni_links/uni_links.dart';
import 'getx/bottom_navigation_bar.dart';
import 'getx/person-selector.dart';
import 'service/base.dart';
import 'utils/constants.dart';
import 'view/auth/auth-main.dart';
import 'view/main/app_main.dart';
import 'view/plan/pay_result.dart';
import 'widgets/exit_in_app.dart';

class MainApplication extends GetView<InternetCHeck> {
  MainApplication({Key? key}) : super(key: key) {
    Get.lazyPut(() => InternetCHeck());
    Get.put(PersonSelector());
    Get.put(BottomNavigationBarGetter());
    //Get.put(BazzarPlanGetter()); bazarme
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (Constants.forBazzar) {
        // Get.find<BazzarPlanGetter>().getPurchasedProducts(); bazarme
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Constants.textColor,
          displayColor: Constants.textColor,
          fontFamily: Constants.primaryFontFamily,
          fontSizeFactor: 1.sp,
        );

    StreamSubscription _sub;

    Future<void> initUniLinks() async {
      // Platform messages may fail, so we use a try/catch PlatformException.
      _sub = linkStream.listen((String? link) {
        Get.to(() => PayResult(
              link: link,
            ));
        // Parse the link and warn the user, if it is not correct
      }, onError: (err) {
        // Handle exception by warning the user their action did not succeed
      });
    }

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    initUniLinks();
    return RotatedBox(
      quarterTurns: 0,
      child: GetMaterialApp(
        enableLog: true,
        debugShowCheckedModeBanner: false,
        title: "سلامتی من",
        locale: const Locale('fa', 'IR'),
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"),
        ],
        theme: ThemeData(
            useMaterial3: true,
            textTheme: newTextTheme,
            primaryColor: Constants.primaryColor,
            backgroundColor: Colors.black45,
            scaffoldBackgroundColor: Constants.primaryColor,
            secondaryHeaderColor: Constants.secondaryHeaderColor,
            shadowColor: Constants.shadowColor,
            fontFamily: Constants.primaryFontFamily,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Constants.secondaryColor,
                  textStyle: TextStyle(color: Colors.white, fontSize: 18.sp)),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              //shape: CircleBorder(),
              backgroundColor: Constants.secondaryColor,
              //backgroundColor: Constants.warningColor,
            )),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: ExitInApp(
            child: Scaffold(
                extendBody: true,
                body: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: Constants.primarygradiant,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    //borderRadius: BorderRadius.circular(50),
                  ),
                  child: Obx(() {
                    final hasInternet = controller.isInternet.value;
                    return controller.loadfinished.value
                        ? FutureBuilder(
                            future: BaseService.post(
                              path: "common/version",
                              hasHeader: true,
                              body: {},
                              loading: false,
                            ),
                            builder: (context, snapshot) {
                              final result = snapshot.data;
                              if (result is Failure) {
                                return NoInternet();
                              }
                              if (result is Success) {
                                if (int.parse(result.response.toString()) >=
                                    1) {
                                  return FutureBuilder(
                                    future: BaseService.checkToken(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        if (GetStorage().read('UserToken') !=
                                            null) {
                                          Constants.userToken =
                                              GetStorage().read('UserToken');
                                          Constants.token =
                                              GetStorage().read('UserToken');
                                        }
                                        //print(GetStorage().read('UserToken'));

                                        return snapshot.data == false ||
                                                snapshot.data == null
                                            ? AuthMain()
                                            : AppMain();
                                      }
                                      return Center(
                                        child: SpinKitThreeBounce(
                                          color: Colors.black45,
                                          size: 17.sp,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const UpdataApp();
                                }
                              }
                              return FutureBuilder(
                                future: BaseService.checkToken(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (GetStorage().read('UserToken') !=
                                        null) {
                                      Constants.userToken =
                                          GetStorage().read('UserToken');
                                      Constants.token =
                                          GetStorage().read('UserToken');
                                    }
                                    return snapshot.data == false ||
                                            snapshot.data == null
                                        ? AuthMain()
                                        : AppMain();
                                  }
                                  return Center(
                                    child: SpinKitThreeBounce(
                                      color: Colors.black45,
                                      size: 17.sp,
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : Stack(
                            children: [
                              Column(
                                children: [
                                  AnimatedContainer(
                                      duration: Duration(milliseconds: 2000),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      height:
                                          _height / controller.fontSize.value),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 1000),
                                    opacity: controller.textOpacity.value,
                                    child: Text(
                                      'سلامتی من',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: controller.animation1.value,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 2000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  opacity: controller.containerOpacity.value,
                                  child: AnimatedContainer(
                                      duration: Duration(milliseconds: 2000),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      height: _width /
                                          controller.containerSize.value,
                                      width: _width /
                                          controller.containerSize.value,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Image.asset(
                                          'assets/images/logo_icon.png')
                                      /*  child: Text(
                                      'سلامتی من',
                                    ), */
                                      ),
                                ),
                              ),
                            ],
                          );
                  }),
                )),
          ),
        ),
      ),
    );
  }
}


/*
FutureBuilder(
                    future: BaseService.post(
                      path: "common/version",
                      hasHeader: true,
                      body: {},
                      loading: false,
                    ),
                    builder: (context, snapshot) {
                      final result = snapshot.data;
                      if (result is Failure) {
                        return NoInternet();
                      }
                      if (result is Success) {
                        if (int.parse(result.response.toString()) >= 1) {
                          return FutureBuilder(
                            future: BaseService.checkToken(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (GetStorage().read('UserToken') != null) {
                                  Constants.userToken =
                                      GetStorage().read('UserToken');
                                  Constants.token =
                                      GetStorage().read('UserToken');
                                }
                                //print(GetStorage().read('UserToken'));

                                return snapshot.data == false ||
                                        snapshot.data == null
                                    ? AuthMain()
                                    : AppMain();
                              }
                              return Center(
                                child: SpinKitThreeBounce(
                                  color: Colors.black45,
                                  size: 17.sp,
                                ),
                              );
                            },
                          );
                        } else {
                          return const UpdataApp();
                        }
                      }
                      return FutureBuilder(
                        future: BaseService.checkToken(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (GetStorage().read('UserToken') != null) {
                              Constants.userToken =
                                  GetStorage().read('UserToken');
                              Constants.token = GetStorage().read('UserToken');
                            }
                            return snapshot.data == false ||
                                    snapshot.data == null
                                ? AuthMain()
                                : AppMain();
                          }
                          return Center(
                            child: SpinKitThreeBounce(
                              color: Colors.black45,
                              size: 17.sp,
                            ),
                          );
                        },
                      );
                    },
                  );
                
 */