import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class NotrientService extends BaseService {
  static getNotrient({required date, required gid}) async {
    var res = await BaseService.post(
      path: 'common/get_together',
      hasHeader: true,
      body: {
        "token": GetStorage().read('UserToken'),
        "date": date,
        "gid": gid,
        "apis": ["/api/v2/target/get_nutrients_daily_average"],
        "mode": "all",
        "groupby": "category"
      },
      loading: false,
    );
    return res;
  }
}
