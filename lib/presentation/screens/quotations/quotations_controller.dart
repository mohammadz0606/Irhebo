import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/constants.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/quotation_model.dart';
import 'package:irhebo/domain/params/pagination_params.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_quotations_use_case.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuotationsController extends GetxController {
  final appController = Get.find<AppController>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  List<QuotationModel> quotations = [];

  int pageNumber = 1;

  @override
  onInit() async {
    super.onInit();
    await getQuotations();
  }

  onRefreshQuotationsList() async {
      pageNumber = 1;
      quotations.clear();
    isLoading = true;
    await getQuotations();
    refreshController.refreshCompleted();
    refreshController.refreshToIdle();
  }

  onTapQuotaion(int index) {
    Get.toNamed(AppRoutes.quotationDetails, arguments: {
      "id": quotations[index].id,
      "title": quotations[index].title,
    });
  }

  getQuotations() async {
    if (pageNumber == 1) {
      quotations.clear();
    }
    GetQuotationsUseCase getQuotationsUseCase = sl();
    final result = await getQuotationsUseCase(
        PaginationParams(page: pageNumber, perPage: AppConstants.PAGE_LENGTH));
    result!.fold((l) {
      refreshController.refreshFailed();
    }, (r) {
      pageNumber = pageNumber + 1;
      quotations.addAll(r.data!.quotations ?? []);
      if (r.data!.quotations!.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
    isLoading = false;
  }

  createQuotation() {
    Get.toNamed(AppRoutes.createQuotation)?.then((value) async =>
        {isLoading = true, pageNumber == 1, await getQuotations()});
  }
}
