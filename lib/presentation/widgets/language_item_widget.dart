import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';

class LanguageItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool language;
  final bool selected;
  final void Function() onTap;
  const LanguageItemWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon,
      this.selected = false,
      this.language = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => onTap(),
      child: Stack(
        children: [
          Container(
            height: 58.45 * (w / 100),
            width: 42.53 * (w / 100),
            decoration: selected
                ? AppDecoration.getGradientWithRadius(
                    dark: Get.find<AppController>().darkMode,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer2
                        : AppLightColors.unSelected)
                : AppDecoration.getDecorationWithRadius(
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer2
                        : AppLightColors.unSelected),
          ),
          PositionedDirectional(
            bottom: 3.48 * (w / 100),
            start: 2.23 * (w / 100),
            child: SizedBox(
              width: 24 * (w / 100),
              child: Text(
                language ? title : title.tr,
                style: Get.theme.textTheme.headlineSmall,
              ),
            ),
          ),
          PositionedDirectional(
              end: 2.23 * (w / 100),
              top: 3.48 * (w / 100),
              child: DecoratedIcon(
                imagePath: icon,
                language: language,
              ))
        ],
      ),
    );
  }
}
