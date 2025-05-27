import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetWishlistUseCase
    extends UseCase<BaseResponseModel<List<ServiceModel>>, void> {
  final HomeRepository homeRepository;
  GetWishlistUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<ServiceModel>>>>? call(
      params) async {
    return await homeRepository.getWishlist();
  }
}
