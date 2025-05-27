import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/repository/intro_repository.dart';

class GetConfigUseCase extends UseCase<BaseResponseModel<ConfigModel>, void> {
  final IntroRepository introRepository;
  GetConfigUseCase({required this.introRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<ConfigModel>>>? call(
      void params) async {
    return await introRepository.getConfig();
  }
}
