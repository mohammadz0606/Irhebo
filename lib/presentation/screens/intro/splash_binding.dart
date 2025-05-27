import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(HomeController(), permanent: true);
    Get.put(
      SplashController(),
    );
  }
}
