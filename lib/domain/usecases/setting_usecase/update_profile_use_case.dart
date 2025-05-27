import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/params/update_profile_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class UpdateProfileUseCase
    extends UseCase<BaseResponseModel<UserModel>, UpdateProfileParams> {
  final SettingRepository settingRepository;
  UpdateProfileUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>? call(
      UpdateProfileParams params) async {
    return await settingRepository.updateProfile(params);
  }
}
