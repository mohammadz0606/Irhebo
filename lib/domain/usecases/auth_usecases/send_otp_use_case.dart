import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/otp_model.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/repository/auth_repository.dart';

class SendOtpUseCase
    extends UseCase<BaseResponseModel<OtpModel>, SendOtpParams> {
  final AuthRepository authRepository;
  SendOtpUseCase({required this.authRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<OtpModel>>>? call(
      SendOtpParams params) async {
    return await authRepository.sendOtp(params);
  }
}
