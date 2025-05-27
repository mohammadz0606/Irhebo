import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetHomeUseCase extends UseCase<BaseResponseModel<HomeModel>, void> {
  final HomeRepository homeRepository;
  GetHomeUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<HomeModel>>>? call(
      params) async {
    return await homeRepository.getHome();
  }
}
