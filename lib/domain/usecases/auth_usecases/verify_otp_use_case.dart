import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/params/verify_otp_params.dart';
import 'package:irhebo/domain/repository/auth_repository.dart';

class VerifyOtpUseCase
    extends UseCase<BaseResponseModel<LoginModel>, VerifyOtpParams> {
  final AuthRepository authRepository;
  VerifyOtpUseCase({required this.authRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>>? call(
      VerifyOtpParams params) async {
    return await authRepository.verifyOtp(params);
  }
}
