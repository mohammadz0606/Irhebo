import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class CloseTicketUseCase extends UseCase<BaseResponseModel<dynamic>, int> {
  final SettingRepository settingRepository;
  CloseTicketUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      int params) async {
    return await settingRepository.closeTicket(params);
  }
}
