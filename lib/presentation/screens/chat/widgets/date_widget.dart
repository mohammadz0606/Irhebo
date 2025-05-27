import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class DateWidget extends StatelessWidget {
  final String date;
  final bool forRequest;
  const DateWidget({super.key, required this.date, this.forRequest = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(
            horizontal: 3 * (w / 100), vertical: 1 * (w / 100)),
        decoration: BoxDecoration(
          color: forRequest
              ? Get.find<AppController>().darkMode
                  ? Colors.transparent
                  : AppLightColors.secondary
              : Get.find<AppController>().darkMode
                  ? AppDarkColors.greenContainer
                  : AppLightColors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(date,
            style: forRequest
                ? Get.theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.9)
                        : Colors.black.withOpacity(0.6))
                : Get.theme.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.7)
                        : Colors.black.withOpacity(0.5))),
      ),
    );
  }
}
