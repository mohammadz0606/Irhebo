import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/freelancer_details_model.dart';
import 'package:irhebo/domain/models/home_model.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_freelancer_profile_use_case.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_screen.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FreelancerProfileController extends GetxController {
  final appController = Get.find<AppController>();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController controller = TextEditingController();

  final RxString _value = "".obs;
  RxInt _pageNumber = 1.obs;
  final RxBool _isLoading = false.obs;
  final Rx<ProfileTabs> _selectedTab = ProfileTabs.About.obs;
  final RxList<ServiceModel> _services = <ServiceModel>[].obs;
  final RxList<ReviewModel> _reviews = <ReviewModel>[].obs;
  final RxList<DataModel> _portfolios = <DataModel>[].obs;

  // final Rx<FreelancerDetailsModel> _freelancer = FreelancerDetailsModel().obs;

  String get value => _value.value;
  int get pageNumber => _pageNumber.value;
  bool get isLoading => _isLoading.value;
  ProfileTabs get selectedTab => _selectedTab.value;
  // FreelancerDetailsModel get freelancer => _freelancer.value;
  List<ServiceModel> get services => _services;
  List<ReviewModel> get reviews => _reviews;
  List<DataModel> get portfolios => _portfolios;

  set value(value) => _value.value = value;
  set pageNumber(value) => _pageNumber.value = value;
  set isLoading(value) => _isLoading.value = value;
  set selectedTab(value) => _selectedTab.value = value;
  // set freelancer(value) => _freelancer.value = value;
  set services(value) => _services.value = value;
  set reviews(value) => _reviews.value = value;
  set portfolios(value) => _portfolios.value = value;

  int id = 0;
  FreelancerDetailsModel? freelancer = FreelancerDetailsModel();

  @override
  onInit() async {
    super.onInit();

    receiveParameters();
    isLoading = true;
    await getFreelancerProfile();
    isLoading = false;
  }

  receiveParameters() {
    if (Get.arguments != null) {
      id = Get.arguments["id"] ?? 0;
    }
  }

  onChangeTab(ProfileTabs tab) {
    selectedTab = tab;
    _selectedTab.refresh();
  }

  onTapFreelancerFromReviews(int index) {
    Get.toNamed(AppRoutes.freelancerProfile,
        arguments: {"id": reviews[index].user?.id ?? 0});
  }

  onLikeService(int index) async {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      services[index].isWishlist = !services[index].isWishlist!;
      _services.refresh();
      bool result = await appController.addToWishlist(services[index].id);
      if (!result) {
        services[index].isWishlist = !services[index].isWishlist!;
        _services.refresh();
      } else {
        Get.find<HomeController>().removeLikedService(services[index].id!);
      }
    }
  }

  onTapService(int index) {
    Get.to(() => ServiceDetailsScreen(),
        arguments: {"id": services[index].id ?? 0});
  }

  onTapChat() {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      Get.toNamed(AppRoutes.chat, arguments: {"chat_type": ChatType.Users});
    }
  }

  onTapPortfolio(int index) {
    Get.toNamed(AppRoutes.portfolioDetails, arguments: {
      "id": portfolios[index].id ?? 0,
      "title": portfolios[index].title
    });
  }

  onRefreshList() async {
    isLoading = true;
    clearData();
    await getFreelancerProfile();
    isLoading = false;
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
  }

  clearData() {
    pageNumber = 1;
    reviews.clear();
    services.clear();
    portfolios.clear();
  }

  getFreelancerProfile() async {
    GetFreelancerProfileUseCase getFreelancerProfileUseCase = sl();
    final result = await getFreelancerProfileUseCase(PaginationParams(
        id: id, page: pageNumber, perPage: AppConstants.PAGE_LENGTH));
    result!.fold((l) {
      refreshController.refreshFailed();
    }, (r) {
      pageNumber = pageNumber + 1;
      portfolios.addAll(r.data!.portfolio!.data ?? []);
      services.addAll(r.data!.services!.data ?? []);
      reviews.addAll(r.data!.reviews!.data ?? []);
      if (r.data!.portfolio!.data!.isEmpty &&
          r.data!.services!.data!.isEmpty &&
          r.data!.reviews!.data!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      freelancer = r.data;
      _portfolios.refresh();
      _reviews.refresh();
      _services.refresh();
    });
  }

  openLoginRequiredDialog() {
    Get.dialog(
      barrierColor: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer.withOpacity(0.3)
          : AppLightColors.shadow.withOpacity(0.3),
      AppDialog(
        child: LoginRequiredDialog(),
      ),
    );
  }
}
