// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/main.dart';
import 'error_response.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error from dio or api
      failure = _handleError(error)!;
    } else {
      // default error
      DataRes.DEFAULT.getFailure().then((value) => failure = value);
    }
  }

  Failure? _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        DataRes.CONNECT_TIMEOUT.getFailure().then((value) => value);
        break;
      case DioErrorType.sendTimeout:
        DataRes.SEND_TIMEOUT.getFailure().then((value) => value);
        break;

      case DioErrorType.receiveTimeout:
        DataRes.RECEIVED_TIMEOUT.getFailure().then((value) => value);
        break;

      case DioErrorType.response:
        responseError(error);
        break;

      case DioErrorType.cancel:
        DataRes.CANCEL.getFailure().then((value) => value);
        break;

      case DioErrorType.other:
        DataRes.DEFAULT.getFailure().then((value) => value);
        break;
    }
  }
}

enum DataRes {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  METHOD_NOT_ALLOWED,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVED_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataResExtension on DataRes {
  Future<Failure> getFailure() async => Failure(
      ResponseCode.getCode(this), await ResponseMessage.getMessage(this));
}

class ResponseCode {
  static int getCode(DataRes codeStatus) {
    switch (codeStatus) {
      case DataRes.SUCCESS:
        return 200;
      case DataRes.NO_CONTENT:
        return 201;
      case DataRes.BAD_REQUEST:
        return 400;
      case DataRes.UNAUTHORIZED:
        return 401;
      case DataRes.FORBIDDEN:
        return 403;
      case DataRes.METHOD_NOT_ALLOWED:
        return 405;
      case DataRes.NOT_FOUND:
        return 404;
      case DataRes.INTERNAL_SERVER_ERROR:
        return 500;

      // local
      case DataRes.CONNECT_TIMEOUT:
        return -1;
      case DataRes.CANCEL:
        return -2;
      case DataRes.RECEIVED_TIMEOUT:
        return -3;
      case DataRes.SEND_TIMEOUT:
        return -4;

      case DataRes.CACHE_ERROR:
        return -5;

      case DataRes.NO_INTERNET_CONNECTION:
        return -6;
      default:
        return -7;
    }
  }
}

class ResponseMessage {
  static Future<String> get _tryAgainLater async {
    return await AppLocalizations.delegate
        .load(Locale(language!))
        .then((value) => value.try_again_later);
  }

  static Future<String> get _timeOut async {
    return await AppLocalizations.delegate
        .load(Locale(language!))
        .then((value) => value.time_out);
  }

  static Future<String> get _connectSupport async {
    return await AppLocalizations.delegate
        .load(Locale(language!))
        .then((value) => value.contact_support);
  }

  static Future<String> get _someThingWentWrong async {
    return await AppLocalizations.delegate
        .load(Locale(language!))
        .then((value) => value.some_thing_went_wrong);
  }

  static Future<String> getMessage(DataRes codeStatus) async {
    switch (codeStatus) {
      case DataRes.SUCCESS:
        return "";
      case DataRes.NO_CONTENT:
        return "";
      case DataRes.BAD_REQUEST:
        return "${"Bad Request"} , $_tryAgainLater";
      case DataRes.UNAUTHORIZED:
        return "Authorization failed";
      case DataRes.FORBIDDEN:
        return "${"Forbidden"} ,  $_tryAgainLater";
      case DataRes.METHOD_NOT_ALLOWED:
        return "${"Method Not Allowed"} , $_connectSupport";
      case DataRes.NOT_FOUND:
        return "${"Page Not Found"} ,  $_connectSupport";
      case DataRes.INTERNAL_SERVER_ERROR:
        return "$_someThingWentWrong , $_connectSupport";

// local
      case DataRes.CONNECT_TIMEOUT:
        return "$_timeOut  ,  $_tryAgainLater";
      case DataRes.CANCEL:
        return "Request was cancelled , $_tryAgainLater";
      case DataRes.RECEIVED_TIMEOUT:
        return "$_timeOut , $_tryAgainLater";
      case DataRes.SEND_TIMEOUT:
        return "$_timeOut , $_tryAgainLater";

      case DataRes.CACHE_ERROR:
        return "${"cache error"} , $_tryAgainLater";

      case DataRes.NO_INTERNET_CONNECTION:
        return "NO INTERNET CONNECTION";
      default:
        return "$_someThingWentWrong , $_connectSupport";
    }
  }
}
