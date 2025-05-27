// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:irhebo/presentation/screens/service_details/service_details_screen.dart';

class SeeAllController extends GetxController {
  // final RxBool _isLoading = false.obs;

  // onPressCheckbox(int index) {
  //   categories[index].checked = !(categories[index].checked!);
  //   _categories.refresh();
  // }

  onTapService() {
    Get.to(
      () => ServiceDetailsScreen(),
      // preventDuplicates: false,
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  onLikeService(int index) {
    // log("tapped");
    // services[index].liked = !services[index].liked!;

    // _services.refresh();
  }
}
