  
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../main-application.dart';
import '../../repo/api-status.dart';
import '../../service/base.dart';
import '../../utils/constants.dart';
import '../../widgets/updata.dart';
import '../auth/auth-main.dart';
import '../main/app_main.dart';
import '../no-internet.dart';
/* 
class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return GetMaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Stack(
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _height / _fontSize
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 1000),
                    opacity: _textOpacity,
                    child: Text(
                      'YOUR APP\'S NAME',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: animation1.value,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: _containerOpacity,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _width / _containerSize,
                    width: _width / _containerSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // child: Image.asset('assets/images/file_name.png')
                    child: Text(
                      'YOUR APP\'S LOGO',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
class PageTransition extends PageRouteBuilder {
  final Widget page;
  
  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
        Widget pages(){
          return FutureBuilder(
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
               
        }
}





      