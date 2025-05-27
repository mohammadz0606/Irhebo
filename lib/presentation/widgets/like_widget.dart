// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_dialog.dart';
import 'package:irhebo/presentation/widgets/decorated_icon.dart';
import 'package:irhebo/presentation/widgets/login_required_dialog.dart';

class LikeWidget extends StatelessWidget {
  final bool liked;
  final Function() onTap;
  final Color? color;

  const LikeWidget({
    super.key,
    required this.liked,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (Get.find<AppController>().token.isEmpty) {
          Get.dialog(
            barrierColor: AppDarkColors.darkContainer.withOpacity(0.3),
            AppDialog(
              child: LoginRequiredDialog(),
            ),
          );
        } else {
          onTap();
        }
      },
      child: DecoratedIcon(
        width: 8.2 * (w / 100),
        height: 8.2 * (w / 100),
        padding: 1.69 * (w / 100),
        color: color?.withOpacity(0.31) ??
            (Get.find<AppController>().darkMode
                ? AppDarkColors.primaryColor.withOpacity(0.31)
                : AppLightColors.secondary),
        imagePath: liked ? AppIcons.heart : AppIcons.emptyHeart,
        svgColor: color ?? AppDarkColors.primaryColor,
      ),
    );
  }
}
