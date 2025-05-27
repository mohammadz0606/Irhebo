import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/usecases/auth_usecases/send_otp_use_case.dart';

class ForgetPasswordController extends GetxController {
  final appController = Get.find<AppController>();

  TextEditingController phoneConfirmation = TextEditingController();
  final GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();
  final RxBool _isLoading = (false).obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  String phone = '';

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      phone = Get.arguments["phone"] ?? "";
      phoneConfirmation.text = phone;
    }
  }

  requestCode() async {
    if (forgetPasswordKey.currentState!.validate()) {
      isLoading = true;
      SendOtpUseCase requestCodeUseCase = sl();
      final result = await requestCodeUseCase(SendOtpParams(
          phone: phoneConfirmation.text, prefix: appController.countryCode));
      result!.fold((l) {
        isLoading = false;
      }, (r) {
        isLoading = false;
        Get.toNamed(AppRoutes.verification, arguments: {
          "verify_type": VerifyScreenType.forget_password,
          "prefix": appController.countryCode,
          "phone": phoneConfirmation.text,
          "code": r.data!.code ?? ""
        });
      });
    }
  }
}
