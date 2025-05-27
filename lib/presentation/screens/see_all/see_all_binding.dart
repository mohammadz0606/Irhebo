import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/see_all/see_all_controller.dart';

class SeeAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeeAllController());
  }
}
