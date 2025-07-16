import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/presentation/screens/auth/verification/verification_controller.dart';
import 'package:irhebo/presentation/screens/auth/verification/widgets/resend_code_widget.dart';
import 'package:pinput/pinput.dart';

class PinPutWidget extends GetWidget<VerificationController> {
  const PinPutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => Center(
        child: Column(
          children: [
            Form(
              // key: controller.otpKey,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  controller: controller.pinPutController,
                  length: 6,
                  // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  // validator: AppValidators.validateOtp,
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'[0-9A-Za-z]')), // Allows only numbers and letters
                  ],
                  defaultPinTheme: PinTheme(
                    width: 14.92 * (w / 100),
                    height: 14.92 * (w / 100),
                    decoration: Get.find<AppController>().darkMode
                        ? pinputDecoration
                        : pinputLightDecoration,
                    textStyle: getRegularStyle(
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        fontSize: AppTextStyle.size16),
                  ),
                  focusedPinTheme: PinTheme(
                    padding: EdgeInsets.zero,
                    width: 14.92 * (w / 100),
                    height: 14.92 * (w / 100),
                    decoration: Get.find<AppController>().darkMode
                        ? focusedPinputDecoration
                        : focusedPinputLightDecoration,
                    textStyle: getRegularStyle(
                        color: Get.find<AppController>().darkMode
                            ? AppDarkColors.pureWhite.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        fontSize: AppTextStyle.size16),
                  ),
                  followingPinTheme: PinTheme(
                    width: 14.92 * (w / 100),
                    height: 14.92 * (w / 100),
                    decoration: Get.find<AppController>().darkMode
                        ? pinputDecoration
                        : pinputLightDecoration,
                  ),
                  errorText: "enter valid otp".tr,
                  // onChanged: controller.verifyOtp,
                  forceErrorState: !controller.isValidOtp,
                  disabledPinTheme: PinTheme(
                    decoration: Get.find<AppController>().darkMode
                        ? pinputDecoration
                        : pinputLightDecoration,
                    width: 14.92 * (w / 100),
                    height: 14.92 * (w / 100),
                  ),
                  toolbarEnabled: false,
                  closeKeyboardWhenCompleted: true,
                  onSubmitted: (val) => controller.onTapVerify(),
                  onCompleted: (val) => controller.onTapVerify(),
                ),
              ),
            ),
            SizedBox(
              height: 9.2 * (w / 100),
            ),
            const ResendCodeWidget()
          ],
        ),
      ),
    );
  }
}
