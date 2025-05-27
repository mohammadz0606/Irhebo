import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthHeadline extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? bottomPadding;
  const AuthHeadline(
      {super.key,
      required this.title,
      required this.subtitle,
      this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsetsDirectional.only(bottom: bottomPadding ?? 16.9 * (w / 100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 65.92 * (w / 100),
            child: Text(
              title.tr,
              style: Get.textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
          SizedBox(
            width: 75.87 * (w / 100),
            child: Text(
              subtitle.tr,
              style: Get.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
