import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

class ChatServer extends BaseService {
  getConsultants() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          port: ":4000",
          path: "/api/v3/user/consultants",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }

  getConsultantMessages({required chatID, required int page}) async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          port: ":4000",
          path: "/api/v3/user/consultant_messages",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {
            "token": token,
            "tid": chatID,
            "page": page,
          });
    } catch (e) {
      print(e);
    }
  }

  getSpecialists() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "expert/index",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }

  getMySpecialists() async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "user/getExperts",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token});
    } catch (e) {
      print(e);
    }
  }

  setChatRating({required int rating, required int tid}) async {
    try {
      var token = await GetStorage().read('UserToken');
      return await BaseService.post(
          path: "expert/setChatRating",
          hasToken: true,
          hasHeader: true,
          loading: false,
          body: {"token": token, "tid": tid, "rating": rating});
    } catch (e) {
      print(e);
    }
  }
}
