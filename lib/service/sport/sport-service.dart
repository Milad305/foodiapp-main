import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class SportService extends BaseService {
  static getSportCategories() async {
    final token = GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'exercise/categories',
      hasHeader: true,
      body: {
        "token": token,
      },
      loading: false,
    );
    return res;
  }

  static getSportRecords({required date}) async {
    final token = GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: 'exercise/records',
      hasHeader: true,
      body: {"token": token, "date": date},
      loading: false,
    );
    return res;
  }

  static exerciseSearch({required String? search}) async {
    final token = GetStorage().read('UserToken');
    return await BaseService.post(
      path: 'exercise/list',
      hasHeader: true,
      body: {
        "token": token,
        "search": search,
      },
      loading: false,
    );
  }

  static getSport({required int? categoryID}) async {
    final token = GetStorage().read('UserToken');
    return await BaseService.post(
      path: 'exercise/getByCid',
      hasHeader: true,
      body: {
        "token": token,
        "cid": categoryID,
      },
      loading: false,
    );
  }

  static addRecord(
      {required int? eid,
      required int? calories,
      required int? minutes,
      required String? date}) async {
    final token = GetStorage().read('UserToken');
    final myTime = DateTime.parse(date.toString());

    final timestamp = myTime.microsecondsSinceEpoch
        .toString()
        .substring(0, myTime.microsecondsSinceEpoch.toString().length - 6);
    print(timestamp);

    return await BaseService.post(
      path: 'exercise/AddRecord',
      hasHeader: true,
      body: {
        "token": token,
        "eid": eid,
        "calories": calories,
        "minutes": minutes,
        "app_time": (int.parse(timestamp.toString()) + 10).toString(),
      },
      loading: true,
    );
  }
}
