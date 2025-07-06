import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/home/home_controller.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';
import 'package:irhebo/presentation/widgets/app_logo.dart';
import 'package:irhebo/presentation/widgets/gradient_icon.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../app/app_functions.dart';
import '../../../../../../app/enums.dart';

class HomeAppBar extends GetWidget<HomeController>
    implements PreferredSizeWidget {
  // final bool hasBack;
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      color: Get.find<AppController>().darkMode
          ? null
          : AppLightColors.scaffoldColor,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        // clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 17.4 * (w / 100), bottom: 2.48 * (w / 100)),
            child: const AppLogo(),
          ),
          PositionedDirectional(
            start: 3.98 * (w / 100),
            end: 3.98 * (w / 100),
            top: 16.4 * (w / 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Showcase(
                      targetBorderRadius: BorderRadius.circular(50),
                      key: Get.find<AppController>().notificationsKey,
                      description: "This is notifications center".tr,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed(AppRoutes.notifications),
                            // onTap: () => Get.toNamed(AppRoutes.notifications),
                            borderRadius: BorderRadius.circular(50 * (w / 100)),
                            // onTap: () => Get.back(),
                            child: const GradientIcon(
                              icn: AppIcons.notification,
                            ),
                          ),
                          Obx(
                            () => controller.isLoading
                                ? const SizedBox.shrink()
                                : controller.appController.generalData
                                            ?.unreadNotifications ==
                                        0
                                    ? const SizedBox.shrink()
                                    : PositionedDirectional(
                                        start: -(1 * (w / 100)),
                                        top: -(1 * (w / 100)),
                                        child: Visibility(
                                          visible: 6 > 0,
                                          child: Container(
                                            height: 5 * (w / 100),
                                            width: 5 * (w / 100),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color:
                                                        AppDarkColors.pureWhite,
                                                    width: 1),
                                                color: Colors.red),
                                            child: Center(
                                              child: Text(
                                                "${controller.appController.generalData?.unreadNotifications}",
                                                textAlign: TextAlign.center,
                                                style: Get
                                                    .theme.textTheme.labelSmall!
                                                    .copyWith(
                                                        color: Get.find<
                                                                    AppController>()
                                                                .darkMode
                                                            ? null
                                                            : Colors.white,
                                                        fontSize: AppTextStyle
                                                            .size10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1.49 * (w / 100),
                    ),
                    Showcase(
                      targetBorderRadius: BorderRadius.circular(50),
                      key: Get.find<AppController>().whatsappKey,
                      description:
                          "This is for you to contact us on whatsapp".tr,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50 * (w / 100)),
                          onTap: () => controller.appController.launchWhatsapp(
                              controller.appController.generalData?.whatsapp ??
                                  ""),
                          child: Container(
                            height: 9.95 * (w / 100),
                            width: 9.95 * (w / 100),
                            padding: EdgeInsets.all(2 * (w / 100)),
                            decoration: AppDecoration.getDecorationWithRadius(
                                radius: 50, color: AppDarkColors.whatsappColor),
                            child: const AppIcon(path: AppIcons.whatsapp),
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => controller.openAddBottomSheet(),
                      borderRadius: BorderRadius.circular(50 * (w / 100)),
                      // onTap: () => Get.back(),
                      child: const GradientIcon(
                        icn: AppIcons.add,
                        svgColor: AppDarkColors.pureWhite,
                      ),
                    ),

                    if(getUserRole != UserRoles.freelancer)... {
                      SizedBox(
                        width: 1.49 * (w / 100),
                      ),
                      Showcase(
                        targetBorderRadius: BorderRadius.circular(50),
                        key: Get.find<AppController>().searchKey,
                        description:
                        "Search for any category or subcategory or service from here"
                            .tr,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.search,
                              arguments: {"fromSubcategories": false,}),
                          borderRadius: BorderRadius.circular(50 * (w / 100)),
                          // onTap: () => Get.back(),
                          child: const GradientIcon(
                            icn: AppIcons.searchIcon,
                            svgColor: AppDarkColors.pureWhite,
                          ),
                        ),
                      ),
                    }

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
