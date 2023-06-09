import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(
              responseType: ResponseType.json,
               method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    }).catchError((err) {
      if (err is DioError) {
        return err.response!;
      }
    });
  }


}
