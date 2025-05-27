import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetServiceDetailsUseCase
    extends UseCase<BaseResponseModel<ServiceDetailsModel>, int> {
  final HomeRepository homeRepository;
  GetServiceDetailsUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<ServiceDetailsModel>>>? call(
      int params) async {
    return await homeRepository.serviceDetails(params);
  }
}
