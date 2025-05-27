import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/params/register_params.dart';
import 'package:irhebo/domain/repository/auth_repository.dart';

class RegisterUseCase
    extends UseCase<BaseResponseModel<dynamic>, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      RegisterParams params) async {
    return await authRepository.register(params);
  }
}
