import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/models/new_models/general_model.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_quotation_details_use_case.dart';

import '../../../app/network/end_points.dart';
import '../../../app/network/network.dart';
import '../../../app/snack_bar.dart';

class QuotationDetailsController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingApproveQuotation = false.obs;

  bool get isLoading => _isLoading.value;

  bool get isLoadingApproveQuotation => _isLoadingApproveQuotation.value;

  set isLoading(value) => _isLoading.value = value;

  int id = 0;
  String title = "";
  QuotationModel? quotation;

  @override
  Future<void> onInit() async {
    super.onInit();
    receiveParameters();
    await getQutationDetailsDetails();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      id = Get.arguments["id"] ?? 0;
      title = Get.arguments["title"] ?? "";
    }
  }

  onTapBack() {
    Get.back();
  }

  getQutationDetailsDetails() async {
    isLoading = true;
    GetQuotationDetailsUseCase getQuotationDetailsUseCase = sl();
    final result = await getQuotationDetailsUseCase(id);
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      quotation = r.data;
      isLoading = false;
    });
  }

  approveQuotation() async {
    try {
      _isLoadingApproveQuotation.value = true;
      final response = await Network().post(
        url: '${AppEndpoints.approveQuotation}$id',
      );
      String errorMessage = await Network().handelError(response: response);
      if (errorMessage.isNotEmpty) {
        _isLoadingApproveQuotation.value = false;
        AppSnackBar.openErrorSnackBar(message: errorMessage);
        return;
      }

      NewGeneralModel generalModel = NewGeneralModel.fromJson(response.data);

      if (generalModel.status ?? false) {
        await getQutationDetailsDetails();
        onTapBack();
        AppSnackBar.openSuccessSnackBar(message: 'Quotation Approved Successfully'.tr);
        _isLoadingApproveQuotation.value = false;

      }
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
      _isLoadingApproveQuotation.value = false;
    }
  }
}
