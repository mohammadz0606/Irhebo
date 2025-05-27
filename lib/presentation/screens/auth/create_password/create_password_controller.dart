// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/resources/validators.dart';
import 'package:irhebo/domain/params/reset_password_params.dart';
import 'package:irhebo/domain/params/update_password_params.dart';
import 'package:irhebo/domain/usecases/auth_usecases/reset_password_use_case.dart';
import 'package:irhebo/domain/usecases/setting_usecase/update_password_use_case.dart';

class CreatePasswordController extends GetxController {
  final appController = Get.find<AppController>();

  final GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();

  TextEditingController createPassword = TextEditingController();
  TextEditingController createRePassword = TextEditingController();
  TextEditingController createCurrentPassword = TextEditingController();
  bool createIsVisibile = (false);
  RxInt score = (0).obs;

  final RxBool _isLoading = (false).obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  String phone = '';
  PasswordScreenType type = PasswordScreenType.reset_password;

  onTapVisibile() {
    createIsVisibile = !createIsVisibile;
    update();
  }

  @override
  onInit() async {
    super.onInit();
    receiveParameters();
  }

  receiveParameters() {
    if (Get.arguments != null) {
      type = Get.arguments["type"] ?? PasswordScreenType.reset_password;
      phone = Get.arguments["phone"] ?? "";
    }
  }

  checkPasswordStrength(String holder) {
    score.value = AppValidators.passwordCriteriaVlidator(
      holder,
    );
    update();
  }

  resetPassword() async {
    isLoading = true;
    ResetPasswordUseCase resetPasswordUseCase = sl();
    final result = await resetPasswordUseCase(ResetPasswordParams(
        confirmPassword: createPassword.text,
        password: createPassword.text,
        phone: phone,
        prefix: appController.countryCode));
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      isLoading = false;
      Get.back();
      Get.back();
      // appController.setAccessToken(r.data!.token ?? "");
      // Get.offAllNamed(AppRoutes.bottomNavBar);
    });
  }

  onTapSave() {
    if (resetPasswordKey.currentState!.validate()) {
      if (type == PasswordScreenType.update_password) {
        updatePassword();
      } else {
        resetPassword();
      }
    }
  }

  updatePassword() async {
    isLoading = true;
    UpdatePasswordUseCase updatePasswordUseCase = sl();
    final result = await updatePasswordUseCase(UpdatePasswordParams(
        newPassword: createPassword.text,
        confirmationPassword: createPassword.text,
        oldPassword: createCurrentPassword.text));
    result!.fold((l) {
      isLoading = false;
    }, (r) {
      createPassword.clear();
      createRePassword.clear();
      createCurrentPassword.clear();
      isLoading = false;
    });
  }
}

class PasswordCondition {
  String? title;
  bool? done;
  PasswordCondition({
    this.title,
    this.done,
  });
}
