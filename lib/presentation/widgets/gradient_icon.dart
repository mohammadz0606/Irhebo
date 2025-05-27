import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class GradientIcon extends StatelessWidget {
  final String? icn;
  final Color? svgColor;
  final Color? bkgColor;
  final bool gradient;
  final bool matchTextDirection;

  const GradientIcon(
      {super.key,
      this.icn,
      this.svgColor,
      this.bkgColor,
      this.gradient = true,
      this.matchTextDirection = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return DecoratedIcon(
        decoration: Get.find<AppController>().darkMode
            ? gradient
                ? AppDecoration.getGradientWithRadius(
                    dark: Get.find<AppController>().darkMode)
                : AppDecoration.getDecorationWithRadius(
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkScaffoldColor
                        : AppLightColors.secondary)
            : Get.find<AppController>().darkMode
                ? null
                : AppDecoration.getDecorationWithRadius(
                    color: AppLightColors.secondary),
        // // change the widget and height because it caused overflow 1.4 pixels to the right
        // height: 9*(w/100),
        // width: 9*(w/100),
        height: 9.95 * (w / 100),
        width: 9.95 * (w / 100),
        padding: 2 * (w / 100),
        matchTextDirection: matchTextDirection,
        imagePath: icn ?? AppIcons.arrowLeft,
        color: bkgColor ?? AppDarkColors.darkScaffoldColor,
        svgColor: svgColor);
  }
}
