import 'package:get/get.dart';
import 'package:salamatiman/view/no-internet.dart';

class Success {
  int? code;
  Object? response;
  Success({this.code, this.response});
}

class Failure {
  int? code;
  Object? errorResponse;
  Failure({this.code, this.errorResponse}) {
    if (code == 103) {
      Get.to(() => NoInternet());
    }
  }
}
