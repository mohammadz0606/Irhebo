import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_pagination_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_repository.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/error/error_handler.dart';
import 'package:irhebo/app/error/exceptions.dart';
import 'package:irhebo/app/snack_bar.dart';
import 'package:irhebo/app/storage/app_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

abstract class BaseRemoteDataSource {
  ///GET AND GET LIST

  @protected
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performGetRequest<T>(
      {required String endpoint,
      required T Function(Map<String, dynamic>) fromJson,
      String token = ''});

  @protected
  Future<Either<BaseErrorModel, BaseResponseModel<List<T>>>>
      performGetListRequest<T>(
          {required String endpoint,
          required T Function(Map<String, dynamic>) fromJson,
          String token = ''});

  ///GET PAGINATED LIST

  @protected
  Future<Either<BaseErrorModel, BaseResponseModel<BasePaginationModel<T>>>>
      performGetPaginatedListRequest<T>(
          {required String endpoint,
          required T Function(Map<String, dynamic>) fromJson,
          String token = ''});

  ///POST AND POST LIST AND POST FORMDATA
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performPostRequest<T>(
      {required String endpoint,
      required Map<String, dynamic> body,
      required T Function(Map<String, dynamic>) fromJson,
      String token = ''});

  Future<Either<BaseErrorModel, BaseResponseModel<T>>>
      performPostRequestWithFormData<T>(
          {required String endpoint,
          required d.FormData body,
          required T Function(Map<String, dynamic>) fromJson,
          String token = ''});

  ///PUT
  @protected
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performPutRequest<T>(
      {required String endpoint,
      required Map<String, dynamic>? body,
      required T Function(Map<String, dynamic>) fromJson,
      String token = ''});

  ///PATCH
  @protected
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performPatchRequest<T>(
      {required String endpoint,
      required T Function(Map<String, dynamic>) fromJson,
      required Map<String, dynamic>? body,
      String token = ''});

  /// DELETE AND DOWNLOAD

  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performDeleteRequest<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    String token = '',
  });

  Future<dynamic> performDownloadRequest(String url, String path);

// @protected
// Future<T> performGetPagenation<T>(String endPoint, T Function(Map<String, dynamic>) fromJson, {String? listName, Map<String, dynamic>? params});
}

class BaseRemoteDataSourceImpl extends BaseRemoteDataSource {
  final Dio dio;

  BaseRemoteDataSourceImpl({required this.dio});

