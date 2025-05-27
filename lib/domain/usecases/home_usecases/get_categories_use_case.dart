import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetCategoriesUseCase
    extends UseCase<BaseResponseModel<List<CategoryModel>>, void> {
  final HomeRepository homeRepository;
  GetCategoriesUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<CategoryModel>>>>? call(
      params) async {
    return await homeRepository.getCategories();
  }
}
