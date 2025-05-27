import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetQuotationDetailsUseCase
    extends UseCase<BaseResponseModel<QuotationModel>, int> {
  final SettingRepository settingRepository;
  GetQuotationDetailsUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>? call(
      int params) async {
    return await settingRepository.getQuotationDetails(params);
  }
}
