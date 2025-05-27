import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/freelancer_profile/freelancer_profile_controller.dart';

class FreelancerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreelancerProfileController());
  }
}
