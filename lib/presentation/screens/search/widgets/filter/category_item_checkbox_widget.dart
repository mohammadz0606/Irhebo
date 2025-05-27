import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_controller.dart';
import 'package:irhebo/app/resources/style/colors.dart';
import 'package:irhebo/domain/models/home_model.dart';

class CategoryItemCheckboxWidget extends StatelessWidget {
  final FilterModel filter;
  final Function(bool?) onTap;
  const CategoryItemCheckboxWidget(
      {super.key, required this.filter, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(filter.title ?? "", style: Get.theme.textTheme.labelLarge!),
        SizedBox(
          width: 4.97 * (w / 100),
          height: 4.97 * (w / 100),
          child: Checkbox(
            activeColor: Get.find<AppController>().darkMode
                ? AppDarkColors.greenContainer
                : AppLightColors.secondary,
            value: filter.checked,
            onChanged: onTap,
          ),
        )
      ],
    );
  }
}
