import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class ServiceDetailsAppBar extends StatelessWidget {
  final bool profile;
  final Function()? onTapChat;
  const ServiceDetailsAppBar({
    super.key,
    this.profile = false,
    this.onTapChat,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.98 * (w / 100)),
      width: 100 * (w / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(50 * (w / 100)),
            child: Container(
              decoration: Get.find<AppController>().darkMode
                  ? AppDecoration.getGradientWithRadius(radius: 50 * (w / 100))
                  : null,
              child: DecoratedIcon(
                height: 9.95 * (w / 100),
                width: 9.95 * (w / 100),
                padding: 2 * (w / 100),
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkScaffoldColor
                    : AppLightColors.secondary,
                imagePath: AppIcons.arrowLeft,
                svgColor: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : AppLightColors.primaryColor,
                matchTextDirection: true,
              ),
            ),
          ),
          if (profile)
            GestureDetector(
              onTap: () => onTapChat!(),
              child: Container(
                decoration: Get.find<AppController>().darkMode
                    ? AppDecoration.getGradientWithRadius(
                        radius: 50 * (w / 100),
                      )
                    : null,
                child: DecoratedIcon(
                  height: 9.95 * (w / 100),
                  width: 9.95 * (w / 100),
                  padding: 2 * (w / 100),
                  color: Get.find<AppController>().darkMode
                      ? AppDarkColors.darkScaffoldColor
                      : AppLightColors.secondary,
                  imagePath: AppIcons.message,
                  svgColor: Get.find<AppController>().darkMode
                      ? AppDarkColors.pureWhite
                      : AppLightColors.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
