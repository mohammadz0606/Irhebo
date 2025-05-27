import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/auth/forget_password/forget_password_controller.dart';


class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(HomeController(), permanent: true);
    Get.lazyPut(() => ForgetPasswordController());
  }
}
