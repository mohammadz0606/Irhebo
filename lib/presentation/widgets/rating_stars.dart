import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class RatingStars extends StatelessWidget {
  final int count;
  const RatingStars({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++)
          AppIcon(
            path: AppIcons.star,
            padding: EdgeInsets.symmetric(horizontal: 2),
            color: (count - (i + 1)) >= 0
                ? null
                : Get.find<AppController>().darkMode
                    ? AppDarkColors.greyBody
                    : Colors.grey[400],
            width: 4.47 * (w / 100),
            height: 4.47 * (w / 100),
          ),
      ],
    );
  }
}
