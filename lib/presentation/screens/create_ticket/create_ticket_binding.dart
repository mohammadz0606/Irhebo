import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/create_ticket/create_ticket_controller.dart';

class CreateTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTicketController());
  }
}
