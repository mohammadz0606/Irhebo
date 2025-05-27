import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/slider_model.dart';
import 'package:irhebo/domain/repository/intro_repository.dart';

class GetStepsUseCase
    extends UseCase<BaseResponseModel<List<SliderModel>>, void> {
  final IntroRepository introRepository;
  GetStepsUseCase({required this.introRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<SliderModel>>>>? call(
      void params) async {
    return await introRepository.getSteps();
  }
}
