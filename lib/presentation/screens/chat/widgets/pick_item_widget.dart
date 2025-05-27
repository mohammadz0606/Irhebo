import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class PickItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onTap;
  const PickItemWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Card(
      color: Get.find<AppController>().darkMode
          ? AppDarkColors.darkContainer
          : AppLightColors.secondary,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
          vertical: 2 * (w / 100), horizontal: 3.98 * (w / 100)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(),
        child: Container(
          width: 100 * (w / 100),
          padding: EdgeInsets.symmetric(
              vertical: 2.48 * (w / 100), horizontal: 3.98 * (w / 100)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(2 * (w / 100)),
                decoration: BoxDecoration(
                  color: AppDarkColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppIcon(
                    path: icon,
                    width: 6 * (w / 100),
                    height: 6 * (w / 100),
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.pureWhite.withOpacity(0.5)
                        : AppLightColors.pureWhite,
                  ),
                ),
              ),
              SizedBox(width: 4 * (w / 100)),
              Text(
                title.tr,
                style: Get.theme.textTheme.labelMedium?.copyWith(
                    color: Get.find<AppController>().darkMode
                        ? null
                        : Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
