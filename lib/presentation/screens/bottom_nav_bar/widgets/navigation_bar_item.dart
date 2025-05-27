// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class AppNavigationBarItem extends GetWidget<BottomNavBarController> {
  final int index;
  final String imagePath;
  const AppNavigationBarItem({
    super.key,
    required this.index,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Obx(
      () => TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () => controller.onChangeIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 0.2 * (h / 100)),
            AppIcon(
              path: imagePath,
              width: 5.8 * (w / 100),
              height: 5.8 * (w / 100),
              color: controller.index == index
                  ? Get.find<AppController>().darkMode
                      ? AppDarkColors.greenContainer
                      : AppLightColors.primaryColor
                  : Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite.withOpacity(0.5)
                      : Colors.grey,
            ),
            SizedBox(height: 0.62 * (h / 100)),
            Text(
              index == 0
                  ? "Requests".tr
                  : index == 1
                      ? 'Chats'.tr
                      : index == 2
                          ? "Home".tr
                          : index == 3
                              ? 'Wishlist'.tr
                              : 'Settings'.tr,
              style: controller.index == index
                  ? Get.theme.textTheme.labelSmall!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.greenContainer
                          : AppLightColors.primaryColor)
                  : Get.theme.textTheme.labelSmall!.copyWith(
                      color: Get.find<AppController>().darkMode
                          ? AppDarkColors.pureWhite.withOpacity(0.5)
                          : Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
