import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/utils/constants.dart';

import 'change_profile_data/change_profile_data_main.dart';
import 'gender.dart';

class ProfileCover extends GetView<AuthGetter> {
  var user;

  ProfileCover(
      {Key? key,
      required this.user,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.userInfo.isNotEmpty) {
        user = controller.userInfo[0];
      }

      return Container();
    });
  }
}
