import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/profile/profile_controller.dart';

import '../search/search_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
