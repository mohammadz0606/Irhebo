// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class AppNavigationBar extends GetWidget<BottomNavBarController> {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Obx(
      () => Container(
        height: 8.7 * (h / 100),
        decoration: const BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(width: 0.3, color: Colors.grey))),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.2 * (h / 100)),
                    AppIcon(
                      path: AppIcons.home,
                      isSvg: true,
                      width: 5.8 * (w / 100),
                      height: 5.8 * (w / 100),
                      color: controller.index == 0
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    SizedBox(height: 0.62 * (h / 100)),
                  ],
                ),
                label: 'Home'.tr),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.2 * (h / 100)),
                    AppIcon(
                      path: AppIcons.requests,
                      isSvg: true,
                      width: 5.8 * (w / 100),
                      height: 5.8 * (w / 100),
                      color: controller.index == 1
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    SizedBox(height: 0.62 * (h / 100)),
                  ],
                ),
                label: 'Requests'.tr),
            BottomNavigationBarItem(icon: const Text(''), label: ''.tr),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.2 * (h / 100)),
                    AppIcon(
                      path: AppIcons.bot,
                      isSvg: true,
                      width: 5.8 * (w / 100),
                      height: 5.8 * (w / 100),
                      color: controller.index == 3
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    SizedBox(height: 0.62 * (h / 100)),
                  ],
                ),
                label: 'Bot'.tr),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 0.2 * (h / 100)),
                    AppIcon(
                      path: AppIcons.chats,
                      isSvg: true,
                      width: 5.8 * (w / 100),
                      height: 5.8 * (w / 100),
                      color: controller.index == 4
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    SizedBox(height: 0.62 * (h / 100)),
                  ],
                ),
                label: 'Chats'.tr),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.2 * (h / 100)),
                    AppIcon(
                      path: AppIcons.settings,
                      isSvg: true,
                      width: 5.8 * (w / 100),
                      height: 5.8 * (w / 100),
                      color: controller.index == 0
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    SizedBox(height: 0.62 * (h / 100)),
                  ],
                ),
                label: 'Settings'.tr),
          ],
          enableFeedback: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: controller.onChangeIndex,
          elevation: 0.0,
          useLegacyColorScheme: false,
          currentIndex: controller.index,
          // showUnselectedLabels: false,
          // showSelectedLabels: false,
          // unselectedLabelStyle: AppTextStyle.xSmallBlackRegular,
          // selectedLabelStyle: AppTextStyle.xSmallPrimaryBold,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
