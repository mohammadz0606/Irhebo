import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/app/router/routes.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class BotFloatingButton extends StatelessWidget {
  // final bool isGuest;
  const BotFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.chat, arguments: {
        "chat_type": ChatType.Bot,
        'chat_bot_type': ChatBotType.service,
      }),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.5 * (w / 100),
          vertical: 0.66 * (h / 100),
        ),
        decoration: BoxDecoration(
          color: Get.find<AppController>().darkMode
              ? AppDarkColors.greenContainer
              : AppLightColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 15.7 * (w / 100),
          height: 7.25 * (h / 100),
          padding: EdgeInsets.symmetric(
              horizontal: 3.6 * (w / 100), vertical: 1.67 * (h / 100)),
          decoration: BoxDecoration(
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.darkContainer2
                : AppLightColors.secondary,
            shape: BoxShape.circle,
          ),
          child: AppIcon(
            path: AppIcons.outlinedAi,
            color: Get.find<AppController>().darkMode
                ? AppDarkColors.greenContainer
                : AppLightColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
