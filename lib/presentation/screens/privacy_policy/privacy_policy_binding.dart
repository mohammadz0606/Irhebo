import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/privacy_policy/privacy_policy_controller.dart';

class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyController());
  }
}
