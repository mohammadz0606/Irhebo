import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class DecoratedIcon extends StatelessWidget {
  final String imagePath;
  final bool isSvg;
  final double? width;
  final double? height;
  final double? padding;
  final Color? color;
  final Color? svgColor;
  final BoxDecoration? decoration;
  final bool networkImage;
  final bool language;
  final bool matchTextDirection;
  const DecoratedIcon(
      {super.key,
      this.isSvg = true,
      required this.imagePath,
      this.color,
      this.svgColor,
      this.width,
      this.height,
      this.padding,
      this.decoration,
      this.networkImage = false,
      this.matchTextDirection = false,
      this.language = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: width ?? 12.43 * (w / 100),
      height: height ?? 12.43 * (w / 100),
      padding: EdgeInsets.all(padding ?? 2 * (w / 100)),
      decoration: decoration ??
          BoxDecoration(
            // color: color ?? AppColors.lightPrimary,
            color: color ??
                (Get.find<AppController>().darkMode
                    ? AppDarkColors.greenContainer.withOpacity(0.07)
                    : AppLightColors.secondary),
            borderRadius: BorderRadius.circular(50 * (w / 100)),
          ),
      child: networkImage
          ? SvgPicture.network(
              imagePath,
              fit: BoxFit.contain,
              color: Get.find<AppController>().darkMode
                  ? Colors.white
                  : AppLightColors.primaryColor,
              // matchTextDirection: matchTextDirection,
            )
          : AppIcon(
              isSvg: isSvg,
              color: language
                  ? null
                  : Get.find<AppController>().darkMode
                      ? svgColor
                      : AppLightColors.primaryColor,
              path: imagePath,
              matchTextDirection: matchTextDirection,
              width: 5.9 * (w / 100),
              height: 5.9 * (w / 100),
            ),
    );
  }
}
