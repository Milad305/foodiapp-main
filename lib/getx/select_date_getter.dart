import 'package:get/get.dart';

class SelectDateGetter extends GetxController {
  RxString dateSelected = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  setDateSelected(val) {
    dateSelected.value = val;
    update();
  }
}
