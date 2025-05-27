import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetServicesFiltersUseCase
    extends UseCase<BaseResponseModel<List<FilterModel>>, int> {
  final HomeRepository homeRepository;
  GetServicesFiltersUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<FilterModel>>>>? call(
      int params) async {
    return await homeRepository.getServicesFilters(params);
  }
}
