import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_usecase.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';

class GetTicketsUseCase
    extends UseCase<BaseResponseModel<List<TicketModel>>, void> {
  final SettingRepository settingRepository;
  GetTicketsUseCase({required this.settingRepository});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>? call(
      params) async {
    return await settingRepository.getTickets();
  }
}
