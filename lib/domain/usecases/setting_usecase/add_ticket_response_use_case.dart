import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/params/add_ticket_response_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class AddTicketResponseUseCase
    extends UseCase<BaseResponseModel<TicketModel>, AddTicketResponseParams> {
  final SettingRepository settingRepository;
  AddTicketResponseUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>>? call(
      AddTicketResponseParams params) async {
    return await settingRepository.addTicketResponse(params);
  }
}
