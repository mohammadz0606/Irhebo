import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class AppDialog extends StatelessWidget {
  final Widget child;
  const AppDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // barrierColor: AppColors.darkContainer.withOpacity(0.3),
        body: Align(
          alignment: Alignment.center,
          child: Container(
              width: 100 * (w / 100),
              margin: EdgeInsets.symmetric(horizontal: 5 * (w / 100)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.darkScaffoldColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: child),
        ),
      ),
    );
  }
}
