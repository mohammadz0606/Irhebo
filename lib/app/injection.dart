import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:irhebo/app/base/base_remote_data_source.dart';
import 'package:irhebo/app/network_info.dart';
import 'package:irhebo/app/storage/app_prefs.dart';
import 'package:irhebo/data/auth_remote_data_source.dart';
import 'package:irhebo/data/setting_remote_data_source.dart';
import 'package:irhebo/data/home_remote_data_source.dart';
import 'package:irhebo/data/intro_remote_data_source.dart';
import 'package:irhebo/domain/repository/setting_repository.dart';
import 'package:irhebo/domain/repository/intro_repository.dart';
import 'package:irhebo/domain/usecases/auth_usecases/login_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/logout_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/register_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/reset_password_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/send_otp_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/verify_otp_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/checkout_sevice_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/create_request_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_featured_portfolio_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_freelancer_profile_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_request_details_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_requests_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_wishlist_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/review_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/toggle_fav_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/update_request_use_case.dart';
import 'package:irhebo/domain/usecases/intro_usecases/get_config_use_case.dart';
import 'package:irhebo/domain/usecases/intro_usecases/get_general_use_case.dart';
import 'package:irhebo/domain/usecases/intro_usecases/get_steps_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_categories_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_home_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_portfolio_details_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_service_by_subcategory_id_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_service_by_tag_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_service_details_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_services_filters_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_subcategories_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/search_service_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/add_ticket_response_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/close_ticket_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/create_quotation_comment_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/create_quotation_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/create_ticket_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_faqs_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_my_profile_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_notifications_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_quotation_comments_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_quotation_details_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_quotations_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_ticket_details_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_tickets_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/read_notification_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/update_password_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/update_profile_picture_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/update_profile_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/repository/auth_repository.dart';
import '../domain/repository/home_repository.dart';
// import 'Usecases/Home_UseCases/get_sections_usecase.dart';

import 'app_controller.dart';
import 'end_points.dart';

final sl = GetIt.instance;

