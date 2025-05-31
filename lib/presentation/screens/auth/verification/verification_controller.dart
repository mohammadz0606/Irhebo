import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/app/snack_bar.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/params/verify_otp_params.dart';
import 'package:irhebo/domain/usecases/auth_usecases/send_otp_use_case.dart';
import 'package:irhebo/domain/usecases/auth_usecases/verify_otp_use_case.dart';

import '../../../../app/storage/app_prefs.dart';
import '../../../../app/storage/app_prefs_keys.dart';
import '../../intro/splash_controller.dart';

class VerificationController extends GetxController {
  final appController = Get.find<AppController>();

  // GlobalKey<FormState> otpKey = GlobalKey<FormState>();

  final TextEditingController pinPutController = TextEditingController();

  final RxInt _endTime =
      (DateTime.now().millisecondsSinceEpoch + 1000 * 60).obs;

  final RxBool _isValidOtp = true.obs;
  final RxBool _isLoadingSend = false.obs;
  final RxBool _isLoadingVerify = false.obs;

  bool get isValidOtp => _isValidOtp.value;

  bool get isLoadingSend => _isLoadingSend.value;

  bool get isLoadingVerify => _isLoadingVerify.value;

  int get endTime => _endTime.value;

  set isValidOtp(value) => _isValidOtp.value = value;

  set isLoadingSend(value) => _isLoadingSend.value = value;

  set isLoadingVerify(value) => _isLoadingVerify.value = value;

  set endTime(value) => _endTime.value = value;

  VerifyScreenType type = VerifyScreenType.register;
  String code = '';
  String phone = '';
  String prefix = '';

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      type = Get.arguments["verify_type"] ?? VerifyScreenType.register;
      code = Get.arguments["code"] ?? "";
      phone = Get.arguments["phone"] ?? "";
      prefix = Get.arguments["prefix"] ?? "";
      pinPutController.text = code;
    }
  }

  onResendCode() async {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  }

  checkCode() {
    if (pinPutController.text == code) {
      isValidOtp = true;
    } else {
      isValidOtp = false;
    }
  }

  @override
  onClose() {
    pinPutController.text = '';
    super.onClose();
  }

  onTapVerify() {
    verifyOtp(type == VerifyScreenType.forget_password);
  }

  resendOtp() async {
    isLoadingSend = true;
    SendOtpUseCase requestCodeUseCase = sl();
    final result = await requestCodeUseCase(
        SendOtpParams(phone: phone, prefix: appController.countryCode));
    result!.fold((l) {
      isLoadingSend = false;
    }, (r) {
      isLoadingSend = false;
      onResendCode();
      pinPutController.text = r.data!.code ?? "";
    });
  }

  verifyOtp(bool isForget) async {
    if (pinPutController.text.length == 6) {
      isLoadingVerify = true;
      VerifyOtpUseCase verifyOtpUseCase = sl();
      final result = await verifyOtpUseCase(VerifyOtpParams(
        phone: phone,
        prefix: appController.countryCode,
        code: pinPutController.text,
      ));
      result!.fold(
        (l) {
          if (pinPutController.text != code) {
            isValidOtp = false;
          }
          isLoadingVerify = false;
        },
        (r) {
          if (pinPutController.text == code) {
            isValidOtp = true;
          }
          isLoadingVerify = false;
          if (isForget) {
            Get.offAndToNamed(AppRoutes.createPassword,
                arguments: {"phone": phone});
          } else {
            /// IMPLEMENT FREELANCER LOGIC
            AppPreferences prefs = sl();
            appController.setAccessToken(r.data!.token ?? '',r.data!.user?.id ?? 0);

            // if (prefs.getString(key: AppPrefsKeys.USER_ROLE) != null) {
            //   if (prefs.getString(key: AppPrefsKeys.USER_ROLE) !=
            //       r.data?.user?.role) {
            //     prefs.removeItem(AppPrefsKeys.SHOW_CASE_HOME);
            //   }
            // }

            prefs.setString(
              key: AppPrefsKeys.USER_ROLE,
              value: r.data?.user?.role ?? '',
            );
            final splashController = Get.find<SplashController>();

            if (splashController.selectedRoleIndex == 0) {
              Get.offAllNamed(AppRoutes.bottomNavBar);
            } else {
              Get.back();
              Get.offNamed(AppRoutes.registerFreelancer);
            }
          }
        },
      );
    } else {
      AppSnackBar.openErrorSnackBar(
        message: "please enter 6 digits",
      );
    }
  }
}
