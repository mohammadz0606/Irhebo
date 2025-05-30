import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class AppDecoration {
  static BoxShadow getShadow({Color? color}) {
    return BoxShadow(
        color: color ?? Theme.of(Get.context!).colorScheme.secondary,
        spreadRadius: 2,
        blurRadius: 8,
        offset: const Offset(0, 0));
  }

  static Gradient getGradient(List<Color> colors, {List<double>? stops}) {
    return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: colors,
        stops: stops);
  }

  static getContainerWithShadow({
    Color? color,
    double? radius,
    double? opacity,
    double? blur,
    double? x,
    double? y,
    Color? borderColor,
  }) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 4),
        color: color ?? Colors.white,
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            offset: Offset(x ?? 0, y ?? 0),
            spreadRadius: 0,
            blurRadius: blur ?? 10,
            color: Colors.black.withOpacity(opacity ?? 0.1),
          )
        ]);
  }

  static getContainerWithBorder({
    Color? color,
    Color? borderColor,
    double? radius,
    double? borderWidth,
  }) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 12),
        color: color ?? Colors.transparent,
        border: Border.all(
            color: borderColor ?? Colors.transparent, width: borderWidth ?? 1));
  }

  static getGradientWithRadius(
      {Color? color,
      Color? borderColor,
      double? radius,
      double? borderWidth,
      bool dark = true}) {
    return BoxDecoration(
        color: color,
        // color: Colors.red,
        border: GradientBoxBorder(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: dark
                  ? AppDarkColors.gradientGreenContainer
                  : AppLightColors.gradientGreenContainer),
          width: borderWidth ?? 1,
        ),
        borderRadius: BorderRadius.circular(radius ?? 24));
  }

  static getGradientContainer(
      {Color? color,
      Color? borderColor,
      double? radius,
      double? borderWidth,
      bool dark = true}) {
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: dark
              ? AppDarkColors.gradientGreenContainer
              : AppDarkColors.gradientGreenContainer,
        ),
        borderRadius: BorderRadius.circular(radius ?? 24));
  }

  static getDecorationWithRadius(
      {Color? color,
      Color? borderColor,
      double? radius,
      double? borderWidth,
      bool dark = true}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 24),
      color: color ?? Colors.transparent,
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: borderWidth ?? 1,
      ),
    );
  }

  static getDecorationWithShadow(
      {Color? color,
      Color? borderColor,
      double? radius,
      double? borderWidth,
      bool dark = true}) {
    return BoxDecoration(
      boxShadow: [getShadow(color: Colors.grey.withOpacity(0.1))],
      borderRadius: BorderRadius.circular(radius ?? 24),
      color: color ?? Colors.white,
    );
  }

  // BoxShadow getShadow({Color? color}) {
  //   return BoxShadow(
  //       color: color ?? Theme.of(Get.context!).colorScheme.secondary,
  //       spreadRadius: 6,
  //       blurRadius: 24,
  //       offset: const Offset(0, 4));
  // }

  // Gradient getGradient(List<Color> colors, {List<double>? stops}) {
  //   return LinearGradient(
  //       begin: Alignment.centerLeft,
  //       end: Alignment.centerRight,
  //       colors: colors,
  //       stops: stops);
  // }

  static RoundedRectangleBorder bottomSheetShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)));
}
