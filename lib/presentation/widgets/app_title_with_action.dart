import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class AppTitleWithAction extends StatelessWidget {
  final String title;
  final String? action;
  final bool services;
  final Function()? onTapAction;

  const AppTitleWithAction({
    super.key,
    required this.title,
    this.action,
    this.services = false,
    this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: services
          ? EdgeInsets.symmetric(vertical: 2.48 * (w / 100))
          : EdgeInsets.only(
              top: 3.48 * (w / 100),
              right: 3.98 * (w / 100),
              left: 3.98 * (w / 100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: Get.theme.textTheme.titleLarge!.copyWith(
              color: Get.find<AppController>().darkMode
                  ? AppDarkColors.pureWhite
                  : Colors.black,
            ),
          ),
          InkWell(
            onTap: () => onTapAction!(),
            child: Text(
              action?.tr ?? "",
              style: Get.theme.textTheme.labelSmall!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
