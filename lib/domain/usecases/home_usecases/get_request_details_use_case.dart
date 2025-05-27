import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetRequestDetailsUseCase
    extends UseCase<BaseResponseModel<RequestModel>, int> {
  final HomeRepository homeRepository;
  GetRequestDetailsUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<RequestModel>>>? call(
      int params) async {
    return await homeRepository.getRequestDetails(params);
  }
}
