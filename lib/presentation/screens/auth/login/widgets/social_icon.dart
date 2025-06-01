import 'package:flutter/material.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/resources/style/decoration.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class SocialIcon extends StatelessWidget {
  final bool linkedin;
  final Function() onTap;
  const SocialIcon({super.key, this.linkedin = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        height: 11.19 * (w / 100),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        decoration: AppDecoration.getContainerWithBorder(
            color: linkedin ? AppDarkColors.linkedin : null,
            borderColor: linkedin ? null : AppDarkColors.borderColor),
        child: AppIcon(
          //width: 6.46 * (w / 100),
          height: 20 * (w / 100),
          padding: EdgeInsets.symmetric(
              vertical: 2.48 * (w / 100), horizontal: 16.9 * (w / 100)),
         // path: linkedin ? AppImages.linkedin : AppImages.google,
          path:AppImages.google,
          isSvg: false,
        ),
      ),
    );
  }
}
