import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/text_style.dart';
import 'package:irhebo/presentation/widgets/app_image.dart';

class AppLogo extends GetWidget<AppController> {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppImage(
          imageUrl: controller.generalData?.platformLogo ?? "",
          radius: 50 * (w / 100),
          width: 7.46 * (w / 100),
          height: 7.46 * (w / 100),
        ),
        SizedBox(
          width: 2.48 * (w / 100),
        ),
        Text(
          controller.generalData?.platformTitle ?? "",
          style: Get.theme.appBarTheme.titleTextStyle
              ?.copyWith(fontSize: AppTextStyle.size14),
        ),
      ],
    );
  }
}
