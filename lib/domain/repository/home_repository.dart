import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_repository.dart';
import 'package:irhebo/data/home_remote_data_source.dart';
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

class HomeRepository extends BaseRepositoryImpl {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepository({
    required this.homeRemoteDataSource,
    required super.networkInfo,
  }) : super(baseRemoteDataSource: homeRemoteDataSource);

  Future<Either<BaseErrorModel, BaseResponseModel<HomeModel>>> getHome() async {
    try {
      final result = await homeRemoteDataSource.getHome();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<ServiceDetailsModel>>>
      serviceDetails(int id) async {
    try {
      final result = await homeRemoteDataSource.serviceDetails(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<DataModel>>> portfolioDetails(
      int id) async {
    try {
      final result = await homeRemoteDataSource.portfolioDetails(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>
      getServicesBySubcategoryId(PaginationParams params) async {
    try {
      final result =
          await homeRemoteDataSource.getServicesBySubcategoryId(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>>
      getServicesByTag(PaginationParams params) async {
    try {
      final result = await homeRemoteDataSource.getServicesByTag(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<CheckoutServiceModel>>>
      checkout(CreateRequestParams params) async {
    try {
      final result = await homeRemoteDataSource.checkout(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<AllServices>>> searchService(
      PaginationParams params) async {
    try {
      final result = await homeRemoteDataSource.searchService(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<CategoryModel>>>>
      getCategories() async {
    try {
      final result = await homeRemoteDataSource.getCategories();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<PaginatedPortfolio>>>
      getFeaturedPortfolios(PaginationParams params) async {
    try {
      final result = await homeRemoteDataSource.getFeaturedPortfolios(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<SubcategoryModel>>>>
      getSubcategories(int id) async {
    try {
      final result = await homeRemoteDataSource.getSubcategories(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<RequestModel>>>>
      getRequests() async {
    try {
      final result = await homeRemoteDataSource.getRequests();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> updateRequest(
      UpdateRequestParams params) async {
    try {
      final result = await homeRemoteDataSource.updateRequest(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> createRequest(
      CreateRequestParams params) async {
    try {
      final result = await homeRemoteDataSource.createRequest(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<ServiceModel>>>>
      getWishlist() async {
    try {
      final result = await homeRemoteDataSource.getWishlist();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> toggleFav(
      int id) async {
    try {
      final result = await homeRemoteDataSource.toggleFav(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<List<FilterModel>>>>
      getServicesFilters(int id) async {
    try {
      final result = await homeRemoteDataSource.getServicesFilters(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<RequestModel>>>
      getRequestDetails(int id) async {
    try {
      final result = await homeRemoteDataSource.getRequestDetails(id);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<FreelancerDetailsModel>>>
      getFreelancerProfile(PaginationParams params) async {
    try {
      final result = await homeRemoteDataSource.getFreelancerProfile(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<dynamic>>> review(
      RateParams params) async {
    try {
      final result = await homeRemoteDataSource.review(params);
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
