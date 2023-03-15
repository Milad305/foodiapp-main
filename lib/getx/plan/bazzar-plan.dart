/* import 'package:flutter_poolakey/flutter_poolakey.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salamatiman/utils/constants.dart';
import 'package:salamatiman/view/plan/my_subscriptions/my_subscriptions_main.dart';

class BazzarPlanGetter extends GetxController {
  final rsaKey =
      "MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwC3Rj9Wkada6b3VwwJtB+4/AIU657J94Ck6z7Lz7KABAOL12p/J2rscEc/IGJXMtzPZlVxPjPwS8Bw9J2Xnuns0FG8sgwB3dgZ9LYe0yPrRXbUzxBZMIYU/KI/b125SLXibLJ5ABSK4fpvET4dKuJZR3uubm9Y6HCeCqD91ax8YdGwhCToROf90iJ+EVN5wJwaCamCN5ZpA18DyoSJrGq0t+S8SEgs4aJJnhewvVicCAwEAAQ==";
  RxBool isBazzarConnected = true.obs;
  RxList planList = [].obs;
  RxBool loading = true.obs;
  RxInt itemActive = 0.obs;
  Rx<PurchaseInfo>? purchaseInfo;
  RxList<PurchaseInfo> purchasedProductsList = <PurchaseInfo>[].obs;
  //purchaseToken
  //orderId
  //productId
  connect() async {
    try {
      await FlutterPoolakey.connect(rsaKey, onDisconnected: () {
        isBazzarConnected(false);
      });
    } on Exception catch (e) {
      isBazzarConnected(false);
    }
  }

  getPlans() async {
    if (loading.value == false) {
      loading(true);
    }
    try {
      final res =
          await FlutterPoolakey.getInAppSkuDetails(['golden', 'professional']);
      planList.value = [];
      planList.addAll(res);
    } on Exception catch (e) {
      planList([]);
    }
    if (loading.value == true) {
      loading(false);
    }
  }

  purchase({String? planSku}) async {
    try {
      PurchaseInfo result =
          await FlutterPoolakey.purchase('$planSku', payload: rsaKey);
      if (result != null) {
        Fluttertoast.showToast(msg: "با تشکر از خرید شما");
        Get.to(() => MySubscriptionsMain());
      }
      purchaseInfo!(result);
    } catch (e) {}
  }

  getPurchasedProducts() async {
    try {
      final result = await FlutterPoolakey.getAllSubscribedProducts();
      print(result[0].purchaseTime);
      if (result.isNotEmpty) {
        Constants.bazzarStatus = true;
        purchasedProductsList.value = [];
        purchasedProductsList.addAll(result);
      } else {
        Constants.bazzarStatus = false;
        purchasedProductsList([]);
      }
    } catch (e) {}
  }
}
 */
//bazarme