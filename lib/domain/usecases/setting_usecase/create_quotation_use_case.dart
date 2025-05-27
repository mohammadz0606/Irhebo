import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/params/create_quotation_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class CreateQuotationUseCase
    extends UseCase<BaseResponseModel<dynamic>, CreateQuotationParams> {
  final SettingRepository settingRepository;
  CreateQuotationUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      CreateQuotationParams params) async {
    return await settingRepository.createQuotation(params);
  }
}