///
/// The [init] function is responsible for adding the instances to the graph
///
Future<void> init() async {
  //! External
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Adding the [SharedPreferences] instance to the graph to be later used by the local data sources
  final sharedPreferences = await SharedPreferences.getInstance();

  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker.createInstance();

  final Connectivity connectivity = Connectivity();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppPreferences(sl()));

  sl.registerLazySingleton(() => connectionChecker);

  sl.registerLazySingleton(() => connectivity);

  /// Adding the [Dio] instance to the graph to be later used by the local data sources
  sl.registerLazySingleton(
    () {
      final dio = Dio(
        BaseOptions(
          // connectTimeout: const Duration(seconds: 20),
          connectTimeout: const Duration(seconds: 5), // 5 seconds
          // receiveTimeout: const Duration(seconds: 5),
          // connectTimeout: Duration(seconds: 3), // Time to establish connection
          // receiveTimeout: Duration(seconds: 3), // Time to receive response
          // sendTimeout: Duration(seconds: 5),

          baseUrl: AppEndpoints.base_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.plain,
        ),
      );
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
        ),
      );
      return dio;
    },
  );

  /// Adding the [DataConnectionChecker] instance to the graph to be later used by the [NetworkInfoImpl]

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //! Core
  ///Creating [NetworkInfoImpl] class
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// Local Data sources
  /// Instantiating the [BaseLocalDataSourceImpl]

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// Remote Data sources
  /// Instantiating the [BaseRemoteDataSourceImpl]
  sl.registerLazySingleton<BaseRemoteDataSource>(
      () => BaseRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<IntroRemoteDataSource>(
      () => IntroRemoteDataSourceImp(dio: sl()));

  sl.registerLazySingleton<SettingRemoteDataSource>(
      () => SettingRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImp(dio: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///Repos
  ///

  sl.registerLazySingleton<IntroRepository>(
      () => IntroRepository(introRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepository(authRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepository(homeRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<SettingRepository>(() =>
      SettingRepository(settingRemoteDataSource: sl(), networkInfo: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /// Usecases
  ///Intro
  sl.registerLazySingleton<GetConfigUseCase>(
      () => GetConfigUseCase(introRepository: sl()));
  sl.registerLazySingleton<GetGeneralUseCase>(
      () => GetGeneralUseCase(introRepository: sl()));
  sl.registerLazySingleton<GetStepsUseCase>(
      () => GetStepsUseCase(introRepository: sl()));

  ///Auth
  ///
  ///
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: sl()));

  sl.registerLazySingleton<SendOtpUseCase>(
      () => SendOtpUseCase(authRepository: sl()));

  sl.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepository: sl()));

  sl.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(authRepository: sl()));

  sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(authRepository: sl()));

  sl.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(authRepository: sl()));

  ///Home
  sl.registerLazySingleton<GetHomeUseCase>(
      () => GetHomeUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetServiceDetailsUseCase>(
      () => GetServiceDetailsUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetPortfolioDetailsUseCase>(
      () => GetPortfolioDetailsUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetSubcategoriesUseCase>(
      () => GetSubcategoriesUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetServiceBySubcategoryIdUseCase>(
      () => GetServiceBySubcategoryIdUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetServiceByTagUseCase>(
      () => GetServiceByTagUseCase(homeRepository: sl()));

  sl.registerLazySingleton<SearchServiceUseCase>(
      () => SearchServiceUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetServicesFiltersUseCase>(
      () => GetServicesFiltersUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetRequestsUseCase>(
      () => GetRequestsUseCase(homeRepository: sl()));

  sl.registerLazySingleton<CreateRequestUseCase>(
      () => CreateRequestUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetWishlistUseCase>(
      () => GetWishlistUseCase(homeRepository: sl()));

  sl.registerLazySingleton<ToggleFavUseCase>(
      () => ToggleFavUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetFreelancerProfileUseCase>(
      () => GetFreelancerProfileUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetRequestDetailsUseCase>(
      () => GetRequestDetailsUseCase(homeRepository: sl()));

  sl.registerLazySingleton<ReviewUseCase>(
      () => ReviewUseCase(homeRepository: sl()));

  sl.registerLazySingleton<CheckoutSeviceUseCase>(
      () => CheckoutSeviceUseCase(homeRepository: sl()));

  sl.registerLazySingleton<GetFeaturedPortfolioUseCase>(
      () => GetFeaturedPortfolioUseCase(homeRepository: sl()));

  sl.registerLazySingleton<UpdateRequestUseCase>(
      () => UpdateRequestUseCase(homeRepository: sl()));

  ///Settings
  sl.registerLazySingleton<GetMyProfileUseCase>(
      () => GetMyProfileUseCase(settingRepository: sl()));

  sl.registerLazySingleton<ReadNotificationUseCase>(
      () => ReadNotificationUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetFaqsUseCase>(
      () => GetFaqsUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetTicketDetailsUseCase>(
      () => GetTicketDetailsUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetTicketsUseCase>(
      () => GetTicketsUseCase(settingRepository: sl()));

  sl.registerLazySingleton<AddTicketResponseUseCase>(
      () => AddTicketResponseUseCase(settingRepository: sl()));

  sl.registerLazySingleton<CreateTicketUseCase>(
      () => CreateTicketUseCase(settingRepository: sl()));

  sl.registerLazySingleton<CloseTicketUseCase>(
      () => CloseTicketUseCase(settingRepository: sl()));

  sl.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(settingRepository: sl()));

  sl.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(settingRepository: sl()));

  sl.registerLazySingleton<UpdateProfilePictureUseCase>(
      () => UpdateProfilePictureUseCase(settingRepository: sl()));

  sl.registerLazySingleton<CreateQuotationUseCase>(
      () => CreateQuotationUseCase(settingRepository: sl()));

  sl.registerLazySingleton<CreateQuotationCommentUseCase>(
      () => CreateQuotationCommentUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetQuotationCommentsUseCase>(
      () => GetQuotationCommentsUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetQuotationDetailsUseCase>(
      () => GetQuotationDetailsUseCase(settingRepository: sl()));

  sl.registerLazySingleton<GetQuotationsUseCase>(
      () => GetQuotationsUseCase(settingRepository: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // del() {
  //   sharedPreferences.clear();
  // }

  // del();
  // await Firebase.initializeApp();
  Get.put(AppController(), permanent: true);
}
