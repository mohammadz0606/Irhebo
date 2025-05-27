import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/terms_conditions/terms_conditions_controller.dart';

class TermsConditionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsConditionsController());
  }
}
