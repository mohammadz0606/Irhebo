import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/request_details/request_details_controller.dart';

class RequestDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestDetailsController());
  }
}
