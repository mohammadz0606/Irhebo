import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetMyProfileUseCase extends UseCase<BaseResponseModel<UserModel>, void> {
  final SettingRepository settingRepository;
  GetMyProfileUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>? call(
      params) async {
    return await settingRepository.getMyProfile();
  }
}
