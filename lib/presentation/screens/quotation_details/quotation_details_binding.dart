import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/quotation_details/quotation_details_controller.dart';

class QuotationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuotationDetailsController());
  }
}
