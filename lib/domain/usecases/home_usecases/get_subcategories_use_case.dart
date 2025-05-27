import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetSubcategoriesUseCase
    extends UseCase<BaseResponseModel<List<SubcategoryModel>>, int> {
  final HomeRepository homeRepository;
  GetSubcategoriesUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<SubcategoryModel>>>>?
      call(int params) async {
    return await homeRepository.getSubcategories(params);
  }
}
