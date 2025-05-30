import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';

class LogoutBottomSheet extends GetWidget<SettingsController> {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        height: 4.97 * (w / 100),
      ),
      AppButton(
        onPressed: () => Get.back(),
        title: "Cancel",
        titlStyle: Get.find<AppController>().darkMode
            ? null
            : const TextStyle(
                color: AppLightColors.primaryColor,
              ),
        backGroundColor: Get.find<AppController>().darkMode
            ? AppDarkColors.darkContainer2
            : Colors.white,
        borderColor: Get.find<AppController>().darkMode
            ? AppDarkColors.greenContainer
            : AppLightColors.primaryColor,
      ),
      SizedBox(
        height: 4.97 * (w / 100),
      ),
      Obx(
        () => AppButton(
          isLoading: controller.isLoadingLogout.value,
          backGroundColor: Get.find<AppController>().darkMode
              ? AppDarkColors.logout
              : AppLightColors.redBadge,
          onPressed: controller.logout,
          title: "Logout",
        ),
      ),
      SizedBox(
        height: 4 * (w / 100),
      ),
    ]);
  }
}
