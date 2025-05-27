import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class BottomSheetHeader extends StatelessWidget {
  final String? title;
  const BottomSheetHeader({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite.withOpacity(0.4)
                    : AppLightColors.secondary,
                borderRadius: BorderRadius.circular(30)),
            width: 9 * (w / 100),
            height: 1.2 * (w / 100),
          ),
          SizedBox(
            height: 3.9 * (w / 100),
          ),
          Text(
            title?.tr ?? "",
            style: Get.theme.textTheme.titleLarge!.copyWith(
                color: Get.find<AppController>().darkMode
                    ? AppDarkColors.pureWhite
                    : Colors.black,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 2.48 * (w / 100),
          ),
        ],
      ),
    );
  }
}
