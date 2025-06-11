import 'package:get/get.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/models/checkout_model.dart';
import 'package:irhebo/domain/params/create_request_params.dart';
import 'package:irhebo/domain/usecases/home_usecases/checkout_sevice_use_case.dart';

import '../../../app/router/routes.dart';
import '../../../domain/usecases/home_usecases/create_request_use_case.dart';

class CheckoutController extends GetxController {
  final RxBool _isLoading = false.obs;

  // late RequestEntity task = RequestEntity();

  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingPlan = false.obs;

  bool get isLoadingPlan => _isLoadingPlan.value;

  set isLoadingPlan(value) => _isLoadingPlan.value = value;

  set isLoading(value) => _isLoading.value = value;

  CheckoutModel? checkout;
  int serviceId = 0;
  int planId = 0;

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
    await checkoutService();
  }

  checkoutService() async {
    isLoading = true;
    CheckoutSeviceUseCase checkoutSeviceUseCase = sl();
    final result = await checkoutSeviceUseCase(
        CreateRequestParams(planId: planId, serviceId: serviceId));
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      checkout = r.data?.service;
      isLoading = false;
    });
  }

  receiveParameters() {
    if (Get.arguments != null) {
      planId = Get.arguments["plan_id"] ?? 0;
      serviceId = Get.arguments["service_id"] ?? 0;
    }
  }

  createRequest() async {
    isLoadingPlan = true;
    CreateRequestUseCase createRequestUseCase = sl();
    final result = await createRequestUseCase(CreateRequestParams(
      planId: planId,
      serviceId: serviceId,
    ));
    result!.fold((l) {
      isLoadingPlan = false;
      AppSnackBar.openErrorSnackBar(message: l.message ?? 'Error!');
    }, (r) {

      AppSnackBar.openSuccessSnackBar(
        message: 'Request Sent Successfully'.tr
      );

      Get.offAllNamed(AppRoutes.bottomNavBar);

      // Get.back();
      // Get.toNamed(AppRoutes.checkout, arguments: {
      //   "plan_id": serviceDetails.plans![selectedTab].id,
      //   "service_id": id
      // });
      isLoadingPlan = false;
    });
  }
}
