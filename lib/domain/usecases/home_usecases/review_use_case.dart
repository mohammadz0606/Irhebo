import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/params/rate_params.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class ReviewUseCase extends UseCase<BaseResponseModel<dynamic>, RateParams> {
  final HomeRepository homeRepository;
  ReviewUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      RateParams params) async {
    return await homeRepository.review(params);
  }
}
