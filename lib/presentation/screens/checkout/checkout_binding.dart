import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/checkout/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController());
  }
}
