import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/params/reset_password_params.dart';
import 'package:irhebo/domain/repository/auth_repository.dart';

class ResetPasswordUseCase
    extends UseCase<BaseResponseModel<LoginModel>, ResetPasswordParams> {
  final AuthRepository authRepository;
  ResetPasswordUseCase({required this.authRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>>? call(
      ResetPasswordParams params) async {
    return await authRepository.resetPassword(params);
  }
}
