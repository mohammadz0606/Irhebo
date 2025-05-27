import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/domain/models/faq_model.dart';
import 'package:irhebo/domain/usecases/setting_usecase/get_faqs_use_case.dart';

class FaqsController extends GetxController {
  final appController = Get.find<AppController>();

  final RxBool _isLoading = true.obs;
  final RxList<FaqModel> _faqs = <FaqModel>[].obs;

  bool get isLoading => _isLoading.value;
  List<FaqModel> get faqs => _faqs;

  set isLoading(value) => _isLoading.value = value;
  set faqs(value) => _faqs.value = value;

  int? categoryId;

  @override
  onInit() async {
    super.onInit();
    receiveParams();
    getFaqs();
  }

  receiveParams() {
    if (Get.arguments != null) {
      categoryId = Get.arguments["category_id"];
    }
  }

  onTapFaqs(int index) {
    for (int i = 0; i < faqs.length; i++) {
      faqs[i].visible = (i == index) ? !faqs[i].visible : false;
    }
    _faqs.refresh();
  }

  getFaqs() async {
    isLoading = true;
    GetFaqsUseCase getFaqsUseCase = sl();
    final result = await getFaqsUseCase(categoryId);
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      faqs = r.data ?? [];
      _faqs.refresh();
      isLoading = false;
    });
  }
}
