import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_remote_data_source.dart';
import 'package:irhebo/app/end_points.dart';
import 'package:irhebo/app/resources/logger_colors.dart';
import 'package:irhebo/domain/models/checkout_model.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/domain/params/create_request_params.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/params/rate_params.dart';
import 'package:irhebo/domain/params/update_request_params.dart';

abstract class HomeRemoteDataSource extends BaseRemoteDataSourceImpl {
  HomeRemoteDataSource({required super.dio});

  Future<Either<BaseErrorModel, BaseResponseModel<HomeModel>>> getHome();

  Future<Either<BaseErrorModel, BaseResponseModel<ServiceDetailsModel>>>
      serviceDetails(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<DataModel>>> portfolioDetails(
      int id);

  Future<Either<BaseErrorModel, BaseResponseModel<List<CategoryModel>>>>
      getCategories();

  Future<Either<BaseErrorModel, BaseResponseModel<List<SubcategoryModel>>>>
      getSubcategories(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>
      getServicesBySubcategoryId(PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>
      getServicesByTag(PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>> searchService(
      PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<List<FilterModel>>>>
      getServicesFilters(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> toggleFav(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedPortfolio>>>
      getFeaturedPortfolios(PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> updateRequest(
      UpdateRequestParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<List<ServiceModel>>>>
      getWishlist();

  Future<Either<BaseErrorModel, BaseResponseModel<List<RequestModel>>>>
      getRequests();

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> createRequest(
      CreateRequestParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<CheckoutServiceModel>>>
      checkout(CreateRequestParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<RequestModel>>>
      getRequestDetails(int id);

  Future<Either<BaseErrorModel, BaseResponseModel<FreelancerDetailsModel>>>
      getFreelancerProfile(PaginationParams params);

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> review(
      RateParams params);
}

class HomeRemoteDataSourceImp extends BaseRemoteDataSourceImpl
    implements HomeRemoteDataSource {
  HomeRemoteDataSourceImp({required super.dio});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<HomeModel>>> getHome() async {
    try {
      final response = await performGetRequest<HomeModel>(
        endpoint: AppEndpoints.home,
        params: {},
        fromJson: HomeModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<ServiceDetailsModel>>>
      serviceDetails(int id) async {
    try {
      final response = await performGetRequest<ServiceDetailsModel>(
        endpoint: "${AppEndpoints.serivceDetails}$id",
        params: {},
        fromJson: ServiceDetailsModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<CategoryModel>>>>
      getCategories() async {
    try {
      final response = await performGetListRequest<CategoryModel>(
        endpoint: AppEndpoints.categories,
        params: {},
        fromJson: CategoryModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<SubcategoryModel>>>>
      getSubcategories(int id) async {
    try {
      final response = await performGetListRequest<SubcategoryModel>(
        endpoint: "${AppEndpoints.subcategories}?category_id=$id",
        params: {},
        fromJson: SubcategoryModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<FilterModel>>>>
      getServicesFilters(int id) async {
    try {
      final response = await performGetListRequest<FilterModel>(
        endpoint: "${AppEndpoints.filters}?category_id=$id",
        params: {},
        fromJson: FilterModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<RequestModel>>>>
      getRequests() async {
    try {
      final response = await performGetListRequest<RequestModel>(
        endpoint: AppEndpoints.requests,
        params: {},
        fromJson: RequestModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> toggleFav(
      int id) async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: "${AppEndpoints.toggleFav}?service_id=$id",
        body: {},
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
  Future<Either<BaseErrorModel, BaseResponseModel<CheckoutServiceModel>>>
      checkout(CreateRequestParams params) async {
    try {
      final response = await performPostRequest<CheckoutServiceModel>(
        endpoint: AppEndpoints.checkout,
        body: params.toJson(),
        fromJson: CheckoutServiceModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<ServiceModel>>>>
      getWishlist() async {
    try {
      final response = await performGetListRequest<ServiceModel>(
        endpoint: AppEndpoints.wishlist,
        params: {},
        fromJson: ServiceModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> createRequest(
      CreateRequestParams params) async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: AppEndpoints.createRequest,
        body: params.toJson(),
        fromJson: (p0) => {},
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> updateRequest(
      UpdateRequestParams? params) async {
    try {
      final response = await performPostRequestWithFormData<dynamic>(
        endpoint: AppEndpoints.updateRequest,
        body: dio.FormData.fromMap(params!.toJson()),
        isUploadFile: true,
        fromJson: (p0) => {},
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>
      getServicesBySubcategoryId(PaginationParams params) async {
    try {
      final response = await performGetRequest<AllServices>(
        endpoint: "${AppEndpoints.services}?sub_category_id=${params.id}",
        params: params.toJson(),
        fromJson: AllServices.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedPortfolio>>>
      getFeaturedPortfolios(PaginationParams params) async {
    try {
      final response = await performGetRequest<PaginatedPortfolio>(
        endpoint: AppEndpoints.portfolios,
        params: params.toJson(),
        fromJson: PaginatedPortfolio.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>
      getServicesByTag(PaginationParams params) async {
    try {
      final response = await performGetRequest<AllServices>(
        endpoint: "${AppEndpoints.services}${params.tag}",
        params: params.toJson(),
        fromJson: AllServices.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>> searchService(
      PaginationParams params) async {
    try {
      final response = await performGetRequest<AllServices>(
        endpoint: AppEndpoints.searchServices,
        params: params.toJson(),
        fromJson: AllServices.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<DataModel>>> portfolioDetails(
      int id) async {
    try {
      final response = await performGetRequest<DataModel>(
        endpoint: "${AppEndpoints.portfolioDetails}$id",
        params: {},
        fromJson: DataModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<RequestModel>>>
      getRequestDetails(int id) async {
    try {
      final response = await performGetRequest<RequestModel>(
        endpoint: "${AppEndpoints.requestDetails}$id",
        params: {},
        fromJson: RequestModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<FreelancerDetailsModel>>>
      getFreelancerProfile(PaginationParams params) async {
    try {
      final response = await performGetRequest<FreelancerDetailsModel>(
        endpoint: "${AppEndpoints.freelancerProfile}${params.id}",
        params: params.toJson(),
        fromJson: FreelancerDetailsModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> review(
      RateParams params) async {
    try {
      final response = await performPostRequest<dynamic>(
        endpoint: AppEndpoints.review,
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
