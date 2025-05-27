import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/repository/home_repository.dart';

class GetFreelancerProfileUseCase extends UseCase<
    BaseResponseModel<FreelancerDetailsModel>, PaginationParams> {
  final HomeRepository homeRepository;
  GetFreelancerProfileUseCase({required this.homeRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<FreelancerDetailsModel>>>?
      call(PaginationParams params) async {
    return await homeRepository.getFreelancerProfile(params);
  }
}
