import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/requests/requests_controller.dart';
import 'package:irhebo/presentation/screens/notifications/notifications_controller.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';

import '../portfolio_details/portfolio_details_controller.dart';
import '../quotation_details/quotation_details_controller.dart';
import '../service_details/service_details_controller.dart';
import '../support_tickets/support_tickets_controller.dart';
import '../ticket_details/ticket_details_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
    Get.lazyPut(() => RequestsController());
    Get.lazyPut(() => RequestDetailsController());
    Get.lazyPut(() => QuotationDetailsController());
    Get.lazyPut(() => TicketDetailsController());
    Get.lazyPut(() => ServiceDetailsController());
    Get.lazyPut(() => PortfolioDetailsController());
    Get.lazyPut(() => SupportTicketsController());
  }
}
