import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/storage/app_prefs_keys.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/widgets/bot_floating_button.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/widgets/navigation_bar_container.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../app/app_functions.dart';
import '../../../app/enums.dart';

class BottomNavBarScreen extends GetView<BottomNavBarController> {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => controller.onWillPop(didPop),
      child: ShowCaseWidget(
        onFinish: () => Get.find<AppController>()
            .setBoolValue(true, AppPrefsKeys.SHOW_CASE_HOME),
        builder: (context) => Obx(
          () => Scaffold(
            floatingActionButton: (getUserRole == UserRoles.freelancer)
                ? Showcase(
                    targetBorderRadius: BorderRadius.circular(50),
                    key: Get.find<AppController>().botKey,
                    description: "This is bot made for you".tr,
                    child: const BotFloatingButton())
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: controller.pages[controller.index],
            bottomNavigationBar: const AppNavigationBarContainer(),
          ),
        ),
      ),
    );
  }
}
