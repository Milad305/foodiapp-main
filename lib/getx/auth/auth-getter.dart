import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/service/auth.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/utils/get-date.dart';

class AuthGetter extends GetxController {
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  
  RxString name = "".obs;
  RxString phone = "".obs;
  RxString ageDate = "".obs;
  RxString personHeight = "0".obs;
  RxInt personHeightSize = 50.obs;
  RxInt aroundTheWrist = 10.obs;
  RxString personWeight = '0'.obs;
  RxInt personWeightKilo = 1.obs;
  RxInt personActivity = 0.obs;
  RxString pregnancy = 'سه ماه اول'.obs;
  RxInt pregnancyID = 0.obs;
  RxString breastfeeding = 'شش ماه اول'.obs;
  RxInt breastfeedingID = 0.obs;
  RxInt gender = 0.obs;
  RxInt womanChild = 0.obs;
  RxString password = "".obs;
  RxString token = "".obs;

  RxInt lactationPeriod = 1.obs;
  RxInt pregnantPeriod = 1.obs;

  RxInt steep = 1.obs;

  RxInt age = 0.obs;

  RxString verifayCode = "".obs;

  Timer? _timer;
  RxInt time = 60.obs;

  RxList userInfo = [].obs;

  RxString avatar = "".obs;

  TextEditingController y = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController d = TextEditingController();

  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  void timer(start) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          time(start);
        } else {
          start--;
          time(start);
        }
        update();
      },
    );
  }

  sendSmsAuth(phone, code, signcode) {}

  timerCancel() {
    if (_timer != null) _timer!.cancel();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    timerCancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timerCancel();
  }

  changeProfileField({required name, required val, required isBack}) async {
    final res = await AuthUser.changeProfileField(name: name, val: val);
    if (res is Success) {
      print(jsonDecode(res.response.toString()));
      userInfo.clear();
      userInfo.add(jsonDecode(res.response.toString()));
      GetStorage().write('UserInfo', jsonDecode(res.response.toString()));
      print(GetStorage().read('UserInfo'));
    } else if (res is Failure) {
      Fluttertoast.showToast(msg: "خطا در ذخیره سازی");
    }
    if (isBack) Get.back();
  }

  changeAvatar() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    final name = result?.names[0];
    final path = result?.files[0].path;
    final format = name.toString().split('.').last;
    final imageFormat = [
      "jpg",
      "JPG",
      "jpeg",
      "JPEG",
      "png",
      "PNG",
      "gif",
      "GIF"
    ];
    if (imageFormat.contains(format)) {
      final bytes = await File(path.toString()).readAsBytes();
      final user =
          await AuthUser.changeAvatar(imgbytes: base64Encode(bytes).toString());
      if (user is Success) {
        userInfo.clear();
        avatar(user.response.toString());
        final me = await AuthUser.me();
        if (me is Success) {
          final json = jsonDecode(me.response.toString());
          GetStorage().write('UserInfo', json);
          GetStorage().write('UserToken', json["token"]);
          userInfo.add(json);
          Constants.userInfo = json;
          Constants.userToken = json["token"].toString();
        }
      }
      //avatar
    }
  }
}
