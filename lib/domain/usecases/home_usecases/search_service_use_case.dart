import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class SearchServiceUseCase
    extends UseCase<BaseResponseModel<AllServices>, PaginationParams> {
  final HomeRepository homeRepository;
  SearchServiceUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>? call(
      PaginationParams params) async {
    return await homeRepository.searchService(params);
  }
}
