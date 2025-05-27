import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_remote_data_source.dart';
import 'package:irhebo/app/end_points.dart';
import 'package:irhebo/app/resources/logger_colors.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/models/otp_model.dart';
import 'package:irhebo/domain/params/reset_password_params.dart';
import 'package:irhebo/domain/params/login_params.dart';
import 'package:irhebo/domain/params/register_params.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/params/verify_otp_params.dart';

abstract class AuthRemoteDataSource extends BaseRemoteDataSourceImpl {
  AuthRemoteDataSource({required super.dio});

  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> login(
      LoginParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> resetPassword(
      ResetPasswordParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> verifyOtp(
      VerifyOtpParams params);
  Future<Either<BaseErrorModel, BaseResponseModel<OtpModel>>> sendOtp(
      SendOtpParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> register(
      RegisterParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> logout();
}

class AuthRemoteDataSourceImp extends BaseRemoteDataSourceImpl
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImp({required super.dio});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> login(
      LoginParams params) async {
    try {
      final response = await performPostRequest<LoginModel>(
        endpoint: AppEndpoints.login,
        body: params.toJson(),
        fromJson: LoginModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> logout() async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: AppEndpoints.logout,
        body: {},
        fromJson: (p0) => {},
        hasDataBody: false,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> verifyOtp(
      VerifyOtpParams params) async {
    try {
      final response = await performPostRequest<LoginModel>(
        endpoint: AppEndpoints.verifyCode,
        body: params.toJson(),
        fromJson: LoginModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> resetPassword(
      ResetPasswordParams params) async {
    try {
      final response = await performPostRequest<LoginModel>(
        endpoint: AppEndpoints.resetPassword,
        body: params.toJson(),
        fromJson: LoginModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> register(
      RegisterParams params) async {
    try {
      final response = await performPostRequest<dynamic>(
          endpoint: AppEndpoints.register,
          body: params.toJson(),
          fromJson: (p0) => {},
          hasDataBody: false);
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<OtpModel>>> sendOtp(
      SendOtpParams params) async {
    try {
      final response = await performPostRequest<OtpModel>(
        endpoint: AppEndpoints.requestCode,
        body: params.toJson(),
        fromJson: OtpModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }
}
