// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class IndicatorItem extends StatelessWidget {
  final bool selected;
  const IndicatorItem({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return CircleAvatar(
      backgroundColor: selected
          ? Get.find<AppController>().darkMode
              ? AppDarkColors.greenContainer
              : AppLightColors.primaryColor
          : AppDarkColors.unselected,
      radius: 4,
    );
  }
}
