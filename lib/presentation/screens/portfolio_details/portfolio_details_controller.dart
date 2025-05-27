import 'dart:developer';

import 'package:get/get.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_portfolio_details_use_case.dart';

class PortfolioDetailsController extends GetxController {
  final RxBool _isLoading = false.obs;

  // ignore: invalid_use_of_protected_member
  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  int id = 0;
  String title = "";
  DataModel? portfolio;

  @override
  onInit() async {
    super.onInit();

    receiveParameters();
    if (isClosed) return;
    getPortfolioDetails();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      id = Get.arguments["id"];
      title = Get.arguments["title"];
      log(title);
    }
  }

  onTapPortfolioMedia(int i) async {
    await Get.toNamed(AppRoutes.gallery,
        arguments: {"index": i, "media_list": portfolio!.media ?? []});
  }

  getPortfolioDetails() async {
    isLoading = true;
    GetPortfolioDetailsUseCase getPortfolioDetailsUseCase = sl();
    final result = await getPortfolioDetailsUseCase(id);
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      isLoading = false;
      portfolio = r.data;
    });
  }
}
