import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';

abstract class AuthUser {
  static login(bool? loading,
      {required String? phone, required String? password}) async {
    if (loading! == null) {
      loading = true;
    }
    return await BaseService.post(
        path: 'auth/login',
        body: {"mobile": "${phone}", "password": "${password}"},
        loading: loading,
        hasToken: false);
  }

  static register(bool? loading, {required data}) async {
    if (loading! == null) {
      loading = true;
    }
    return await BaseService.post(
        path: 'user/register', body: data, loading: loading, hasHeader: true);
  }

  static sendVerificationSms(bool loading,
      {required String? phone, required String? autofillCode}) async {
    if (loading == null) {
      loading = true;
    }
    return await BaseService.post(
        path: 'user/send_verification_sms',
        body: {"mobile": "$phone", "autofill_code": "$autofillCode"},
        loading: loading,
        hasHeader: true,
        hasToken: true);
  }

  static checkVerificationCode(bool loading,
      {required String? phone, required String code}) async {
    if (loading == null) {
      loading = true;
    }
    return await BaseService.post(
        path: 'user/check_verification_code',
        body: {
          "mobile": "${phone}",
          "code": "${code}",
        },
        loading: loading,
        hasHeader: true,
        hasToken: false,
        timeOut: 100);
  }

  static me() async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: 'auth/me',
        body: {
          "token": token,
        },
        loading: false,
        hasHeader: true,
        hasToken: false);
  }

  static changeAvatar({required imgbytes}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: 'user/saveAvatar',
        body: {
          "token": token,
          "content": imgbytes,
        },
        loading: false,
        hasHeader: true,
        hasToken: false);
  }

  static changeProfileField({required name, required val}) async {
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: 'user/update',
        body: {
          "token": token,
          "field_name": name,
          "field_value": val,
        },
        loading: true,
        hasHeader: true,
        hasToken: true);
  }
}
