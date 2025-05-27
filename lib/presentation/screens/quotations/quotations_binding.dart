import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/quotations/quotations_controller.dart';

class QuotationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuotationsController());
  }
}
