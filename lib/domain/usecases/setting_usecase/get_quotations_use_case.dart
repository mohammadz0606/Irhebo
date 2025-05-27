import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetQuotationsUseCase extends UseCase<
    BaseResponseModel<PaginatedQuotationsModel>, PaginationParams> {
  final SettingRepository settingRepository;
  GetQuotationsUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedQuotationsModel>>>?
      call(PaginationParams params) async {
    return await settingRepository.getQuotations(params);
  }
}