  ///GET
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performGetRequest<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    String token = '',
    bool isMap = true,
    Map<String, dynamic>? params,
    bool hasDataBody = true,
    String? language,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
        options:
            GetOptions.getOptionsWithToken(token, language: language ?? 'en'),
      );
      if (!hasDataBody) {
        return Right(BaseResponseModel.fromJson(
            json.decode(response.data), response.statusCode!));
      }

      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, response.statusMessage ?? '')) {
        T baseResponse = fromJson(json.decode(response.data)['data']);
        baseResponse = fromJson(json.decode(response.data)["data"]);
        if (baseResponse != null) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!,
              fromJson: () => fromJson(json.decode(response.data)["data"])));
        } else {
          return Left(BaseErrorModel.fromJson(json.decode(response.data)));
        }
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///GET LIST
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<T>>>>
      performGetListRequest<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    String? token = '',
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
        options: GetOptions.getOptionsWithToken(token!),
      );
      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, response.statusMessage ?? '')) {
        final List<T> list = [];
        // ignore: unused_local_variable
        final List data;
        data = json.decode(response.data)['data'] as List;
        for (var element in data) {
          if (element == null) continue;
          list.add(fromJson(element));
        }

        return Right(BaseResponseModel(
            data: list,
            status: json.decode(response.data)['status'],
            message: json.decode(response.data)['message'],
            statusCode: response.statusCode!));
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///GET PAGINATED LIST
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<BasePaginationModel<T>>>>
      performGetPaginatedListRequest<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    String? token = '',
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
        options: GetOptions.getOptionsWithToken(token!),
      );
      if (response.statusCode == 401) {
        SharedPreferences prefrences = await SharedPreferences.getInstance();
        prefrences.remove(AppPrefsKeys.TOKEN);
      }
      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, response.statusMessage ?? '')) {
        return Right(BaseResponseModel.fromJsonPaginated(
          response: json.decode(response.data),
          fromJson: (jsonn) => BasePaginationModel.fromJson(
              response: jsonn, fromJsonT: (data) => fromJson(data)),
        ));
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///DELETE
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performDeleteRequest<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? extraHeader,
    bool isEmptyRequest = false,
    bool hasDataBody = true,
    String token = '',
  }) async {
    try {
      final op = GetOptions.getOptionsWithToken(token);
      op.headers!.addAll(extraHeader ?? {});
      final response = await dio.delete(endpoint, options: op);
      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, json.decode(response.data)['message'])) {
        final T? baseResponse;
        if (!hasDataBody) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!));
        }
        if (isEmptyRequest) {
          baseResponse = fromJson(json.decode(response.data));
        } else {
          baseResponse = fromJson(json.decode(response.data)["data"]);
        }
        if (baseResponse != null) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!,
              fromJson: () => fromJson(json.decode(response.data)["data"])));
        } else {
          return Left(BaseErrorModel.fromJson(json.decode(response.data)));
        }
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///POST
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performPostRequest<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? extraHeader,
    bool isEmptyRequest = false,
    bool hasDataBody = true,
    String token = '',
  }) async {
    try {
      final op = GetOptions.getOptionsWithToken(token);
      op.headers!.addAll(extraHeader ?? {});
      final response = await dio.post(endpoint, data: body, options: op);
      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, json.decode(response.data)['message'])) {
        final T? baseResponse;
        if (!hasDataBody) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!));
        }

        baseResponse = fromJson(json.decode(response.data)["data"]);
        if (baseResponse != null) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!,
              fromJson: () => fromJson(json.decode(response.data)["data"])));
        } else {
          return Left(BaseErrorModel.fromJson(json.decode(response.data)));
        }
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///POST FORMDATA
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<T>>>
      performPostRequestWithFormData<T>({
    required String endpoint,
    required d.FormData body,
    required T Function(Map<String, dynamic>) fromJson,
    String token = '',
    bool isUploadFile = false,
  }) async {
    try {
      final op = GetOptions.getOptionsWithToken(token,
          isPutRequest: true, isUploadFile: true);
      final response = await dio.post(endpoint, data: body, options: op);
      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, json.decode(response.data)['message'])) {
        final T? baseResponse;

        baseResponse = fromJson(json.decode(response.data)["data"]);
        if (baseResponse != null) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!,
              fromJson: () => fromJson(json.decode(response.data)["data"])));
        } else {
          return Left(BaseErrorModel.fromJson(json.decode(response.data)));
        }
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///PUT
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performPutRequest<T>(
      {required String endpoint,
      required Map<String, dynamic>? body,
      required T Function(Map<String, dynamic>) fromJson,
      String token = '',
      // d.FormData? formData,
      bool isMap = true,
      Map<String, dynamic>? extraHeader,
      bool isEmptyRequest = false,
      bool hasDataBody = true,
      bool isPutRequest = false}) async {
    try {
      final op =
          GetOptions.getOptionsWithToken(token, isPutRequest: isPutRequest);
      op.headers!.addAll(extraHeader ?? {});
      final response = await dio.put(
        endpoint,
        data: body,
        // data: formData ?? data,
        options: op,
      );
      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, json.decode(response.data)['message'])) {
        final T? baseResponse;
        if (!hasDataBody) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!));
        }

        baseResponse = fromJson(json.decode(response.data)["data"]);
        if (baseResponse != null) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!,
              fromJson: () => fromJson(json.decode(response.data)["data"])));
        } else {
          return Left(BaseErrorModel.fromJson(json.decode(response.data)));
        }
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///PATCH
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<T>>> performPatchRequest<T>(
      {required String endpoint,
      required T Function(Map<String, dynamic>) fromJson,
      required Map<String, dynamic>? body,
      String token = '',
      d.FormData? formData,
      bool isForm = false}) async {
    try {
      final op = GetOptions.getOptionsWithToken(token,
          isPutRequest: true, isUploadFile: isForm);
      final response = await dio.patch(
        endpoint,
        data: formData ?? body,
        options: op,
      );

      if (await ErrorHandler.handleRemoteError(
          response.statusCode!, json.decode(response.data)['message'])) {
        final T? baseResponse;

        baseResponse = fromJson(json.decode(response.data)["data"]);
        if (baseResponse != null) {
          return Right(BaseResponseModel.fromJson(
              json.decode(response.data), response.statusCode!,
              fromJson: () => fromJson(json.decode(response.data)["data"])));
        } else {
          return Left(BaseErrorModel.fromJson(json.decode(response.data)));
        }
      } else {
        AppSnackBar.openErrorSnackBar(
            message: json.decode(response.data)['message']);
        return Left(BaseErrorModel.fromJson(json.decode(response.data)));
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout ||
          ex.type == DioExceptionType.connectionError ||
          ex.type == DioExceptionType.receiveTimeout ||
          ex.type == DioExceptionType.sendTimeout) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.TIMEOUT)));
      } else if (ex.type == DioExceptionType.badResponse) {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.BAD_REQUEST)));
      } else {
        return Left(BaseErrorModel(
            message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
      }
    } catch (e) {
      return Left(BaseErrorModel(
          message: ErrorHandler.getErrorMessage(ErrorCode.SERVER_ERROR)));
    }
  }

  ///DOWNLOAD
  @override
  Future<dynamic> performDownloadRequest(String url, String path) async {
    try {
      final response = await dio.download(url, path,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: const Duration(minutes: 2)));
      if (response.statusCode == 200) return response.data;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      if (e is DioException) {
        ErrorHandler.handleRemoteError(
            e.response?.statusCode ?? 404, e.message.toString());
        rethrow;
      } else {
        // log("TTTTTTTTTTT");
        throw ServerException(ErrorCode.PARSE_ERROR, '');
      }
    }
  }
}
