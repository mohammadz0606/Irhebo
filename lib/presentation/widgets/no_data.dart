// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class NoData extends StatelessWidget {
  final bool forHome;
  final bool enableSpace;

  const NoData({
    super.key,
    this.forHome = true,
    this.enableSpace = true,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!forHome)
          if(enableSpace)
            SizedBox(
              height: 30 * (w / 100),
            ),
        SizedBox(
            // color: Colors.amber,
            height: forHome ? 40 * (w / 100) : 80.2 * (w / 100),
            child: AppIcon(
              path: AppIcons.noData,
              color: Get.find<AppController>().darkMode
                  ? null
                  : AppLightColors.primaryColor.withOpacity(0.5),
            )),
        if (!forHome)
          Text(
            "No results found".tr,
            style: Get.theme.textTheme.titleMedium,
          ),
      ],
    ));
  }
}
