import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/general_model.dart';
import 'package:irhebo/domain/repository/intro_repository.dart';

class GetGeneralUseCase extends UseCase<BaseResponseModel<GeneralModel>, void> {
  final IntroRepository introRepository;
  GetGeneralUseCase({required this.introRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<GeneralModel>>>? call(
      void params) async {
    return await introRepository.getGeneral();
  }
}
