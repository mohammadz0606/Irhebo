import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/service_details_model.dart';
import 'package:irhebo/domain/params/create_request_params.dart';
import 'package:irhebo/domain/usecases/home_usecases/create_request_use_case.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_service_details_use_case.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_screen.dart';
import 'package:irhebo/presentation/screens/service_details/widgets/plans_bottom_sheet.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';

import '../checkout/checkout_controller.dart';
import '../checkout/checkout_screen.dart';

class ServiceDetailsController extends GetxController {
  final appController = Get.find<AppController>();

  TextEditingController controller = TextEditingController();

  final RxInt _selectedTab = 0.obs;
  final Rx<ServiceDetailsModel> _serviceDetails = ServiceDetailsModel().obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingPlan = false.obs;

  int get selectedTab => _selectedTab.value;
  ServiceDetailsModel get serviceDetails => _serviceDetails.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingPlan => _isLoadingPlan.value;

  set selectedTab(value) => _selectedTab.value = value;
  set isLoading(value) => _isLoading.value = value;
  set isLoadingPlan(value) => _isLoadingPlan.value = value;
  set serviceDetails(value) => _serviceDetails.value = value;

  int id = 0;

  // ignore: invalid_use_of_protected_member
  List<ReviewModel> get moreReviews => _moreReviews.value;

  set moreReviews(value) => _moreReviews.value = value;

  final RxList<ReviewModel> _moreReviews = <ReviewModel>[].obs;

  showMoreReviews() {
    int remaining = serviceDetails.reviews!.length - moreReviews.length;
    int toAdd = remaining >= 2 ? 2 : remaining;

    moreReviews.addAll(
      serviceDetails.reviews!
          .sublist(moreReviews.length, moreReviews.length + toAdd),
    );
    _moreReviews.refresh();
  }

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
    if (isClosed) return;
    // getServiceDetails();
  }

  onTapService(int i) {
    id = serviceDetails.recommended![i].id!;
    Get.to(() => const ServiceDetailsScreen(),
        preventDuplicates: false,
        arguments: {"id": serviceDetails.recommended![i].id})?.then((_) {
      receiveParameters();
      getServiceDetails();
    });
  }

  receiveParameters() {
    if (Get.arguments != null) {
      id = Get.arguments["id"] ?? id;
    }
  }

  onTapFreelancer(int index) {
    Get.toNamed(AppRoutes.freelancerProfile,
        arguments: {"id": serviceDetails.recommended![index].user?.id ?? 0});
  }

  onTapFreelancerFromReviews(int index) {
    Get.toNamed(AppRoutes.freelancerProfile,
        arguments: {"id": moreReviews[index].user?.id ?? 0});
  }

  onTapFreelancerFromInfo() {
    Get.toNamed(AppRoutes.freelancerProfile,
        arguments: {"id": serviceDetails.service?.user?.id ?? 0});
  }

  onTapChat() {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      Get.toNamed(AppRoutes.chat, arguments: {"chat_type": ChatType.Users});
    }
  }

  onOpenPlansBottomSheet() {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      Get.bottomSheet(
        const PlansBottomSheet(),
        backgroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkScaffoldColor
            : AppLightColors.pureWhite,
        barrierColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer.withOpacity(0.3)
            : AppLightColors.shadow.withOpacity(0.3),
        elevation: 0,
        isScrollControlled: true,
      );
    }
  }

  onChangeTab(int i) {
    selectedTab = i;
    _selectedTab.refresh();
  }

  onTapServiceMedia(int i) async {
    await Get.toNamed(AppRoutes.gallery,
        arguments: {"index": i, "media_list": serviceDetails.service?.media});
  }

  onTapPortfolio(int index) {
    Get.toNamed(
      AppRoutes.portfolioDetails,
      arguments: {
        "id": serviceDetails.portoflio![index].id,
        "title": serviceDetails.portoflio![index].title
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  onLikeRecomendedService(int index) async {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      serviceDetails.recommended![index].isWishlist =
          !serviceDetails.recommended![index].isWishlist!;
      _serviceDetails.refresh();
      bool result = await appController
          .addToWishlist(serviceDetails.recommended![index].id);
      if (!result) {
        serviceDetails.recommended![index].isWishlist =
            !serviceDetails.recommended![index].isWishlist!;
        _serviceDetails.refresh();
      } else {
        Get.find<HomeController>()
            .removeLikedService(serviceDetails.recommended![index].id!);
      }
    }
  }

  onLikeService() async {
    if (appController.token.isEmpty) {
      openLoginRequiredDialog();
    } else {
      serviceDetails.service!.isWishlist = !serviceDetails.service!.isWishlist!;
      _serviceDetails.refresh();
      bool result =
          await appController.addToWishlist(serviceDetails.service?.id);
      if (!result) {
        serviceDetails.service!.isWishlist =
            !serviceDetails.service!.isWishlist!;
        _serviceDetails.refresh();
      } else {
        Get.find<HomeController>()
            .removeLikedService(serviceDetails.service!.id!);
      }
    }
  }

  selectPlan() async {
    Get.toNamed(AppRoutes.checkout, arguments: {
      "plan_id": serviceDetails.plans![selectedTab].id,
      "service_id": id
    });
    // isLoadingPlan = true;
    // CreateRequestUseCase createRequestUseCase = sl();
    // final result = await createRequestUseCase(CreateRequestParams(
    //     planId: serviceDetails.plans![selectedTab].id, serviceId: id));
    // result!.fold((l) {
    //   isLoadingPlan = false;
    // }, (r) {
    //   Get.back();
    //   Get.toNamed(AppRoutes.checkout, arguments: {
    //     "plan_id": serviceDetails.plans![selectedTab].id,
    //     "service_id": id
    //   });
    //   isLoadingPlan = false;
    // });
  }

  getServiceDetails() async {
    _moreReviews.clear();
    isLoading = true;
    GetServiceDetailsUseCase getServiceDetailsUseCase = sl();
    final result = await getServiceDetailsUseCase(id);
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      isLoading = false;
      serviceDetails = r.data;
      _serviceDetails.refresh();
      showMoreReviews();
    });
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
