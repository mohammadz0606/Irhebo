import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/params/create_ticket_params.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class CreateTicketUseCase
    extends UseCase<BaseResponseModel<TicketModel>, CreateTicketParams> {
  final SettingRepository settingRepository;
  CreateTicketUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>>? call(
      CreateTicketParams params) async {
    return await settingRepository.createTicket(params);
  }
}
