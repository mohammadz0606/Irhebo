import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class AddButton extends StatelessWidget {
  final Function() onTap;

  const AddButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: AppDecoration.getContainerWithBorder(
            radius: 12,
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer
                : AppLightColors.secondary,
            // borderWidth: 2,
            borderColor: Get.find<AppController>().darkMode
                ? AppDarkColors.greenContainer
                : AppLightColors.primaryColor),
        child: AppIcon(
          padding: EdgeInsets.all(3 * (w / 100)),
          path: AppIcons.add,
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.pureWhite.withOpacity(0.5)
              : AppLightColors.primaryColor,
          width: 15 * (w / 100),
          height: 15 * (w / 100),
        ),
      ),
    );
  }
}
