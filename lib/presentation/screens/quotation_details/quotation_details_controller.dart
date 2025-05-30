import 'package:get/get.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_quotation_details_use_case.dart';

class QuotationDetailsController extends GetxController {
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

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
}
