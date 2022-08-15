import 'package:dio/dio.dart';
import 'error_handler.dart';
import 'failure.dart';

Failure responseError(DioError error) {
  return DataRes.DEFAULT.getFailure();
}
