import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetPortfolioDetailsUseCase
    extends UseCase<BaseResponseModel<DataModel>, int> {
  final HomeRepository homeRepository;
  GetPortfolioDetailsUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<DataModel>>>? call(
      int params) async {
    return await homeRepository.portfolioDetails(params);
  }
}
