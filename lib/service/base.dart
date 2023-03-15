import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:salamatiman/getx/auth/auth-getter.dart';
import 'package:salamatiman/repo/api-status.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/main/app_main.dart';

import '../widgets/loading_dialog.dart';

abstract class BaseService {
  static final _path = "/api/v2/";
  static var header = {'Content-Type': 'application/json'};

  static late Timer dialogTimer;
  static showDialog() {
    dialogTimer = Timer(Duration(milliseconds: 5), () {
      LoadingDialog.show();
    });
  }

  static hideDialog() {
    Get.back();
  }

  static checkAndHideDialog({required bool hasLoading}) {
    //dialogTimer.cancel();
    if (hasLoading) {
      Get.closeAllSnackbars();
      Get.back();
    }
  }

  static Future<Object> get({path, bool? loading, int? timeOut}) async {
    if (loading == null) {
      loading = false;
    }

    if (loading) {
      showDialog();
    }

    if (timeOut == null) {
      timeOut = 5;
    }

    try {
      var url = Uri.https(Constants.BaseUrl, _path + "$path", header);
      final response = await http.get(url).timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          checkAndHideDialog(hasLoading: loading!);
          return http.Response('Error Time Out', 101);
        },
      );
      if (200 == response.statusCode) {
        checkAndHideDialog(hasLoading: loading);
        return Success(code: 200, response: response.body);
      }
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 100, errorResponse: "Invalid Response");
    } on HttpException {
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 102, errorResponse: "Invalid Format");
    } catch (e) {
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 103, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> post(
      {required String path,
      body,
      bool? loading,
      bool? hasToken,
      int? timeOut,
      bool? hasHeader,
      port}) async {
    if (hasToken != null && hasToken == true) {
      await checkToken();
    }

    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    if (loading == null) {
      loading = false;
    }

    if (timeOut == null) {
      timeOut = 20;
    }

    if (loading) {
      showDialog();
    }

    if (hasHeader == null || hasHeader == false) {
      header = {};
    }

    try {
      var url = Uri.https(
          Constants.BaseUrl + (port == "" || port == null ? "" : port),
          (port == "" || port == null ? _path : "") + path,
          header);
      var response =
          await http.post(url, body: jsonEncode(body), headers: header).timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          checkAndHideDialog(hasLoading: loading!);
          return http.Response('Error Time Out', 101);
        },
      );

      if (200 == response.statusCode) {
        checkAndHideDialog(hasLoading: loading);
        return Success(code: 200, response: response.body);
      }
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 100, errorResponse: response.body);
    } on HttpException {
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 102, errorResponse: "Invalid Format");
    } catch (e) {
      checkAndHideDialog(hasLoading: loading);
      return Failure(code: 103, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> postCustomUrl(bool loading,
      {required customUrl,
      required path,
      required body,
      required header}) async {
    late Timer dialogTimer;
    if (loading) {
      dialogTimer = Timer(Duration(milliseconds: 5), () {
        LoadingDialog.show();
      });
    }

    try {
      var url = Uri.https(customUrl, path);
      var response =
          await http.post(url, body: jsonEncode(body), headers: header);
      if (200 == response.statusCode) {
        Get.closeAllSnackbars();
        if (loading) {
          dialogTimer.cancel();
          Get.back();
        }
        return Success(code: 200, response: response.body);
      }
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } on HttpException {
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 102, errorResponse: "Invalid Format");
    } catch (e) {
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 103, errorResponse: "Unknown Error");
    }
  }

  static Future<Object> getCustomUrl(bool loading,
      {required customUrl, required path}) async {
    late Timer dialogTimer;
    if (loading) {
      dialogTimer = Timer(Duration(milliseconds: 5), () {
        LoadingDialog.show();
      });
    }

    try {
      var url = Uri.https(customUrl, path);
      var response = await http.get(url, headers: header);
      if (200 == response.statusCode) {
        Get.closeAllSnackbars();
        if (loading) {
          dialogTimer.cancel();
          Get.back();
        }
        return Success(code: 200, response: response.body);
      }
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 100, errorResponse: "Invalid Response");
    } on HttpException {
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 101, errorResponse: "No Internet");
    } on FormatException {
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 102, errorResponse: "Invalid Format");
    } catch (e) {
      Get.closeAllSnackbars();
      if (loading) {
        dialogTimer.cancel();
        Get.back();
      }
      return Failure(code: 103, errorResponse: "Unknown Error");
    }
  }

  // static checkToken() async {
  //   final String token = GetStorage().read('UserToken') != null ||
  //           GetStorage().read('UserToken') != ""
  //       ? GetStorage().read('UserToken')
  //       : "";
  //   if (token == "") {
  //     Constants.token = "";
  //     Constants.userInfo = "";
  //     GetStorage().write('UserToken', "");
  //     return false;
  //   } else {
  //     bool hasExpired = JwtDecoder.isExpired(token);
  //     if (hasExpired) {
  //       var res = await post(
  //           path: "auth/refresh", loading: true, body: {"token": token});
  //       if (res is Success) {
  //         if (res.response != "" || res.response != 0 || res.response != "0") {
  //           var json = jsonDecode(res.response.toString());
  //           Constants.token = json['access_token'];
  //           Constants.userInfo = json;
  //           GetStorage().write('UserToken', json['access_token']);
  //           return true;
  //         } else {
  //           return false;
  //         }
  //       } else {
  //         return false;
  //       }
  //     }
  //     return true;
  //   }
  // }

  static checkToken() async {
     
    String token = GetStorage().read('UserToken') != null
        ? GetStorage().read('UserToken')
        : "";
    if (token != "") {
      bool hasExpired = JwtDecoder.isExpired(token);
      if (hasExpired) {
        final res = await post(
            path: 'auth/validate_token',
            body: {'token': token},
            loading: false);
        var controller = Get.put(AuthGetter());
        if (res is Success) {
          if (res.code == 200) {
            var json = jsonDecode(res.response.toString());
            Constants.token = json['access_token'];
            controller.token(json['access_token']);
            Constants.storage.write('UserToken', json['access_token']);
            return true;
          } else {
            Constants.token = "";
            Constants.storage.write('UserToken', "");
            Get.to(() => AppMain());
          }
          return true;
        } else {
          Constants.token = "";
          Constants.storage.write('UserToken', "");
          return false;
        }
      } else {
        return true;
      }
    } else {
      Constants.token = "";
      Constants.storage.write('UserToken', "");
      return false;
    }
  }

}
