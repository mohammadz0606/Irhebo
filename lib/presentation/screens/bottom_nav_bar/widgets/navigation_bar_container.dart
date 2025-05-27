// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/widgets/navigation_bar_item.dart';
import 'package:showcaseview/showcaseview.dart';

class AppNavigationBarContainer extends GetWidget<AppController> {
  const AppNavigationBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Obx(
      () => Container(
          decoration: BoxDecoration(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.darkScaffoldColor
                  : AppLightColors.scaffoldColor2,
              border: Get.find<AppController>().darkMode
                  ? null
                  : Border(top: BorderSide(color: AppLightColors.secondary))),
          padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
          height: 8.7 * (h / 100),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: AppNavigationBarItem(
                  index: 0,
                  imagePath: AppIcons.requests,
                ),
              ),
              Expanded(
                flex: 1,
                child: Showcase(
                  key: Get.find<AppController>().chatKey,
                  description: "This is chats section".tr,
                  child: AppNavigationBarItem(
                    index: 1,
                    imagePath: AppIcons.message,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AppNavigationBarItem(
                  index: 2,
                  imagePath: AppIcons.home,
                ),
              ),
              Expanded(
                flex: 1,
                child: AppNavigationBarItem(
                  index: 3,
                  imagePath: AppIcons.heart,
                ),
              ),
              Expanded(
                flex: 1,
                child: AppNavigationBarItem(
                  index: 4,
                  imagePath: AppIcons.settings,
                ),
              ),
            ],
          )),
    );
  }
}
