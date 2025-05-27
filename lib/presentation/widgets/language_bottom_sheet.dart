import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';

class LanguageBottomSheet extends GetWidget<AppController> {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        height: 4.97 * (w / 100),
      ),
      AppButton(
        onPressed: () => {
          Get.back(),
          controller.onChangeLanguage(AppLanguage.en.name),
          Get.offAllNamed(AppRoutes.splash)
        },
        //     backGroundColor: Get.find<AppController>().darkMode
        //     ? AppDarkColors.darkContainer2
        //     : AppLightColors.secondary,
        // borderColor: Get.find<AppController>().darkMode
        //     ? AppDarkColors.greenContainer
        //     : AppLightColors.primaryColor,
        // titlStyle: Get.theme.textTheme.labelMedium?.copyWith(
        //     color: Get.find<AppController>().darkMode
        //         ? null
        //         : AppLightColors.primaryColor),
        backGroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer2
            : AppLightColors.primaryColor,
        borderColor: Get.find<AppController>().darkMode
            ? AppDarkColors.greenContainer
            : null,
        title: "English",
      ),
      SizedBox(
        height: 4.97 * (w / 100),
      ),
      AppButton(
        onPressed: () => {
          Get.back(),
          controller.onChangeLanguage(AppLanguage.ar.name),
          Get.offAllNamed(AppRoutes.splash)
        },
        title: "العربية",
        backGroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer2
            : AppLightColors.primaryColor,
        borderColor: Get.find<AppController>().darkMode
            ? AppDarkColors.greenContainer
            : null,
      ),
      SizedBox(
        height: 4 * (w / 100),
      ),
    ]);
  }
}
