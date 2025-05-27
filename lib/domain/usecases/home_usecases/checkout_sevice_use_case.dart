import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/checkout_model.dart';
import 'package:irhebo/domain/params/create_request_params.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class CheckoutSeviceUseCase extends UseCase<
    BaseResponseModel<CheckoutServiceModel>, CreateRequestParams> {
  final HomeRepository homeRepository;
  CheckoutSeviceUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<CheckoutServiceModel>>>? call(
      CreateRequestParams params) async {
    return await homeRepository.checkout(params);
  }
}
