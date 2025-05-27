import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/params/login_params.dart';
import 'package:irhebo/domain/repository/auth_repository.dart';

class LoginUseCase extends UseCase<BaseResponseModel<LoginModel>, LoginParams> {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<LoginModel>>>? call(
      LoginParams params) async {
    return await authRepository.loginUser(params);
  }
}
