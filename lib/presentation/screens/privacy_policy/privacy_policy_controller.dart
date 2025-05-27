import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';

class PrivacyPolicyController extends GetxController {
  final appController = Get.find<AppController>();

  final RxBool _isLoadingPrivacy = true.obs;

  bool get isLoadingPrivacy => _isLoadingPrivacy.value;

  set isLoadingPrivacy(value) => _isLoadingPrivacy.value = value;

  @override
  onInit() async {
    super.onInit();
  }
}
