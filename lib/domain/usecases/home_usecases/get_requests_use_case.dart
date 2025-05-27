import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetRequestsUseCase
    extends UseCase<BaseResponseModel<List<RequestModel>>, void> {
  final HomeRepository homeRepository;
  GetRequestsUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<RequestModel>>>>? call(
      params) async {
    return await homeRepository.getRequests();
  }
}
