import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/notifications/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
