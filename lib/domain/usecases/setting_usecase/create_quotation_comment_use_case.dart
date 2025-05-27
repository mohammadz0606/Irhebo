import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/params/create_comment_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class CreateQuotationCommentUseCase
    extends UseCase<BaseResponseModel<QuotationModel>, CreateCommentParams> {
  final SettingRepository settingRepository;
  CreateQuotationCommentUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>? call(
      CreateCommentParams params) async {
    return await settingRepository.createQuotationComment(params);
  }
}
