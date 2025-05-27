import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/params/update_request_params.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class UpdateRequestUseCase
    extends UseCase<BaseResponseModel<dynamic>, UpdateRequestParams> {
  final HomeRepository homeRepository;
  UpdateRequestUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      UpdateRequestParams params) async {
    return await homeRepository.updateRequest(params);
  }
}
