import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:shimmer/shimmer.dart';

class AppLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final BoxBorder? border;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  const AppLoading(
      {super.key,
      this.width,
      this.height,
      this.radius,
      this.border,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 15),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        clipBehavior: radius != null ? Clip.antiAliasWithSaveLayer : Clip.none,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 15), border: border),
        child: Shimmer.fromColors(
          baseColor: Get.find<AppController>().darkMode
              ? Color(0xFF282828)
              : Colors.grey[300]!,
          highlightColor: Get.find<AppController>().darkMode
              ? Color(0xFF3A3A3A)
              : Colors.grey[100]!,
          enabled: true,
          child: Container(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
