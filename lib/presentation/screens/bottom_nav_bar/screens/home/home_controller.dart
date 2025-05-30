// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_featured_portfolio_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_home_use_case.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/add_bottom_sheet.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/widgets/service_dialog.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_screen.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../app/network/network.dart';
import '../../../../../domain/models/new_models/freelancer/freelancer_home_model.dart';

class HomeController extends GetxController {
  final appController = Get.find<AppController>();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxBool _isLoading = true.obs;
  final RxInt _pageNumber = 1.obs;
  final RxList<ServiceModel> _services = <ServiceModel>[].obs;

  final RxList<DataModel> _portfolios = <DataModel>[].obs;

  List<ServiceModel> get services => _services.value;

  List<DataModel> get portfolios => _portfolios.value;

  bool get isLoading => _isLoading.value;

  int get pageNumber => _pageNumber.value;

  set services(value) => _services.value = value;

  set portfolios(value) => _portfolios.value = value;

  set isLoading(value) => _isLoading.value = value;

  set pageNumber(value) => _pageNumber.value = value;

  List<CategoryModel> categories = [];

  FreelancerHomeModel? freelancerHomeModel;

  @override
  Future<void> onInit() async {
    super.onInit();

    if (isClosed) return;
    if (getUserRole == UserRoles.client) {
      await getHome();
      await getFeaturedPortfolio();
    } else {
      await getFreelancerHome();
    }

    isLoading = false;
  }

  onTapCategory(int index) {
    Get.toNamed(AppRoutes.search, arguments: {
      "from_category": true,
      "title": categories[index].title,
      "category_id": categories[index].id,
    });
  }

  onTapService(int index) {
    Get.to(() => const ServiceDetailsScreen(),
        arguments: {"id": services[index].id ?? 0});
  }

  onLikeService(int index) async {
    services[index].isWishlist = !services[index].isWishlist!;
    _services.refresh();
    bool result = await appController.addToWishlist(services[index].id);
    if (!result) {
      services[index].isWishlist = !services[index].isWishlist!;
      _services.refresh();
    }
  }

  onTapPortfolio(index) {
    Get.back();
    Get.toNamed(AppRoutes.portfolioDetails, arguments: {
      "id": portfolios[index].id,
      "title": portfolios[index].title,
    });
  }

  openFeaturedDialog(int index) {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      AppDialog(
        child: ServiceDialog(
          onTapPortfolio: () => onTapPortfolio(index),
          portfolio: portfolios[index],
        ),
      ),
    );
  }

  onRefreshList() async {
    isLoading = true;
    clearData();

    if (getUserRole == UserRoles.client) {
      await getHome();
      await getFeaturedPortfolio();
    } else {
      await getFreelancerHome();
    }
    isLoading = false;
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
  }

  clearData() {
    pageNumber = 1;
    categories.clear();
    services.clear();
    portfolios.clear();
    freelancerHomeModel = null;
  }

  onTapFreelancer(int index) {
    Get.toNamed(AppRoutes.freelancerProfile,
        arguments: {"id": services[index].user?.id ?? 0});
  }

  getHome() async {
    GetHomeUseCase getHomeUseCase = sl();
    final result = await getHomeUseCase(());
    result!.fold((l) {}, (r) {
      categories = r.data?.categories ?? [];
      services = r.data?.recommendedServices ?? [];
      _services.refresh();
    });
  }

  getFreelancerHome() async {
    try {
      this.freelancerHomeModel = null;
      final response = await Network().get(url: AppEndpoints.homeFreelancer);
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }

      FreelancerHomeModel freelancerHomeModel =
          FreelancerHomeModel.fromJson(response.data);
      if (freelancerHomeModel.status == true) {
        this.freelancerHomeModel = freelancerHomeModel;
        _services.refresh();
      }
      log('DONE GET FREELANCER HOME');
    } catch (error) {
      if (error is DioException) {
        AppSnackBar.openErrorSnackBar(
          message: Network().handelDioException(error),
        );
      } else {
        AppSnackBar.openErrorSnackBar(
          message: error.toString(),
        );
      }
    }
  }

  getFeaturedPortfolio() async {
    if (pageNumber == 1) {
      portfolios.clear();
    }
    GetFeaturedPortfolioUseCase getFeaturedPortfolioUseCase = sl();
    final result = await getFeaturedPortfolioUseCase(
        PaginationParams(page: pageNumber, perPage: AppConstants.PAGE_LENGTH));
    result!.fold((l) {
      refreshController.refreshFailed();
    }, (r) {
      pageNumber = pageNumber + 1;
      portfolios.addAll(r.data?.portfolios ?? []);
      if (r.data!.portfolios!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _portfolios.refresh();
    });
  }

  removeLikedService(int id) {
    for (var element in services) {
      if (element.id == id) {
        element.isWishlist = !element.isWishlist!;
        _services.refresh();
      }
    }
  }

  openAddBottomSheet() {
    if (Get.context != null && Get.context!.mounted) {
      Get.bottomSheet(
        const AddBottomSheet(),
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.pureWhite,
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        elevation: 0,
      );
    }
  }

  onTapCreateSupportTicket() {
    Get.back();
    if (appController.token.isNotEmpty) {
      Get.toNamed(AppRoutes.createTicket);
    } else {
      openLoginRequiredDialog();
    }
  }

  onTapRequestForQuotation() {
    Get.back();

    if (appController.token.isNotEmpty) {
      Get.toNamed(AppRoutes.createQuotation);
    } else {
      openLoginRequiredDialog();
    }
  }

  openLoginRequiredDialog() {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      const AppDialog(
        child: LoginRequiredDialog(),
      ),
    );
  }
}
