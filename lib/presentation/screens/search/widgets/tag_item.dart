// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';

class TagItem extends StatelessWidget {
  final bool selected;
  final bool freelancer;
  final String title;
  final void Function() onTapTag;
  final bool forRequest;
  const TagItem(
      {super.key,
      required this.selected,
      required this.onTapTag,
      required this.title,
      this.freelancer = false,
      this.forRequest = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onTapTag(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: freelancer ? 1.4 * (w / 100) : 1.49 * (w / 100)),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 2.48 * (w / 100),
              horizontal: freelancer ? 4.42 * (w / 100) : 5.97 * (w / 100)),
          decoration: selected
              ? Get.find<AppController>().darkMode
                  ? AppDecoration.getGradientContainer()
                  : AppDecoration.getDecorationWithRadius(
                      color: AppLightColors.primaryColor,
                    )
              : Get.find<AppController>().darkMode
                  ? AppDecoration.getGradientWithRadius(
                      dark: Get.find<AppController>().darkMode)
                  : AppDecoration.getDecorationWithRadius(
                      color: AppLightColors.primaryColor.withOpacity(0.1),
                    ),
          child: Text(
            title.tr,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: selected
                ? Get.theme.textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Get.find<AppController>().darkMode
                        ? null
                        : Colors.white,
                  )
                : Get.theme.textTheme.labelSmall!.copyWith(
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.5)
                        : AppLightColors.primaryColor,
                  ),
          ),
        ),
      ),
    );
  }
}
