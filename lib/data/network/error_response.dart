import 'package:dio/dio.dart';
import 'error_handler.dart';
import 'failure.dart';

Future<Failure> responseError(DioError error) async {
  var failure = await DataRes.DEFAULT.getFailure();
  return failure;
}
