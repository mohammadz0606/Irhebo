import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/presentation/widgets/app_icon.dart';

class FilterRateWidget extends StatelessWidget {
  final Function(int rate) onChange;
  final int currentRate;
  const FilterRateWidget(
      {super.key, required this.onChange, required this.currentRate});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i <= 5; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => onChange(i),
                child: AppIcon(
                  width: 6.96 * (w / 100),
                  height: 6.96 * (w / 100),
                  path: AppIcons.star,
                  color: i <= currentRate
                      ? null
                      : Get.find<AppController>().darkMode
                          ? Colors.grey
                          : Colors.grey[300],
                  // isSvg: false,
                ),
              ),
              SizedBox(
                width: 2 * (w / 100),
              )
            ],
          )
      ],
    );
  }
}
