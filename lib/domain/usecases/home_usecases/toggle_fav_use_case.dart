import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class ToggleFavUseCase extends UseCase<BaseResponseModel<dynamic>, int> {
  final HomeRepository homeRepository;
  ToggleFavUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      int params) async {
    return await homeRepository.toggleFav(params);
  }
}
