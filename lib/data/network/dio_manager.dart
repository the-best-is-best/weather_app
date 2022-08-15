import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/const.dart';

class DioManger {
  static late Dio dioApi;

  static init() async {
    dioApi = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        // validateStatus: (v) => v! < 500,
        connectTimeout: Const.timeOut,
        receiveTimeout: Const.timeOut,
        headers: {
          'CONTENT-TYPE': Const.contentType,
          'ACCEPT': Const.contentType,
          "AUTHORIZATION": Const.token,
        },
      ),
    );

    if (!kReleaseMode) {
      dioApi.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
  }
}
