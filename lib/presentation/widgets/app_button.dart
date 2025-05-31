// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final double? horizontalMargin;
  final double? verticalMargin;
  final EdgeInsetsGeometry? margin;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final TextStyle? titlStyle;
  final double? borderRadius;
  final Color? overlayColor;
  final double? width;
  final bool bottom;
  final double? hieght;
  final double? elevation;
  final Widget? child;
  final bool isLoading;

  const AppButton(
      {super.key,
      required this.onPressed,
      this.title,
      this.padding,
      this.horizontalMargin,
      this.verticalMargin,
      this.margin,
      this.backGroundColor,
      this.borderColor,
      this.shadowColor,
      this.titlStyle,
      this.borderRadius,
      this.overlayColor,
      this.width,
      this.hieght,
      this.elevation,
      this.child,
      this.bottom = false,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: bottom
          ? EdgeInsets.all(5.97 * (w / 100))
          : EdgeInsets.symmetric(
              horizontal: horizontalMargin ?? 0.0,
              vertical: verticalMargin ?? 0.0),
      child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
              elevation: elevation ?? 0,
              padding: EdgeInsets.zero,
              fixedSize:
                  Size(width ?? 88 * (w / 100), hieght ?? 13.18 * (w / 100)),
              backgroundColor: backGroundColor ?? AppDarkColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 38),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                ),
              ),
              shadowColor: shadowColor),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Center(
                  child: child ??
                      Text(
                        title?.tr ?? "",
                        style: titlStyle,
                      ),
                )),
    );
  }
}
