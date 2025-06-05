import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_remote_data_source.dart';
import 'package:irhebo/app/error/failures.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/logger_colors.dart';
import 'package:irhebo/app/snack_bar.dart';
import 'package:irhebo/app/storage/app_prefs.dart';

import '../network/network_info.dart';
import '../storage/app_prefs_keys.dart';

typedef FutureEitherOr<T> = Future<Either<BaseErrorModel, T>> Function();
typedef FutureEitherOrWithToken<T> = Future<Either<BaseErrorModel, T>> Function(
  String token,
);

abstract class BaseRepository {
  Future<Either<BaseErrorModel, T>> checkNetwork<T>(FutureEitherOr<T> body);

// Future<Either<Failure, void>> getUser();
}

/// [BaseRepositoryImpl] is the implementation of the [BaseRepository] interface
/// each repository must extend this class and implement a sub-interface of [BaseRepository] interface.
class BaseRepositoryImpl implements BaseRepository {
  final NetworkInfo networkInfo;
  final BaseRemoteDataSource baseRemoteDataSource;

  BaseRepositoryImpl({
    required this.networkInfo,
    required this.baseRemoteDataSource,
  });

  @override
  Future<Either<BaseErrorModel, T>> checkNetwork<T>(
      FutureEitherOr<T> body) async {
    if (await networkInfo.isConnected) {
      return body();
    } else {
      AppSnackBar.openErrorSnackBar(message: 'No Internet Connection'.tr);
      // return Left(ServerFailure(ErrorCode.NO_INTERNET_CONNECTION, "noInternet".tr));
      // AppSnackBar.showToast('No Internet Connection');
      return Left(BaseErrorModel(
        message: 'No Internet Connection',
        status: false,
      ));
      // throw BaseErrorModel(
      //     message: 'No Internet Connection', status: 0, success: false);
    }
  }

  Future<Either<Failure, String>> getToken() async {
    AppPreferences instance = sl();
    String token = instance.getAccessToken();
    if (token.isNotEmpty) {
      return Right(token);
    } else {
      return Left(CacheFailure());
    }
  }

  Future<Either<BaseErrorModel, T>> requestWithToken<T>(
    FutureEitherOrWithToken<T> body,
  ) async {
    return await checkNetwork<T>(() async {
      // try {
      final token = await getToken();
      // log('${LoggerColors.green} token is $token');
      return await token.fold(
        (failure) => body(''),
        (token) async {
          return body(token);
        },
      );
    });
  }

  Future<Either<Failure, void>> refreshSession() async {
    try {
      return const Right(null);
    } catch (e) {
      log('${AppLoggerColors.red} catch');
      log('${AppLoggerColors.red} e is $e');
      // return Left(ServerFailure(ErrorCode.UNAUTHENTICATED, ''));
      rethrow;
    }
  }
}

///
/// [GetOptions] class is for gathering all the options for the [Dio] package in one class
///
class GetOptions {
  static Options options = Options();

  static Options getOptionsWithToken(String token,
      {String? language,
      bool isUploadFile = false,
      bool isPutRequest = false}) {
    AppPreferences prefs = sl();

    String accessToken = prefs.getAccessToken();
    // log(AppLoggerColors.magenta + accessToken.toString() + " toto");
    if (accessToken.isNotEmpty) {
      options.headers = {
        'Content-Type': isUploadFile
            ? Headers.multipartFormDataContentType
            : 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': Get.find<AppController>().lang.value.languageCode,
        'lang': Get.find<AppController>().lang.value.languageCode,
        // 'currency': Get.find<AppController>().currency,
        'Device-Type': Platform.isAndroid ? 'Android' : 'IOS',
        'currency': AppPreferences(sl()).getString(key: AppPrefsKeys.CURRENCY) ?? 'USD',
      };
      options.validateStatus = (status) => status! < 500;
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': language ?? Get.locale?.languageCode,
        'lang': language ?? Get.locale?.languageCode,
        // 'applicationToken': applicationTokenModel?.applicationToken,
        // 'currency': Get.find<AppController>().currency,
        'Device-Type': Platform.isAndroid ? 'Android' : 'IOS',
        'currency': AppPreferences(sl()).getString(key: AppPrefsKeys.CURRENCY) ?? 'USD',
      };
      options.validateStatus = (status) => status! < 500;
    }
    return options;
  }
}
