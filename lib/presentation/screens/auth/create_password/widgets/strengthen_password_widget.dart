import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';

class StrengthenPasswordWidget extends StatelessWidget {
  final int score;
  const StrengthenPasswordWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(children: [
      for (int i = 0; i < 4; i++)
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.3 * (w / 100)),
            child: Container(
              height: 1 * (w / 100),
              decoration: BoxDecoration(
                  color: i < score
                      ? AppDarkColors.strengthenColorsList[i]
                      : Get.find<AppController>().darkMode
                          ? AppDarkColors.greyLabel
                          : Colors.grey[400],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )
    ]);
  }
}
