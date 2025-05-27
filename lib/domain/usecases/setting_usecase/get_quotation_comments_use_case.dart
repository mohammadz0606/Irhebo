import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetQuotationCommentsUseCase
    extends UseCase<BaseResponseModel<List<QuotationCommentModel>>, int> {
  final SettingRepository settingRepository;
  GetQuotationCommentsUseCase({required this.settingRepository});

  @override
  Future<
      Either<BaseErrorModel,
          BaseResponseModel<List<QuotationCommentModel>>>>? call(
      int params) async {
    return await settingRepository.getQuotationComments(params);
  }
}
