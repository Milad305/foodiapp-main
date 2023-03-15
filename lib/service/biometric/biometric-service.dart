import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class BiometricService extends BaseService {
  getBiometricList() async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: "biometric/index",
        hasToken: true,
        hasHeader: true,
        loading: false,
        body: {"token": token});
    return res;
  }

  getBiometricRecord({required date}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: "biometric/records",
      hasToken: true,
      hasHeader: true,
      loading: true,
      body: {"token": token, "date": date.toString()},
    );
    return res;
  }

  getBiometricDeleteRecord({required id}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: "record/deleteByIds",
      hasToken: true,
      hasHeader: true,
      loading: true,
      body: {"token": token, "rids": id},
    );
    return res;
  }

  setBiometricAddRecord({
    required int? bid,
    required int? amount,
    required String? unit,
    required String? appTime,
  }) async {
    final CurrentTime = DateTime.now().toString().split(" ")[1].toString();

    final time = DateTime.parse(appTime.toString() + " " + CurrentTime);
    final timestamp = time.microsecondsSinceEpoch
        .toString()
        .substring(0, time.microsecondsSinceEpoch.toString().length - 6);
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
        path: "biometric/addRecord",
        hasToken: true,
        hasHeader: true,
        loading: false,
        body: {
          "token": token,
          "bid": bid,
          "amount": amount,
          "unit": unit,
          "app_time": (int.parse(timestamp.toString()) + 10).toString()
        });
    return res;
  }
}
