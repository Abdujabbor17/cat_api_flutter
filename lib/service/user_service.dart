import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../core/api/api.dart';
import '../core/config/dio_config.dart';
import 'log_service.dart';

class CatService {
  static final CatService _inheritance = CatService._init();

  static CatService get inheritance => _inheritance;

  CatService._init();

  static Future<bool> uploadImage(String path) async {
    Log.wtf(path);
    try {
      String fileName = path.split('/').last;

      FormData formData = FormData.fromMap(
          {'file': await MultipartFile.fromFile(path,contentType: MediaType("image", "*"))});


      Response res = await Dio().post(
         'https://api.thecatapi.com/v1/images/upload',
          data: formData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "x-api-key": "live_qGrSBuBsNIvrXyHuuGchDXcmYO49yrMR7QUsmX3clAINWkbo7RbRHxwizOJ4jgjg"
          }));
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.i(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
}
