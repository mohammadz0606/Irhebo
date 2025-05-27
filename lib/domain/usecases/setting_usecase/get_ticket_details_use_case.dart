import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetTicketDetailsUseCase
    extends UseCase<BaseResponseModel<List<TicketModel>>, int> {
  final SettingRepository settingRepository;
  GetTicketDetailsUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>? call(
      int params) async {
    return await settingRepository.getTicketDetails(params);
  }
}
