import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/notification_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetNotificationsUseCase extends UseCase<
    BaseResponseModel<PaginatedNotificationsModel>, PaginationParams> {
  final SettingRepository settingRepository;
  GetNotificationsUseCase({required this.settingRepository});

  @override
  Future<
      Either<BaseErrorModel,
          BaseResponseModel<PaginatedNotificationsModel>>>? call(
      PaginationParams params) async {
    return await settingRepository.getNotifications(params);
  }
}
