import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/create_quotation/create_quotation_controller.dart';

import '../search/search_controller.dart';

class CreateQuotationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateQuotationController());
    Get.lazyPut(() => SearchControllerGetx());
  }
}
