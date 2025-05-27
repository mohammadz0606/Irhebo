import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_repository.dart';
import 'package:irhebo/data/setting_remote_data_source.dart';
import 'package:irhebo/domain/models/faq_model.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/models/notification_model.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/models/ticket_model.dart';
import 'package:irhebo/domain/params/add_ticket_response_params.dart';
import 'package:irhebo/domain/params/create_comment_params.dart';
import 'package:irhebo/domain/params/create_quotation_params.dart';
import 'package:irhebo/domain/params/create_ticket_params.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/params/update_password_params.dart';
import 'package:irhebo/domain/params/update_profile_params.dart';

class SettingRepository extends BaseRepositoryImpl {
  final SettingRemoteDataSource settingRemoteDataSource;

  SettingRepository({
    required this.settingRemoteDataSource,
    required super.networkInfo,
  }) : super(baseRemoteDataSource: settingRemoteDataSource);

  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>
      getMyProfile() async {
    try {
      final result = await settingRemoteDataSource.getMyProfile();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedNotificationsModel>>>
      getNotifications(PaginationParams params) async {
    try {
      final result = await settingRemoteDataSource.getNotifications(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> readNotification(
      int id) async {
    try {
      final result = await settingRemoteDataSource.readNotification(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<FaqModel>>>> getFaqs(
      int? categoryId) async {
    try {
      final result = await settingRemoteDataSource.getFaqs(categoryId);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>
      getTickets() async {
    try {
      final result = await settingRemoteDataSource.getTickets();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>
      getTicketDetails(int? id) async {
    try {
      final result = await settingRemoteDataSource.getTicketDetails(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>> createTicket(
      CreateTicketParams params) async {
    try {
      final result = await settingRemoteDataSource.createTicket(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> createQuotation(
      CreateQuotationParams params) async {
    try {
      final result = await settingRemoteDataSource.createQuotation(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedQuotationsModel>>>
      getQuotations(PaginationParams params) async {
    try {
      final result = await settingRemoteDataSource.getQuotations(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>
      getQuotationDetails(int params) async {
    try {
      final result = await settingRemoteDataSource.getQuotationDetails(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>
      createQuotationComment(CreateCommentParams params) async {
    try {
      final result =
          await settingRemoteDataSource.createQuotationComment(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<QuotationCommentModel>>>>
      getQuotationComments(int params) async {
    try {
      final result = await settingRemoteDataSource.getQuotationComments(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>>
      addTicketResponse(AddTicketResponseParams? params) async {
    try {
      final result = await settingRemoteDataSource.addTicketResponse(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> closeTicket(
      int? id) async {
    try {
      final result = await settingRemoteDataSource.closeTicket(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>> updateProfile(
      UpdateProfileParams params) async {
    try {
      final result = await settingRemoteDataSource.updateProfile(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>
      updateProfilePicture(UpdateProfileParams params) async {
    try {
      final result = await settingRemoteDataSource.updateProfilePicture(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> updatePassword(
      UpdatePasswordParams params) async {
    try {
      final result = await settingRemoteDataSource.updatePassword(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
