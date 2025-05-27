import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/support_tickets/support_tickets_controller.dart';

class SupportTicketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportTicketsController());
  }
}
