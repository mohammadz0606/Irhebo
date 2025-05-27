import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
