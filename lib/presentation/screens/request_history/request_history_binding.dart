import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/request_history/request_history_controller.dart';

class RequestHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestHistoryController());
  }
}
