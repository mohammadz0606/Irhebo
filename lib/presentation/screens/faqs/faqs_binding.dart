import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/faqs/faqs_controller.dart';

class FaqsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqsController());
  }
}
