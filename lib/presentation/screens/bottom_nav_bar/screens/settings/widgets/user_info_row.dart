import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class UserInfoRow extends StatelessWidget {
  final String title;
  final String? desciption;
  final bool update;

  const UserInfoRow(
      {super.key, required this.title, this.desciption, this.update = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.48 * (w / 100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: Get.theme.textTheme.labelSmall,
          ),
          update
              ? AppIcon(
                  path: AppIcons.arrowRight,
                  matchTextDirection: true,
                  width: 5 * (w / 100),
                  height: 5 * (w / 100),
                )
              //  AppIcon(path: AppIcons.next)
              : Text(
                  desciption ?? "",
                  style: Get.theme.textTheme.labelSmall,
                ),
        ],
      ),
    );
  }
}
