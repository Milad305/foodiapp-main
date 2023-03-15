import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class PlanServer extends BaseService {
  getPlanList() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "plan/index",
          hasToken: true,
          hasHeader: true,
          loading: true,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }

  getUserSubscriptions() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "plan/getUserSubscriptions",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }

  getUserTransactions() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "plan/getUserTransactions",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }

  getPlanCoupon() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "plan/offs",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }
}
