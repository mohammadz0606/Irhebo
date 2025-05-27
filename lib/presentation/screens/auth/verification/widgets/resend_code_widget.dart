import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/auth/verification/verification_controller.dart';

class ResendCodeWidget extends GetWidget<VerificationController> {
  const ResendCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Obx(
      () => CountdownTimer(
        endTime: controller.endTime,
        widgetBuilder: (_, var time) {
          if (time == null) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(("Didnt received a code".tr),
                    style: Get.theme.textTheme.labelMedium!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5),
                    )),
                SizedBox(
                  width: 1 * (w / 100),
                ),
                InkWell(
                  onTap: controller.isLoadingSend
                      ? () {}
                      : () => controller.resendOtp(),
                  child: controller.isLoadingSend
                      ? SizedBox(
                          height: 4 * (w / 100),
                          width: 4 * (w / 100),
                          child: CircularProgressIndicator(
                            color: AppDarkColors.greenContainer,
                            strokeWidth: 1,
                          ),
                        )
                      : Text(
                          "Resend Code".tr,
                          style: Get.theme.textTheme.labelMedium!.copyWith(
                            color: Get.find<AppController>().darkMode
                                ? AppDarkColors.greenText
                                : AppLightColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                )
              ],
            );
          }
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
                Get.find<AppController>().lang.value.languageCode ==
                        AppLanguage.en.name
                    ? "${"reSend".tr} ${time.min == null ? "00" : time.min.toString().padLeft(2, '0')}: ${time.sec == null ? "00" : time.sec.toString().padLeft(2, '0')}"
                    : "${"reSend".tr} ${time.sec == null ? "00" : time.sec.toString().padLeft(2, '0')} : ${time.min == null ? "00" : time.min.toString().padLeft(2, '0')}",
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.labelMedium!.copyWith(
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                )),
          );
        },
      ),
    );
  }
}
