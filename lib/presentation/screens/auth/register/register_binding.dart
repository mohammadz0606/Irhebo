import 'package:get/get.dart';

import '../../search/search_controller.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(HomeController(), permanent: true);
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => SearchControllerGetx());

  }
}
