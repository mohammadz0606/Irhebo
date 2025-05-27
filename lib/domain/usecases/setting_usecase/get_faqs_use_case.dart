import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/faq_model.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetFaqsUseCase extends UseCase<BaseResponseModel<List<FaqModel>>, int?> {
  final SettingRepository settingRepository;
  GetFaqsUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<FaqModel>>>>? call(
      int? params) async {
    return await settingRepository.getFaqs(params);
  }
}
