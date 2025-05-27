// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/screens/bottom_nav_bar/screens/settings/settings_controller.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class SettingsRow extends GetView<SettingsController> {
  final bool? value;
  final String title;
  final Function(bool)? onChange;
  final Function()? onTap;
  const SettingsRow(
      {super.key, this.value, required this.title, this.onChange, this.onTap});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : null,
      child: Container(
        height: 12.43 * (w / 100),
        margin: EdgeInsets.symmetric(vertical: 1.74 * (w / 100)),
        padding: EdgeInsets.symmetric(
            vertical: 1.99 * (w / 100), horizontal: 3.98 * (w / 100)),
        decoration: AppDecoration.getDecorationWithRadius(
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer2
                : AppLightColors.pureWhite,
            radius: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.tr,
              style: Get.theme.textTheme.labelMedium?.copyWith(
                  color: Get.find<AppController>().darkMode
                      ? Colors.white
                      : Colors.black),
            ),
            (value != null)
                ? Row(
                    children: [
                      Container(
                        height: 5.45 * (w / 100),
                        width: 1,
                        decoration: AppDecoration.getDecorationWithRadius(
                            color: Get.find<AppController>().darkMode
                                ? AppDarkColors.greenContainer
                                : AppLightColors.darkPrimary2,
                            radius: 14),
                      ),
                      SizedBox(
                        width: 2.48 * (w / 100),
                      ),
                      Switch(
                        inactiveTrackColor: Get.find<AppController>().darkMode
                            ? AppDarkColors.greyCaption
                            : AppLightColors.primaryColor.withOpacity(0.4),
                        onChanged: (val) => onChange!(val),
                        value: value!,
                      )
                    ],
                  )
                : AppIcon(
                    path: AppIcons.arrowRight,
                    matchTextDirection: true,
                    color: Get.find<AppController>().darkMode
                        ? null
                        : Colors.black.withOpacity(0.5),
                    width: 5 * (w / 100),
                    height: 5 * (w / 100),
                  )
            // AppIcon(
            //     width: 5.47 * (w / 100),
            //     height: 5.47 * (w / 100),
            //     path: AppIcons.next,
            //     matchTextDirection: true,
            //     // isSvg: false,
            //     color: AppColors.pureWhite,
            //   )
          ],
        ),
      ),
    );
  }
}
