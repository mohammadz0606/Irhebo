import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/injection.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/domain/params/send_otp_params.dart';
import 'package:irhebo/domain/usecases/auth_usecases/send_otp_use_case.dart';

import '../../../../app/network/end_points.dart';
import '../../../../app/network/network.dart';
import '../../../../app/snack_bar.dart';
import '../../../../domain/models/otp_model.dart';

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

      try {
        final response = await Network().post(
          url: AppEndpoints.requestCode,
          data: SendOtpParams(
                  phone: phoneConfirmation.text,
                  prefix: appController.countryCode)
              .toJson(),
        );
        String errorMessage = await Network().handelError(response: response);
        if (errorMessage.isNotEmpty) {
          isLoading = false;
          AppSnackBar.openErrorSnackBar(
            message: errorMessage,
          );
          return;
        }

        OtpModel otpModel = OtpModel.fromJson(response.data);

        Get.toNamed(AppRoutes.verification, arguments: {
          "verify_type": VerifyScreenType.forget_password,
          "prefix": appController.countryCode,
          "phone": phoneConfirmation.text,
          "code": otpModel.code ?? "",
        });

        isLoading = false;
      } catch (error) {
        if (error is DioException) {
          AppSnackBar.openErrorSnackBar(
            message: Network().handelDioException(error),
          );
        } else {
          AppSnackBar.openErrorSnackBar(
            message: error.toString(),
          );
        }
        isLoading = false;
      }

      // SendOtpUseCase requestCodeUseCase = sl();
      // final result = await requestCodeUseCase(SendOtpParams(
      //     phone: phoneConfirmation.text, prefix: appController.countryCode));
      // result!.fold((l) {
      //   isLoading = false;
      // }, (r) {
      //   isLoading = false;
      //   Get.toNamed(AppRoutes.verification, arguments: {
      //     "verify_type": VerifyScreenType.forget_password,
      //     "prefix": appController.countryCode,
      //     "phone": phoneConfirmation.text,
      //     "code": r.data!.code ?? ""
      //   });
      // });
    }
  }
}
