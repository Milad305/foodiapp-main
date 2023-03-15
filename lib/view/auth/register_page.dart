import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/widgets/exit_in_app.dart';
import '../../utils/constants.dart';
import 'register_step/register_step.dart';

class AuthRegisterPage extends GetView<AuthGetter> {
  AuthRegisterPage({Key? key}) : super(key: key) {
    //Get.lazyPut(() => AuthGetter());
    controller.steep(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Constants.primaryColor,
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: controller.steep.value > 1 ? 80 : 0,
        leading: Obx(() => IconButton(
              icon: controller.steep.value > 1
                  ? Icon(Icons.arrow_back)
                  : Text(''),
              onPressed: controller.steep.value > 1
                  ? () {
                      controller.steep(--controller.steep.value);
                    }
                  : null,
            )),
      ),
      body: ExitInApp(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (controller.steep.value == 1) {
                          return AuthRegisterStep.name(controller);
                        }
                        if (controller.steep.value == 2) {
                          return AuthRegisterStep.age(controller);
                        }
                        if (controller.steep.value == 3) {
                          return AuthRegisterStep.gender(
                              controller, context, 300);
                        }
                        else {
                          return AuthRegisterStep.name(controller);
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
