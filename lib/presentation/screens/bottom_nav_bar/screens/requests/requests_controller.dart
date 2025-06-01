import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/request_model.dart';
import 'package:irhebo/domain/usecases/home_usecases/get_requests_use_case.dart';

import '../../../../../app/app_functions.dart';
import '../../../../../app/enums.dart';
import '../../../../../app/network/end_points.dart';
import '../../../../../app/network/network.dart';
import '../../../../../app/snack_bar.dart';

class RequestsController extends GetxController {
  final appController = Get.find<AppController>();

  final Rx<String> _selectedTab = ("all".tr).obs;
  final RxBool _isLoading = false.obs;
  final RxList<RequestModel> _requests = <RequestModel>[].obs;

  String get selectedTab => _selectedTab.value;

  List<RequestModel> get requests => _requests;

  bool get isLoading => _isLoading.value;

  set selectedTab(value) => _selectedTab.value = value;

  set requests(value) => _requests.value = value;

  set isLoading(value) => _isLoading.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (appController.token.isNotEmpty) {
      if (getUserRole == UserRoles.client) {
        getRequests();
      }
    }
  }

  List<String> types = [
    "all".tr,
    "pending".tr,
    "completed".tr,
    "cancelled".tr,
    "confirmed".tr
  ];

  onTapFilter(int index) {
    selectedTab = types[index];
  }

  getRequests() async {
    isLoading = true;
    GetRequestsUseCase getRequestsUseCase = sl();

    try {
      final response = await Network().get(
        url: getUserRole == UserRoles.freelancer
            ? '${AppEndpoints.requests}by-freelancer'
            : AppEndpoints.requests,
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        isLoading = false;
        AppSnackBar.openErrorSnackBar(
          message: errorMessage,
        );
        return;
      }
      List<RequestModel> requests = [];

      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['requests'] != null) {
        requests = (response.data['data']['requests'] as List)
            .map((item) => RequestModel.fromJson(item))
            .toList();

        _requests.value = requests;
      }

      isLoading = false;
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
      isLoading = false;
    }

    //RequestModel

    //   final result = await getRequestsUseCase(());
    //   result!.fold((l) {
    //     isLoading = false;
    //   }, (r) {
    //     requests = r.data;
    //     _requests.refresh();
    //     isLoading = false;
    //   });
  }

  navigateToRequestDetails(int index) {
    Get.toNamed(AppRoutes.requestDetails, arguments: {
      "id": requests[index].id,
      "title": requests[index].title
    })?.then(
      (value) {
        getRequests();
      },
    );
  }
}
