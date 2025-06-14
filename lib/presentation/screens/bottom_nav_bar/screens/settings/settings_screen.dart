import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_controller.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/widgets/currency_data.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/widgets/settings_row.dart';
import 'package:irhebo/presentation/widgets/normal_app_bar.dart';

import '../../../../../app/resources/style/colors.dart';
import '../../../../widgets/app_bottom_sheet.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GetBuilder<AppController>(builder: (context) {
      return Scaffold(
        // backgroundColor:
        //     Get.find<AppController>().darkMode.value ? null : Colors.white,
        appBar: NormalAppBar(
          title: "Settings",
          onTapBack: () => Get.find<BottomNavBarController>().onWillPop(false),
        ),
        body: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
              child: Column(
                children: [
                  if (controller.appController.token.isNotEmpty)
                    SettingsRow(
                      title: "Profile",
                      onTap: controller.goToProfile,
                    ),
                  if (controller.appController.token.isNotEmpty)
                  SettingsRow(
                    title: "Quotations",
                    onTap: controller.onTapQuotations,
                  ),
                  if (controller.appController.token.isNotEmpty)
                  SettingsRow(
                    title: "Support Tickets",
                    onTap: controller.onTapSupportTickets,
                  ),
                  if (controller.appController.token.isNotEmpty)
                  SettingsRow(
                    title: "Notifications",
                    onChange: controller.onToggleNotifications,
                    value: controller.noti,
                  ),
                  SettingsRow(
                    title: "Dark Mode",
                    onChange: controller.onToggleMode,
                    value: controller.appController.darkMode,
                  ),
                  SettingsRow(
                    title: "Currency",
                    onTap: () {
                      Get.bottomSheet(
                        const AppBottomSheet(
                          title: "Currencies",
                          child: CurrencyData(),
                        ),
                        backgroundColor: Get.find<AppController>().darkMode
                            ? AppDarkColors.darkScaffoldColor
                            : AppLightColors.pureWhite,
                        barrierColor: Get.find<AppController>().darkMode
                            ? AppDarkColors.darkContainer.withOpacity(0.3)
                            : AppLightColors.shadow.withOpacity(0.3),
                        elevation: 0,
                        isScrollControlled: false,
                      );
                    },
                  ),
                  SettingsRow(
                    title: "Language",
                    onTap: () => controller.openLanguageBottomSheet(),
                  ),
                  SettingsRow(
                    title: "FAQ",
                    onTap: () => Get.toNamed(AppRoutes.faqs),
                  ),
                  SettingsRow(
                    title: "Privacy Policy",
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  ),
                  SettingsRow(
                    title: "Terms & Conditions",
                    onTap: () => Get.toNamed(AppRoutes.termsConditions),
                  ),
                  if (controller.appController.token.isNotEmpty)
                    SettingsRow(
                      title: "Logout",
                      onTap: controller.openLogoutBottomSheet,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
