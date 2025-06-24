// ignore_for_file: unused_local_variable, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/models/login_model.dart';
import 'package:irhebo/domain/params/login_params.dart';
import 'package:irhebo/domain/usecases/auth_usecases/login_use_case.dart';

import '../../../../app/enums.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../app/storage/app_prefs_keys.dart';

class LoginController extends GetxController {
  final appController = Get.find<AppController>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController loginPhone = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  final loginModel = Rxn<LoginModel>();
  final RxBool _isVisibileLogin = (false).obs;
  final RxBool _isLoading = (false).obs;

  bool get isVisibileLogin => _isVisibileLogin.value;

  bool get isLoading => _isLoading.value;

  set isVisibileLogin(value) => _isVisibileLogin.value = value;

  set isLoading(value) => _isLoading.value = value;

  onTapVisibile() {
    isVisibileLogin = !isVisibileLogin;
  }

  loginClient() async {
    if (loginFormKey.currentState!.validate()) {
      isLoading = true;
      loginModel.value = null;
      LoginUseCase loginUseCase = sl();
      final result = await loginUseCase(LoginParams(
        password: loginPassword.text,
        phone: loginPhone.text,
        prefix: appController.countryCode,
      ));
      result!.fold((l) {
        isLoading = false;
      }, (r) {
        isLoading = false;
        loginModel.value = r.data;
        appController.setAccessToken(
            r.data!.token ?? '', r.data!.user?.id ?? 0);
        AppPreferences prefs = sl();

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

        prefs.setBoolValue(
          r.data?.user?.isNotifiable == 1,
          AppPrefsKeys.IS_NOTIFIABLE,
        );
//792856567
        if (r.data!.user?.verifiedAt == null) {
          Get.toNamed(AppRoutes.verification, arguments: {
            "verify_type": VerifyScreenType.register,
            //"code": generalModel.data,
            "phone": r.data!.user?.phone,
          });
        } else {
          Get.offAllNamed(AppRoutes.bottomNavBar);
        }
      });
    }
  }

  onTapForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword, arguments: {
      "phone": loginPhone.text,
    });
  }
}
