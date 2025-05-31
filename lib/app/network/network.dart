import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '../app_controller.dart';
import '../enums.dart';
import '../error/error_handler.dart';
import '../injection.dart';
import '../storage/app_prefs.dart';

final class Network {
  /// Singleton class

  Network._();

  static final Network _instance = Network._();

  factory Network() {
    return _instance;
  }

  late Dio _dio;

  void init() {
    BaseOptions options =
    BaseOptions(headers: {'ContentType': 'application/json'});
    _dio = Dio(options);

    if (kDebugMode) {
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
            printResponseMessage: true,
            printRequestData: true,
            printResponseData: true,
            printErrorData: true,
            printErrorMessage: true,
          ),
        ),
      );
    }
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    bool isUploadFile = false,
  }) async {
    Response response = await _dio.post(
      url,
      data: data,
      queryParameters: query,
      options: _buildOptions(isUploadFile: isUploadFile),
    );

    return response;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    bool isUploadFile = false,
  }) async {
    _dio.options.headers = {};

    final response = await _dio.get(
      url,
      queryParameters: query,
      data: data,
      options: _buildOptions(isUploadFile: isUploadFile),
    );
    return response;
  }

  Options _buildOptions({
    bool isUploadFile = false,
  }) {
    final headers = <String, dynamic>{
      'Content-Type': isUploadFile
          ? Headers.multipartFormDataContentType
          : 'application/json',
      'Accept': 'application/json',
      'Accept-Language': Get
          .find<AppController>()
          .lang
          .value
          .languageCode,
      'lang': Get
          .find<AppController>()
          .lang
          .value
          .languageCode,
      'Device-Type': Platform.isAndroid ? 'Android' : 'IOS',
    };
    AppPreferences prefs = sl();
    String token = prefs.getAccessToken();
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return Options(
      headers: headers,
      validateStatus: (status) => status != null && status < 500,
    );
  }

  Future<String> handelError({required Response response}) async {
    if (response.statusCode != 200) {
      return response.data['message'];
    }
    return '';
  }

  String handelDioException(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT);
    } else if (error.type == DioExceptionType.badResponse) {
      return ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST);
    } else {
      return ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR);
    }
  }
}
