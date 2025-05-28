import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_remote_data_source.dart';
import 'package:irhebo/app/network/end_points.dart';
import 'package:irhebo/app/resources/logger_colors.dart';
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

abstract class SettingRemoteDataSource extends BaseRemoteDataSourceImpl {
  SettingRemoteDataSource({required super.dio});
  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>> getMyProfile();

  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedNotificationsModel>>>
      getNotifications(PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> readNotification(
      int id);

  Future<Either<BaseErrorModel, BaseResponseModel<List<FaqModel>>>> getFaqs(
      int? categoryId);

  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>
      getTickets();

  Future<Either<BaseErrorModel, BaseResponseModel<List<QuotationCommentModel>>>>
      getQuotationComments(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedQuotationsModel>>>
      getQuotations(PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>
      getTicketDetails(int? id);

  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>
      getQuotationDetails(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>> createTicket(
      CreateTicketParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> createQuotation(
      CreateQuotationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>
      createQuotationComment(CreateCommentParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>>
      addTicketResponse(AddTicketResponseParams? params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> closeTicket(
      int? id);

  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>> updateProfile(
      UpdateProfileParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>
      updateProfilePicture(UpdateProfileParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> updatePassword(
      UpdatePasswordParams params);
}

class SettingRemoteDataSourceImp extends BaseRemoteDataSourceImpl
    implements SettingRemoteDataSource {
  SettingRemoteDataSourceImp({required super.dio});
  @override
  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>
      getMyProfile() async {
    try {
      final response = await performGetRequest<UserModel>(
        endpoint: AppEndpoints.myProfile,
        params: {},
        fromJson: UserModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>
      getQuotationDetails(int id) async {
    try {
      final response = await performGetRequest<QuotationModel>(
        endpoint: "${AppEndpoints.quotationDetails}$id",
        params: {},
        fromJson: QuotationModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedNotificationsModel>>>
      getNotifications(PaginationParams params) async {
    try {
      final response = await performGetRequest<PaginatedNotificationsModel>(
        endpoint: AppEndpoints.notifications,
        params: params.toJson(),
        fromJson: PaginatedNotificationsModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedQuotationsModel>>>
      getQuotations(PaginationParams params) async {
    try {
      final response = await performGetRequest<PaginatedQuotationsModel>(
        endpoint: AppEndpoints.quotations,
        params: params.toJson(),
        fromJson: PaginatedQuotationsModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> readNotification(
      int id) async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: AppEndpoints.readNotification,
        body: {"notification_id": id},
        fromJson: (p0) {},
        hasDataBody: false,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<FaqModel>>>> getFaqs(
      int? categoryId) async {
    try {
      final response = await performGetListRequest<FaqModel>(
        endpoint: categoryId != null
            ? "${AppEndpoints.faqs}?category_id=$categoryId"
            : AppEndpoints.faqs,
        params: {},
        fromJson: FaqModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<QuotationCommentModel>>>>
      getQuotationComments(int id) async {
    try {
      final response = await performGetListRequest<QuotationCommentModel>(
        endpoint: AppEndpoints.quotationCommentList + id.toString(),
        params: {},
        fromJson: QuotationCommentModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>
      getTickets() async {
    try {
      final response = await performGetListRequest<TicketModel>(
        endpoint: AppEndpoints.tickets,
        params: {},
        fromJson: TicketModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<TicketModel>>>>
      getTicketDetails(int? id) async {
    try {
      final response = await performGetListRequest<TicketModel>(
        endpoint: "${AppEndpoints.tickets}$id",
        params: {},
        fromJson: TicketModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>> createTicket(
      CreateTicketParams params) async {
    try {
      final response = await performPostRequestWithFormData<TicketModel>(
        endpoint: AppEndpoints.createTicket,
        body: dio.FormData.fromMap(params.toJson()),
        fromJson: TicketModel.fromJson,
        isUploadFile: true,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> createQuotation(
      CreateQuotationParams params) async {
    try {
      final response = await performPostRequest(
        endpoint: AppEndpoints.createQuotation,
        body: params.toJson(),
        fromJson: (v) => {},
        hasDataBody: false,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<QuotationModel>>>
      createQuotationComment(CreateCommentParams params) async {
    try {
      final response = await performPostRequest<QuotationModel>(
        endpoint: AppEndpoints.createQuotationComment,
        body: params.toJson(),
        fromJson: QuotationModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<TicketModel>>>
      addTicketResponse(AddTicketResponseParams? params) async {
    try {
      final response = await performPostRequestWithFormData<TicketModel>(
        endpoint: AppEndpoints.addTicketResponse,
        body: dio.FormData.fromMap(params!.toJson()),
        isUploadFile: true,
        fromJson: TicketModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> closeTicket(
      int? id) async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: "${AppEndpoints.closeTicket}$id",
        body: {},
        fromJson: (p0) => {},
        hasDataBody: false,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>> updateProfile(
      UpdateProfileParams params) async {
    try {
      final response = await performPostRequest<UserModel>(
        endpoint: AppEndpoints.updateProfile,
        body: params.toJson(),
        fromJson: UserModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<UserModel>>>
      updateProfilePicture(UpdateProfileParams params) async {
    try {
      final response = await performPostRequestWithFormData<UserModel>(
        endpoint: AppEndpoints.updateProfile,
        body: dio.FormData.fromMap(params.toJson()),
        fromJson: UserModel.fromJson,
        isUploadFile: true,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> updatePassword(
      UpdatePasswordParams params) async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: AppEndpoints.changePassword,
        body: params.toJson(),
        fromJson: (p0) => {},
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }
}
