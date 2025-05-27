import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/ticket_details/ticket_details_controller.dart';

class TicketDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TicketDetailsController());
  }
}
