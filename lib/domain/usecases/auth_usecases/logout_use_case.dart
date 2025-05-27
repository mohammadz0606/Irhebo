import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/repository/auth_repository.dart';

class LogoutUseCase extends UseCase<BaseResponseModel<dynamic>, void> {
  final AuthRepository authRepository;
  LogoutUseCase({required this.authRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      params) async {
    return await authRepository.logout();
  }
}
