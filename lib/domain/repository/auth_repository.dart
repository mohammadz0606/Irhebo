import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_repository.dart';
import 'package:irhebo/data/auth_remote_data_source.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/models/otp_model.dart';
import 'package:irhebo/domain/params/login_params.dart';
import 'package:irhebo/domain/params/register_params.dart';
import 'package:irhebo/domain/params/reset_password_params.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/params/verify_otp_params.dart';

class AuthRepository extends BaseRepositoryImpl {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepository({
    required this.authRemoteDataSource,
    required super.networkInfo,
  }) : super(baseRemoteDataSource: authRemoteDataSource);

  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> loginUser(
      LoginParams params) async {
    try {
      final result = await authRemoteDataSource.login(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> resetPassword(
      ResetPasswordParams params) async {
    try {
      final result = await authRemoteDataSource.resetPassword(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>> verifyOtp(
      VerifyOtpParams params) async {
    try {
      final result = await authRemoteDataSource.verifyOtp(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> register(
      RegisterParams params) async {
    try {
      final result = await authRemoteDataSource.register(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> logout() async {
    try {
      final result = await authRemoteDataSource.logout();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<OtpModel>>> sendOtp(
      SendOtpParams params) async {
    try {
      final result = await authRemoteDataSource.sendOtp(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
