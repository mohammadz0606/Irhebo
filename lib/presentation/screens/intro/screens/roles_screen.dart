import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/intro/splash_controller.dart';
import 'package:irhebo/presentation/widgets/app_button.dart';
import 'package:irhebo/presentation/widgets/auth_app_bar.dart';
import 'package:irhebo/presentation/widgets/auth_headline.dart';
import 'package:irhebo/presentation/widgets/language_item_widget.dart';

class RolesScreen extends GetWidget<SplashController> {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Get.find<AppController>().darkMode ? null : Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(27 * (w / 100)),
          child: const AuthAppBar(
            hasBack: false,
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.97 * (w / 100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeadline(
              title: "What would you like to do",
              subtitle: "Choose your role in ${Get.find<AppController>().generalData?.platformTitle ?? ""}",
              bottomPadding: 8.2 * (w / 100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 2; i++)
                  Obx(
                    () => LanguageItemWidget(
                      onTap: () => controller.onChangeRole(i),
                      selected: i == controller.selectedRoleIndex,
                      title: i == 0 ? "Find Service" : "Sell Service",
                      icon: i == 0 ? AppIcons.searchIcon : AppIcons.coin,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 5.47 * (w / 100),
            ),
            Obx(
              () => AppButton(
                // bottom: true,
                backGroundColor: controller.selectedRoleIndex == -1
                    ? AppDarkColors.primaryColor.withOpacity(0.4)
                    : null,
                onPressed: () => controller.selectedRoleIndex == -1
                    ? null
                    : Get.toNamed(AppRoutes.login),
                title: "Continue",
                titlStyle: controller.selectedRoleIndex == -1
                    ? Get.theme.textTheme.labelMedium
                    : null,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppButton(
            bottom: true,
            borderColor: AppDarkColors.primaryColor,
            backGroundColor: Get.find<AppController>().darkMode
                ? AppDarkColors.primaryColor.withOpacity(0.25)
                : AppLightColors.primaryColor.withOpacity(0.05),
            width: 20.39 * (w / 100),
            borderRadius: 11,
            hieght: 12.93 * (w / 100),
            titlStyle: Get.theme.textTheme.labelMedium?.copyWith(
                color:
                    Get.find<AppController>().darkMode ? null : Colors.black),
            onPressed: () => Get.offAllNamed(AppRoutes.bottomNavBar),
            title: "Skip",
          ),
        ],
      ),
    );
  }
}
