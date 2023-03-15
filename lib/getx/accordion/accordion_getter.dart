import 'package:get/get.dart';

class AccordionGetter extends GetxController {
  RxString ItemActive = "-1".obs;
  RxBool showScroll = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ItemActive("-1");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    ItemActive("-1");
  }
}
