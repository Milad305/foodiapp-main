import 'package:get/get.dart';
import 'package:salamatiman/utils/get-date.dart';

class PersonSelector extends GetxController {
  RxInt personWaterSelect = 0.obs;
  RxInt dateSelected = 0.obs;
  RxString date = GetDate.todayOnlyDate().toString().obs;
  RxList waterData = [].obs;
}
