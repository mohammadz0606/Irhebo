import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppRoundedLoadingButton extends StatelessWidget {
  final Function onPressed;
  final Widget? child;
  final TextStyle? titlStyle;
  final String? title;
  final RoundedLoadingButtonController roundedLoadingButtonController;
  final EdgeInsetsGeometry? padding;
  final double? horizontalMargin;
  final double? verticalMargin;
  final TextStyle? titleStyle;
  final double? width;
  final bool bottom;
  final double? hieght;
  final double? borderRadius;
  final Color? backGroundColor;

  const AppRoundedLoadingButton({
    super.key,
    required this.onPressed,
    this.title,
    required this.roundedLoadingButtonController,
    this.padding,
    this.titleStyle,
    this.horizontalMargin,
    this.verticalMargin,
    this.bottom = true,
    this.width,
    this.hieght,
    this.child,
    this.titlStyle,
    this.borderRadius,
    this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: bottom
          ? EdgeInsets.all(5.97 * (w / 100))
          : EdgeInsets.symmetric(
              horizontal: horizontalMargin ?? 0.0,
              vertical: verticalMargin ?? 0.0),
      child: RoundedLoadingButton(
        width: width ?? 88 * (w / 100),
        height: hieght ?? 13.18 * (w / 100),
        color: backGroundColor ?? AppDarkColors.primaryColor,
        successColor: backGroundColor ?? AppDarkColors.primaryColor,
        controller: roundedLoadingButtonController,
        onPressed: () => onPressed(),
        valueColor: Colors.white,
        loaderStrokeWidth: 3,
        completionDuration: Duration(seconds: 1),
        resetAfterDuration: true,
        errorColor: AppDarkColors.primaryColor,
        borderRadius: borderRadius ?? 38,
        child: Center(
          child: child ??
              Text(
                title?.tr ?? "",
                style: titlStyle ?? Get.theme.textTheme.labelMedium,
              ),
        ),
      ),
    );
  }
}
