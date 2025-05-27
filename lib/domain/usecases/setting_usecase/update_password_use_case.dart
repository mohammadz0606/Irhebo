import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/params/update_password_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class UpdatePasswordUseCase
    extends UseCase<BaseResponseModel<dynamic>, UpdatePasswordParams> {
  final SettingRepository settingRepository;
  UpdatePasswordUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>>? call(
      UpdatePasswordParams params) async {
    return await settingRepository.updatePassword(params);
  }
}
